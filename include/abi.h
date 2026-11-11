// Generated packed Goose ABI for the separately compiled TinyCC exports.
#ifndef GOOSE_RAYLIB_ABI_H
#define GOOSE_RAYLIB_ABI_H
#include <stdint.h>
#pragma pack(push, 1)
typedef struct { uint8_t *data; int64_t len; } sl_u8;
typedef struct {
    float x_g;
    float y_g;
} raylib_Vector2_g6;
typedef struct {
    float x_g;
    float y_g;
    float z_g;
} raylib_Vector3_g6;
typedef struct {
    float x_g;
    float y_g;
    float z_g;
    float w_g;
} raylib_Vector4_g6;
typedef struct {
    float m0_g;
    float m4_g;
    float m8_g;
    float m12_g;
    float m1_g;
    float m5_g;
    float m9_g;
    float m13_g;
    float m2_g;
    float m6_g;
    float m10_g;
    float m14_g;
    float m3_g;
    float m7_g;
    float m11_g;
    float m15_g;
} raylib_Matrix_g6;
typedef struct {
    uint8_t r_g;
    uint8_t g_g;
    uint8_t b_g;
    uint8_t a_g;
} raylib_Color_g6;
typedef struct {
    float x_g;
    float y_g;
    float width_g;
    float height_g;
} raylib_Rectangle_g6;
typedef struct {
    uint64_t data_g;
    int32_t width_g;
    int32_t height_g;
    int32_t mipmaps_g;
    int32_t format_g;
} raylib_Image_g6;
typedef struct {
    uint32_t id_g;
    int32_t width_g;
    int32_t height_g;
    int32_t mipmaps_g;
    int32_t format_g;
} raylib_Texture_g6;
typedef struct {
    uint32_t id_g;
    raylib_Texture_g6 texture_g;
    raylib_Texture_g6 depth_g;
} raylib_RenderTexture_g6;
typedef struct {
    raylib_Rectangle_g6 source_g;
    int32_t left_g;
    int32_t top_g;
    int32_t right_g;
    int32_t bottom_g;
    int32_t layout_g;
} raylib_NPatchInfo_g6;
typedef struct {
    int32_t value_g;
    int32_t offset_x_g;
    int32_t offset_y_g;
    int32_t advance_x_g;
    raylib_Image_g6 image_g;
} raylib_GlyphInfo_g6;
typedef struct {
    int32_t base_size_g;
    int32_t glyph_count_g;
    int32_t glyph_padding_g;
    raylib_Texture_g6 texture_g;
    uint64_t recs_g;
    uint64_t glyphs_g;
} raylib_Font_g6;
typedef struct {
    raylib_Vector3_g6 position_g;
    raylib_Vector3_g6 target_g;
    raylib_Vector3_g6 up_g;
    float fovy_g;
    int32_t projection_g;
} raylib_Camera3D_g6;
typedef struct {
    raylib_Vector2_g6 offset_g;
    raylib_Vector2_g6 target_g;
    float rotation_g;
    float zoom_g;
} raylib_Camera2D_g6;
typedef struct {
    int32_t vertex_count_g;
    int32_t triangle_count_g;
    uint64_t vertices_g;
    uint64_t texcoords_g;
    uint64_t texcoords2_g;
    uint64_t normals_g;
    uint64_t tangents_g;
    uint64_t colors_g;
    uint64_t indices_g;
    int32_t bone_count_g;
    uint64_t bone_indices_g;
    uint64_t bone_weights_g;
    uint64_t anim_vertices_g;
    uint64_t anim_normals_g;
    uint32_t vao_id_g;
    uint64_t vbo_id_g;
} raylib_Mesh_g6;
typedef struct {
    uint32_t id_g;
    uint64_t locs_g;
} raylib_Shader_g6;
typedef struct {
    raylib_Texture_g6 texture_g;
    raylib_Color_g6 color_g;
    float value_g;
} raylib_MaterialMap_g6;
typedef struct { float e[4]; } a4_f32;
typedef struct {
    raylib_Shader_g6 shader_g;
    uint64_t maps_g;
    a4_f32 params_g;
} raylib_Material_g6;
typedef struct {
    raylib_Vector3_g6 translation_g;
    raylib_Vector4_g6 rotation_g;
    raylib_Vector3_g6 scale_g;
} raylib_Transform_g6;
typedef struct { uint8_t e[32]; } a32_u8;
typedef struct {
    a32_u8 name_g;
    int32_t parent_g;
} raylib_BoneInfo_g6;
typedef struct {
    int32_t bone_count_g;
    uint64_t bones_g;
    uint64_t bind_pose_g;
} raylib_ModelSkeleton_g6;
typedef struct {
    raylib_Matrix_g6 transform_g;
    int32_t mesh_count_g;
    int32_t material_count_g;
    uint64_t meshes_g;
    uint64_t materials_g;
    uint64_t mesh_material_g;
    raylib_ModelSkeleton_g6 skeleton_g;
    uint64_t current_pose_g;
    uint64_t bone_matrices_g;
} raylib_Model_g6;
typedef struct {
    a32_u8 name_g;
    int32_t bone_count_g;
    int32_t keyframe_count_g;
    uint64_t keyframe_poses_g;
} raylib_ModelAnimation_g6;
typedef struct {
    raylib_Vector3_g6 position_g;
    raylib_Vector3_g6 direction_g;
} raylib_Ray_g6;
typedef struct {
    uint8_t hit_g;
    float distance_g;
    raylib_Vector3_g6 point_g;
    raylib_Vector3_g6 normal_g;
} raylib_RayCollision_g6;
typedef struct {
    raylib_Vector3_g6 min_g;
    raylib_Vector3_g6 max_g;
} raylib_BoundingBox_g6;
typedef struct {
    uint32_t frame_count_g;
    uint32_t sample_rate_g;
    uint32_t sample_size_g;
    uint32_t channels_g;
    uint64_t data_g;
} raylib_Wave_g6;
typedef struct {
    uint64_t buffer_g;
    uint64_t processor_g;
    uint32_t sample_rate_g;
    uint32_t sample_size_g;
    uint32_t channels_g;
} raylib_AudioStream_g6;
typedef struct {
    raylib_AudioStream_g6 stream_g;
    uint32_t frame_count_g;
} raylib_Sound_g6;
typedef struct {
    raylib_AudioStream_g6 stream_g;
    uint32_t frame_count_g;
    uint8_t looping_g;
    int32_t ctx_type_g;
    uint64_t ctx_data_g;
} raylib_Music_g6;
typedef struct {
    int32_t h_resolution_g;
    int32_t v_resolution_g;
    float h_screen_size_g;
    float v_screen_size_g;
    float eye_to_screen_distance_g;
    float lens_separation_distance_g;
    float interpupillary_distance_g;
    a4_f32 lens_distortion_values_g;
    a4_f32 chroma_ab_correction_g;
} raylib_VrDeviceInfo_g6;
typedef struct { raylib_Matrix_g6 e[2]; } a2_raylib_Matrix_g6;
typedef struct { float e[2]; } a2_f32;
typedef struct {
    a2_raylib_Matrix_g6 projection_g;
    a2_raylib_Matrix_g6 view_offset_g;
    a2_f32 left_lens_center_g;
    a2_f32 right_lens_center_g;
    a2_f32 left_screen_center_g;
    a2_f32 right_screen_center_g;
    a2_f32 scale_g;
    a2_f32 scale_in_g;
} raylib_VrStereoConfig_g6;
typedef struct {
    uint32_t count_g;
    uint64_t paths_g;
} raylib_FilePathList_g6;
typedef struct { int32_t e[4]; } a4_i32;
typedef struct {
    uint32_t frame_g;
    uint32_t type__g;
    a4_i32 params_g;
} raylib_AutomationEvent_g6;
typedef struct {
    uint32_t capacity_g;
    uint32_t count_g;
    uint64_t events_g;
} raylib_AutomationEventList_g6;
typedef struct { float e[3]; } a3_f32;
typedef struct {
    a3_f32 v_g;
} raylib_Float3_g6;
typedef struct { float e[16]; } a16_f32;
typedef struct {
    a16_f32 v_g;
} raylib_Float16_g6;
#pragma pack(pop)
#endif
