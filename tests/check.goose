import raylib from "..";
import math;

fn near(a: f32, b: f32) { assert(abs(a - b) < 0.0001); }

fn main() {
    raylib::set_trace_log_level(raylib::LOG_WARNING);
    let c = raylib::get_color(0x12345678);
    assert(c.r == 18 && c.g == 52 && c.b == 86 && c.a == 120);
    assert(raylib::color_to_int(c) as u32 == 0x12345678);
    let faded = raylib::fade(raylib::Color { 9, 27, 83, 255 }, 0.5);
    assert(faded.r == 9 && faded.g == 27 && faded.b == 83 && faded.a == 127);

    let v = raylib::vector2_add(raylib::Vector2 { 2.0, -3.0 }, raylib::Vector2 { 5.0, 11.0 });
    assert(v.x == 7.0 && v.y == 8.0);
    let cross = raylib::vector3_cross_product(raylib::Vector3 { 1.0, 2.0, 3.0 }, raylib::Vector3 { -4.0, 5.0, 6.0 });
    assert(cross.x == -3.0 && cross.y == -18.0 && cross.z == 13.0);
    let m = raylib::matrix_translate(2.0, -3.0, 5.0);
    let p = raylib::vector3_transform(raylib::Vector3 { 7.0, 11.0, -13.0 }, m);
    assert(p.x == 9.0 && p.y == 8.0 && p.z == -8.0);
    let floats = raylib::matrix_to_float_v(m);
    assert(floats.v[12] == 2.0 && floats.v[13] == -3.0 && floats.v[14] == 5.0 && floats.v[15] == 1.0);
    var translation = raylib::Vector3 { .. };
    var rotation = raylib::Quaternion { .. };
    var scale = raylib::Vector3 { .. };
    raylib::matrix_decompose(m, translation, rotation, scale);
    assert(translation.x == 2.0 && translation.y == -3.0 && translation.z == 5.0);
    near(rotation.w, 1.0);
    near(scale.x, 1.0);

    let a = raylib::Rectangle { 1.0, 2.0, 4.0, 6.0 };
    assert(raylib::check_collision_recs(a, raylib::Rectangle { 4.0, 7.0, 5.0, 2.0 }));
    assert(!raylib::check_collision_recs(a, raylib::Rectangle { 5.0, 2.0, 5.0, 2.0 }));
    let overlap = raylib::get_collision_rec(a, raylib::Rectangle { 4.0, 7.0, 5.0, 2.0 });
    assert(overlap.x == 4.0 && overlap.y == 7.0 && overlap.width == 1.0 && overlap.height == 1.0);
    // RayCollision's bool followed by floats has a different native C layout.
    let ray = raylib::Ray { position: raylib::Vector3 { 2.0, 3.0, 10.0 }, direction: raylib::Vector3 { 0.0, 0.0, -1.0 } };
    let hit = raylib::get_ray_collision_sphere(ray, raylib::Vector3 { 2.0, 3.0, 1.0 }, 2.0);
    assert(hit.hit);
    near(hit.distance, 7.0);
    near(hit.point.x, 2.0); near(hit.point.y, 3.0); near(hit.point.z, 3.0);
    near(hit.normal.z, 1.0);
    let miss = raylib::get_ray_collision_sphere(ray, raylib::Vector3 { -8.0, 3.0, 1.0 }, 2.0);
    assert(!miss.hit);

    var image = raylib::gen_image_color(7, 5, c);
    defer raylib::unload_image(image);
    assert(raylib::is_image_valid(image));
    raylib::image_draw_pixel(image, 6, 4, raylib::BLUE);
    assert(raylib::get_image_color(image, 6, 4) == raylib::BLUE);
    assert(raylib::get_image_color(image, 5, 4) == c);
    raylib::image_crop(image, raylib::Rectangle { 4.0, 3.0, 3.0, 2.0 });
    assert(image.width == 3 && image.height == 2);
    assert(raylib::get_image_color(image, 2, 1) == raylib::BLUE);
    assert(raylib::export_image(image, "roundtrip.png"));
    let loaded = raylib::load_image("roundtrip.png");
    defer raylib::unload_image(loaded);
    assert(loaded.width == 3 && loaded.height == 2);
    assert(raylib::get_image_color(loaded, 2, 1) == raylib::BLUE);
    let copied = raylib::image_copy(loaded);
    defer raylib::unload_image(copied);
    assert(copied.data != loaded.data);

    // Text is terminated even when the argument is a slice inside a longer string.
    let text = "prefix-world-suffix";
    assert(raylib::text_length(text[7..12]) == 5);
    assert(raylib::text_length("") == 0);
    assert(raylib::text_length("ab\0cd") == 2);
    let first = raylib::text_format("literal %s %n 100%");
    let second = raylib::text_format("different");
    assert(first == "literal %s %n 100%" && second == "different");
    assert(raylib::get_file_extension("name.tar.gz") == ".gz");
    assert(raylib::get_file_name("dir/file.txt") == "file.txt");

    // Wave has native padding after three u32 fields, before its pointer.
    var wave = raylib::load_wave("tone.wav");
    defer raylib::unload_wave(wave);
    assert(raylib::is_wave_valid(wave));
    assert(wave.frame_count == 32 && wave.sample_rate == 8000 && wave.sample_size == 16 && wave.channels == 1);
    raylib::wave_crop(wave, 3, 19);
    assert(wave.frame_count == 16);
    assert(raylib::export_wave(wave, "cropped.wav"));
    let memory = raylib::mem_alloc_raw(17);
    assert(memory != 0);
    raylib::mem_free_raw(memory);
}
