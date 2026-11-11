import raylib from "..";
import std;
import os;

fn main() {
    // Optional finite run for capture: -- --frames 3 screenshot.png
    let argv = args();
    var frames = -1;
    if argv.len == 4 && argv[1] == "--frames" {
        let count, ok = parse_int(argv[2]);
        assert(ok && count > 0);
        frames = count;
    }
    raylib::init_window(800, 450, "Goose + raylib");
    defer raylib::close_window();
    assert(raylib::is_window_ready());
    raylib::set_target_fps(60);
    while frames != 0 && !raylib::window_should_close() {
        raylib::begin_drawing();
        raylib::clear_background(raylib::Color { 20, 25, 38, 255 });
        raylib::draw_text("Goose + raylib", 40, 35, 36, raylib::RAYWHITE);
        raylib::draw_text("Native drawing. Goose syntax.", 42, 88, 20, raylib::LIGHTGRAY);
        raylib::draw_rectangle(45, 155, 180, 180, raylib::SKYBLUE);
        raylib::draw_circle(400, 245, 90.0, raylib::ORANGE);
        raylib::draw_triangle(raylib::Vector2 { 650.0, 155.0 }, raylib::Vector2 { 560.0, 335.0 }, raylib::Vector2 { 740.0, 335.0 }, raylib::LIME);
        raylib::draw_text("Press Escape to close", 42, 395, 18, raylib::GRAY);
        raylib::end_drawing();
        if frames > 0 {
            frames -= 1;
            if frames == 0 {
                let image = raylib::load_image_from_screen();
                defer raylib::unload_image(image);
                assert(raylib::export_image(image, argv[3]));
            }
        }
    }
}
