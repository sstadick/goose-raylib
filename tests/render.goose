import raylib from "..";

fn main() {
    raylib::set_trace_log_level(raylib::LOG_WARNING);
    raylib::set_config_flags(raylib::FLAG_WINDOW_HIDDEN as u32);
    raylib::init_window(320, 240, "Goose raylib pixel tests");
    defer raylib::close_window();
    assert(raylib::is_window_ready());
    assert(raylib::get_screen_width() == 320 && raylib::get_screen_height() == 240);
    assert(!raylib::is_key_down(raylib::KEY_A));
    assert(!raylib::is_mouse_button_down(raylib::MOUSE_BUTTON_LEFT));

    let image = raylib::gen_image_color(8, 4, raylib::GREEN);
    defer raylib::unload_image(image);
    let texture = raylib::load_texture_from_image(image);
    defer raylib::unload_texture(texture);
    assert(raylib::is_texture_valid(texture));
    assert(texture.width == 8 && texture.height == 4);
    let target = raylib::load_render_texture(64, 48);
    defer raylib::unload_render_texture(target);
    assert(raylib::is_render_texture_valid(target));

    raylib::begin_texture_mode(target);
    raylib::clear_background(raylib::BLACK);
    raylib::draw_rectangle(3, 5, 13, 9, raylib::RED);
    raylib::draw_texture(texture, 30, 20, raylib::WHITE);
    raylib::draw_circle(50, 35, 5.0, raylib::BLUE);
    raylib::end_texture_mode();
    var pixels = raylib::load_image_from_texture(target.texture);
    defer raylib::unload_image(pixels);
    // Framebuffer textures read back bottom-up.
    raylib::image_flip_vertical(pixels);
    assert(raylib::get_image_color(pixels, 2, 5) == raylib::BLACK);
    assert(raylib::get_image_color(pixels, 3, 5) == raylib::RED);
    assert(raylib::get_image_color(pixels, 15, 13) == raylib::RED);
    assert(raylib::get_image_color(pixels, 16, 13) == raylib::BLACK);
    assert(raylib::get_image_color(pixels, 30, 20) == raylib::GREEN);
    assert(raylib::get_image_color(pixels, 37, 23) == raylib::GREEN);
    assert(raylib::get_image_color(pixels, 38, 23) == raylib::BLACK);
    assert(raylib::get_image_color(pixels, 50, 35) == raylib::BLUE);

    let font = raylib::get_font_default();
    assert(raylib::is_font_valid(font));
    let measured = raylib::measure_text_ex(font, "Goose", 20.0, 1.0);
    assert(measured.x > 20.0 && measured.y == 20.0);
    // Nested cameras and matrices also pass through the value adapters.
    let camera = raylib::Camera2D { offset: raylib::Vector2 { 10.0, 20.0 }, target: raylib::Vector2 { 2.0, 3.0 }, rotation: 0.0, zoom: 2.0 };
    let screen = raylib::get_world_to_screen2d(raylib::Vector2 { 5.0, 7.0 }, camera);
    assert(screen.x == 16.0 && screen.y == 28.0);

    // The model owns the generated mesh. Unload only the model, not both.
    let model = raylib::load_model_from_mesh(raylib::gen_mesh_cube(2.0, 2.0, 2.0));
    defer raylib::unload_model(model);
    assert(raylib::is_model_valid(model));
    let bounds = raylib::get_model_bounding_box(model);
    assert(bounds.min.x == -1.0 && bounds.max.z == 1.0);
    let camera3d = raylib::Camera3D {
        position: raylib::Vector3 { 3.0, 2.0, 4.0 }, target: raylib::Vector3 { .. },
        up: raylib::Vector3 { 0.0, 1.0, 0.0 }, fovy: 45.0, projection: raylib::CAMERA_PERSPECTIVE,
    };
    raylib::begin_texture_mode(target);
    raylib::clear_background(raylib::BLACK);
    raylib::begin_mode3d(camera3d);
    raylib::draw_model(model, raylib::Vector3 { .. }, 1.0, raylib::RED);
    raylib::end_mode3d();
    raylib::end_texture_mode();
    let cube_pixels = raylib::load_image_from_texture(target.texture);
    defer raylib::unload_image(cube_pixels);
    assert(raylib::get_image_color(cube_pixels, 32, 24) == raylib::RED);
    assert(raylib::get_image_color(cube_pixels, 0, 0) == raylib::BLACK);

    raylib::begin_drawing();
    raylib::clear_background(raylib::BLACK);
    raylib::draw_text_ex(font, "Goose", raylib::Vector2 { 10.0, 10.0 }, 20.0, 1.0, raylib::WHITE);
    raylib::end_drawing();
}
