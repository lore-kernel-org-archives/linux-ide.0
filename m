From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3][pata-2.6] ide: make /proc/ide/ optional
Date: Thu, 08 Feb 2007 04:10:55 +0100
Message-ID: <20070208031055.2771.34444.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:8745 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933359AbXBHDFq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 22:05:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so360624uga
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2007 19:05:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: make /proc/ide/ optional

All important information/features should be already available through
sysfs and ioctl interfaces.

Add CONFIG_IDE_PROC_FS (CONFIG_SCSI_PROC_FS rip-off) config option,
disabling it makes IDE driver ~5 kB smaller (on x86-32).

While at it add CONFIG_PROC_FS=n versions of proc_ide_{create,destroy}()
and remove no longer needed #ifdefs.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/Kconfig        |   11 +++++++++++
 drivers/ide/Makefile       |    2 +-
 drivers/ide/ide-cd.c       |    4 ++--
 drivers/ide/ide-disk.c     |    4 ++--
 drivers/ide/ide-floppy.c   |    4 ++--
 drivers/ide/ide-tape.c     |    2 +-
 drivers/ide/ide.c          |   15 ++++++---------
 drivers/ide/pci/alim15x3.c |    8 ++++----
 drivers/ide/pci/amd74xx.c  |    6 +++---
 drivers/ide/pci/cmd64x.c   |    8 ++++----
 drivers/ide/pci/sis5513.c  |    6 +++---
 drivers/scsi/ide-scsi.c    |    2 +-
 include/linux/ide.h        |   14 ++++++++------
 13 files changed, 48 insertions(+), 38 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -288,6 +288,17 @@ config IDE_TASK_IOCTL
 
 	  If you are unsure, say N here.
 
+config IDE_PROC_FS
+	bool "legacy /proc/ide/ support"
+	depends on IDE && PROC_FS
+	default y
+	help
+	  This option enables support for the various files in
+	  /proc/ide.  In Linux 2.6 this has been superseded by
+	  files in sysfs but many legacy applications rely on this.
+
+	  If unsure say Y.
+
 comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -20,7 +20,7 @@ ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci
 # Core IDE code - must come before legacy
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
-ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
+ide-core-$(CONFIG_IDE_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 ide-core-$(CONFIG_BLK_DEV_IDEACPI)	+= ide-acpi.o
 
Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3265,7 +3265,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 static
 sector_t ide_cdrom_capacity (ide_drive_t *drive)
 {
@@ -3312,7 +3312,7 @@ static void ide_cd_release(struct kref *
 
 static int ide_cd_probe(ide_drive_t *);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 static int proc_idecd_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -561,7 +561,7 @@ static sector_t idedisk_capacity (ide_dr
 	return drive->capacity64 - drive->sect0;
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 
 static int smart_enable(ide_drive_t *drive)
 {
@@ -685,7 +685,7 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #define	idedisk_proc	NULL
 
-#endif	/* CONFIG_PROC_FS */
+#endif	/* CONFIG_IDE_PROC_FS */
 
 static void idedisk_prepare_flush(request_queue_t *q, struct request *rq)
 {
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1892,7 +1892,7 @@ static void ide_floppy_release(struct kr
 	kfree(floppy);
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 
 static int proc_idefloppy_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
@@ -1914,7 +1914,7 @@ static ide_proc_entry_t idefloppy_proc[]
 
 #define	idefloppy_proc	NULL
 
-#endif	/* CONFIG_PROC_FS */
+#endif	/* CONFIG_IDE_PROC_FS */
 
 static int ide_floppy_probe(ide_drive_t *);
 
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4730,7 +4730,7 @@ static void ide_tape_release(struct kref
 	kfree(tape);
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 
 static int proc_idetape_read_name
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -356,7 +356,7 @@ static int ide_system_bus_speed(void)
 	return system_bus_speed;
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 struct proc_dir_entry *proc_ide_root;
 #endif
 
@@ -1882,7 +1882,7 @@ static void __init probe_for_hwifs (void
 
 void ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 	ide_add_proc_entries(drive->proc, driver->proc, drive);
 #endif
 }
@@ -1904,8 +1904,8 @@ EXPORT_SYMBOL(ide_register_subdriver);
 void ide_unregister_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
-	
-#ifdef CONFIG_PROC_FS
+
+#ifdef CONFIG_IDE_PROC_FS
 	ide_remove_proc_entries(drive->proc, driver->proc);
 #endif
 	down(&ide_setting_sem);
@@ -2057,7 +2057,7 @@ static int __init ide_init(void)
 
 	init_ide_data();
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 	proc_ide_root = proc_mkdir("ide", NULL);
 #endif
 
@@ -2087,9 +2087,8 @@ static int __init ide_init(void)
 	probe_for_hwifs();
 	initializing = 0;
 
-#ifdef CONFIG_PROC_FS
 	proc_ide_create();
-#endif
+
 	return 0;
 }
 
@@ -2129,9 +2128,7 @@ void __exit cleanup_module (void)
 	pnpide_exit();
 #endif
 
-#ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
-#endif
 
 	bus_unregister(&ide_bus_type);
 }
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -50,7 +50,7 @@ static u8 m5229_revision;
 static u8 chip_is_1543c_e;
 static struct pci_dev *isa_dev;
 
-#if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
@@ -278,7 +278,7 @@ static int ali_get_info (char *buffer, c
 
 	return p-buffer; /* => must be less than 4k! */
 }
-#endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 /**
  *	ali15x3_tune_pio	-	set up chipset for PIO mode
@@ -567,13 +567,13 @@ static unsigned int __devinit init_chips
 
 	isa_dev = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 
-#if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 	if (!ali_proc) {
 		ali_proc = 1;
 		bmide_dev = dev;
 		ide_pci_create_host_proc("ali", ali_get_info);
 	}
-#endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 	local_irq_save(flags);
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -92,7 +92,7 @@ static unsigned char amd_cyc2udma[] = { 
  * AMD /proc entry.
  */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -402,14 +402,14 @@ static unsigned int __devinit init_chips
  * Register /proc/ide/amd74xx entry
  */
 
-#if defined(DISPLAY_AMD_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_AMD_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
         if (!amd74xx_proc) {
                 amd_base = pci_resource_start(dev, 4);
                 bmide_dev = dev;
 		ide_pci_create_host_proc("amd74xx", amd74xx_get_info);
                 amd74xx_proc = 1;
         }
-#endif /* DISPLAY_AMD_TIMINGS && CONFIG_PROC_FS */
+#endif /* DISPLAY_AMD_TIMINGS && CONFIG_IDE_PROC_FS */
 
 	return dev->irq;
 }
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -76,7 +76,7 @@
 #define UDIDETCR1	0x7B
 #define DTPR1		0x7C
 
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
@@ -187,7 +187,7 @@ static int cmd64x_get_info (char *buffer
 	return p-buffer;	/* => must be less than 4k! */
 }
 
-#endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 /*
  * This routine writes the prepared setup/active/recovery counts
@@ -572,7 +572,7 @@ static unsigned int __devinit init_chips
 	(void) pci_write_config_byte(dev, UDIDETCR0, 0xf0);
 #endif /* CONFIG_PPC */
 
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 
 	cmd_devs[n_cmd_devs++] = dev;
 
@@ -580,7 +580,7 @@ static unsigned int __devinit init_chips
 		cmd64x_proc = 1;
 		ide_pci_create_host_proc("cmd64x", cmd64x_get_info);
 	}
-#endif /* DISPLAY_CMD64X_TIMINGS && CONFIG_PROC_FS */
+#endif /* DISPLAY_CMD64X_TIMINGS && CONFIG_IDE_PROC_FS */
 
 	return 0;
 }
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -191,7 +191,7 @@ static char* chipset_capability[] = {
 	"ATA 133 (1st gen)", "ATA 133 (2nd gen)"
 };
 
-#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
@@ -426,7 +426,7 @@ static int sis_get_info (char *buffer, c
 
 	return len > count ? count : len;
 }
-#endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 /*
  * Configuration functions
@@ -797,7 +797,7 @@ static unsigned int __devinit init_chips
 				break;
 		}
 
-#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
+#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 		if (!sis_proc) {
 			sis_proc = 1;
 			bmide_dev = dev;
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -770,7 +770,7 @@ static void ide_scsi_remove(ide_drive_t 
 
 static int ide_scsi_probe(ide_drive_t *);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 static ide_proc_entry_t idescsi_proc[] = {
 	{ "capacity", S_IFREG|S_IRUGO, proc_ide_read_capacity, NULL },
 	{ NULL, 0, NULL, NULL }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -910,15 +910,15 @@ typedef struct {
 	write_proc_t	*write_proc;
 } ide_proc_entry_t;
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_IDE_PROC_FS
 extern struct proc_dir_entry *proc_ide_root;
 
-extern void proc_ide_create(void);
-extern void proc_ide_destroy(void);
-extern void create_proc_ide_interfaces(void);
+void proc_ide_create(void);
+void proc_ide_destroy(void);
+void create_proc_ide_interfaces(void);
 void destroy_proc_ide_interface(ide_hwif_t *);
-extern void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
-extern void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);
+void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
+void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);
 read_proc_t proc_ide_read_capacity;
 read_proc_t proc_ide_read_geometry;
 
@@ -942,6 +942,8 @@ void ide_pci_create_host_proc(const char
 	return len;			\
 }
 #else
+static inline void proc_ide_create(void) { ; }
+static inline void proc_ide_destroy(void) { ; }
 static inline void create_proc_ide_interfaces(void) { ; }
 static inline void destroy_proc_ide_interface(ide_hwif_t *hwif) { ; }
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
