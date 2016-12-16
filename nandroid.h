#ifndef NANDROID_H
#define NANDROID_H

int nandroid_main(int argc, char** argv);
int bu_main(int argc, char** argv);

int nandroid_backup(const char* backup_path);
int nandroid_advanced_backup(const char* backup_path, int boot, int system, int data, int cache);
int nandroid_advanced_restore(const char* backup_path, int boot, int system, int data, int cache);
int nandroid_restore(const char* backup_path, int restore_boot, int restore_system, int restore_data, int restore_cache, int restore_sdext, int restore_wimax);

#ifdef BOARD_HAS_MTK_CPU
int nandroid_mtk_backup(const char* backup_path, int uboot, int logo, int nvram, int secro);
int nandroid_mtk_restore(const char* backup_path, int uboot, int logo, int nvram, int secro);
#endif

void finish_nandroid_job();
int user_cancel_nandroid(FILE **fp, const char* backup_file_image, int is_backup, int *nand_starts);

void nandroid_force_backup_format(const char* fmt);
unsigned int nandroid_get_default_backup_format();

#ifdef USE_CWM_GRAPHICS
unsigned long long Backup_Size;
unsigned long long Used_Size;
unsigned long long Before_Used_Size;
unsigned long long Free_Size;

void ui_increment_frame();

#define ui_nice_print(...) { ui_set_nice(1); ui_print(__VA_ARGS__); ui_set_nice(0); }
#endif /* USE_CWM_GRAPHICS */

#define NANDROID_HIDE_PROGRESS_FILE  "clockworkmod/.hidenandroidprogress"
#define NANDROID_BACKUP_FORMAT_FILE  "clockworkmod/.default_backup_format"
#define NANDROID_BACKUP_FORMAT_TAR 0
#define NANDROID_BACKUP_FORMAT_TGZ 1

#define NANDROID_ERROR_GENERAL 1

#endif
