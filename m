From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3][pata-2.6] ide: move IDE settings handling to ide-proc.c
Date: Thu, 08 Feb 2007 04:11:08 +0100
Message-ID: <20070208031108.2771.59628.sendpatchset@localhost.localdomain>
References: <20070208031055.2771.34444.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:8745 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965678AbXBHDGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 22:06:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so360624uga
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2007 19:05:59 -0800 (PST)
In-Reply-To: <20070208031055.2771.34444.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: move IDE settings handling to ide-proc.c

* move
	__ide_add_setting()
	ide_add_setting()
	__ide_remove_setting()
	auto_remove_settings()
	ide_find_setting_by_name()
	ide_read_setting()
	ide_write_setting()
	set_xfer_rate()
	ide_add_generic_settings()
	ide_register_subdriver()
	ide_unregister_subdriver()

  from ide.c to ide-proc.c

* set_{io_32bit,pio_mode,using_dma}() cannot be marked static now, fix it

* rename ide_[un]register_subdriver() to ide_proc_[un]register_driver(),
  update device drivers to use new names

* add CONFIG_IDE_PROC_FS=n versions of ide_proc_[un]register_driver()
  and ide_add_generic_settings()

* make ide_find_setting_by_name(), ide_{read,write}_setting()
  and ide_{add,remove}_proc_entries() static

* cover IDE settings code in device drivers with CONFIG_IDE_PROC_FS #ifdef,
  also while at it cover with CONFIG_IDE_PROC_FS #ifdef ide_driver_t.proc

* remove bogus comment from ide.h

* cover with CONFIG_IDE_PROC_FS #ifdef .proc and .settings in ide_drive_t

Besides saner code this patch results in the IDE core smaller by ~2 kB
(on x86-32) and IDE disk driver by ~1 kB (ditto) when CONFIG_IDE_PROC_FS=n.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-cd.c     |   14 +-
 drivers/ide/ide-disk.c   |   16 +-
 drivers/ide/ide-floppy.c |   16 +-
 drivers/ide/ide-proc.c   |  310 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-tape.c   |   17 +-
 drivers/ide/ide.c        |  313 -----------------------------------------------
 drivers/scsi/ide-scsi.c  |   16 +-
 include/linux/ide.h      |   39 +++--
 8 files changed, 378 insertions(+), 363 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3050,10 +3050,14 @@ int ide_cdrom_probe_capabilities (ide_dr
 	return nslots;
 }
 
+#ifdef CONFIG_IDE_PROC_FS
 static void ide_cdrom_add_settings(ide_drive_t *drive)
 {
 	ide_add_setting(drive, "dsc_overlap", SETTING_RW, TYPE_BYTE, 0, 1, 1, 1, &drive->dsc_overlap, NULL);
 }
+#else
+static inline void ide_cdrom_add_settings(ide_drive_t *drive) { ; }
+#endif
 
 /*
  * standard prep_rq_fn that builds 10 byte cmds
@@ -3282,7 +3286,7 @@ static void ide_cd_remove(ide_drive_t *d
 {
 	struct cdrom_info *info = drive->driver_data;
 
-	ide_unregister_subdriver(drive, info->driver);
+	ide_proc_unregister_driver(drive, info->driver);
 
 	del_gendisk(info->disk);
 
@@ -3327,8 +3331,6 @@ static ide_proc_entry_t idecd_proc[] = {
 	{ "capacity", S_IFREG|S_IRUGO, proc_idecd_read_capacity, NULL },
 	{ NULL, 0, NULL, NULL }
 };
-#else
-# define idecd_proc	NULL
 #endif
 
 static ide_driver_t ide_cdrom_driver = {
@@ -3346,7 +3348,9 @@ static ide_driver_t ide_cdrom_driver = {
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
+#ifdef CONFIG_IDE_PROC_FS
 	.proc			= idecd_proc,
+#endif
 };
 
 static int idecd_open(struct inode * inode, struct file * file)
@@ -3508,7 +3512,7 @@ static int ide_cd_probe(ide_drive_t *dri
 
 	ide_init_disk(g, drive);
 
-	ide_register_subdriver(drive, &ide_cdrom_driver);
+	ide_proc_register_driver(drive, &ide_cdrom_driver);
 
 	kref_init(&info->kref);
 
@@ -3525,7 +3529,7 @@ static int ide_cd_probe(ide_drive_t *dri
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
 		struct cdrom_device_info *devinfo = &info->devinfo;
-		ide_unregister_subdriver(drive, &ide_cdrom_driver);
+		ide_proc_unregister_driver(drive, &ide_cdrom_driver);
 		kfree(info->buffer);
 		kfree(info->toc);
 		kfree(info->changer_info);
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -562,7 +562,6 @@ static sector_t idedisk_capacity (ide_dr
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-
 static int smart_enable(ide_drive_t *drive)
 {
 	ide_task_t args;
@@ -680,11 +679,6 @@ static ide_proc_entry_t idedisk_proc[] =
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
-
-#else
-
-#define	idedisk_proc	NULL
-
 #endif	/* CONFIG_IDE_PROC_FS */
 
 static void idedisk_prepare_flush(request_queue_t *q, struct request *rq)
@@ -883,6 +877,7 @@ static int set_lba_addressing(ide_drive_
 	return 0;
 }
 
+#ifdef CONFIG_IDE_PROC_FS
 static void idedisk_add_settings(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -900,6 +895,9 @@ static void idedisk_add_settings(ide_dri
  	ide_add_setting(drive,	"failures",	SETTING_RW,	TYPE_INT,	0,	65535,			1,	1,	&drive->failures,	NULL);
  	ide_add_setting(drive,	"max_failures",	SETTING_RW,	TYPE_INT,	0,	65535,			1,	1,	&drive->max_failures,	NULL);
 }
+#else
+static inline void idedisk_add_settings(ide_drive_t *drive) { ; }
+#endif
 
 static void idedisk_setup (ide_drive_t *drive)
 {
@@ -1018,7 +1016,7 @@ static void ide_disk_remove(ide_drive_t 
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
-	ide_unregister_subdriver(drive, idkp->driver);
+	ide_proc_unregister_driver(drive, idkp->driver);
 
 	del_gendisk(g);
 
@@ -1083,7 +1081,9 @@ static ide_driver_t idedisk_driver = {
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
+#ifdef CONFIG_IDE_PROC_FS
 	.proc			= idedisk_proc,
+#endif
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -1259,7 +1259,7 @@ static int ide_disk_probe(ide_drive_t *d
 
 	ide_init_disk(g, drive);
 
-	ide_register_subdriver(drive, &idedisk_driver);
+	ide_proc_register_driver(drive, &idedisk_driver);
 
 	kref_init(&idkp->kref);
 
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1811,6 +1811,7 @@ static int idefloppy_identify_device (id
 	return 0;
 }
 
+#ifdef CONFIG_IDE_PROC_FS
 static void idefloppy_add_settings(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
@@ -1823,6 +1824,9 @@ static void idefloppy_add_settings(ide_d
 	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,		1,		1,	&drive->bios_sect,	NULL);
 	ide_add_setting(drive,	"ticks",	SETTING_RW,	TYPE_BYTE,	0,	255,		1,		1,	&floppy->ticks,		NULL);
 }
+#else
+static inline void idefloppy_add_settings(ide_drive_t *drive) { ; }
+#endif
 
 /*
  *	Driver initialization.
@@ -1873,7 +1877,7 @@ static void ide_floppy_remove(ide_drive_
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct gendisk *g = floppy->disk;
 
-	ide_unregister_subdriver(drive, floppy->driver);
+	ide_proc_unregister_driver(drive, floppy->driver);
 
 	del_gendisk(g);
 
@@ -1893,7 +1897,6 @@ static void ide_floppy_release(struct kr
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-
 static int proc_idefloppy_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -1909,11 +1912,6 @@ static ide_proc_entry_t idefloppy_proc[]
 	{ "geometry",	S_IFREG|S_IRUGO,	proc_ide_read_geometry,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
-
-#else
-
-#define	idefloppy_proc	NULL
-
 #endif	/* CONFIG_IDE_PROC_FS */
 
 static int ide_floppy_probe(ide_drive_t *);
@@ -1933,7 +1931,9 @@ static ide_driver_t idefloppy_driver = {
 	.end_request		= idefloppy_do_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
+#ifdef CONFIG_IDE_PROC_FS
 	.proc			= idefloppy_proc,
+#endif
 };
 
 static int idefloppy_open(struct inode *inode, struct file *filp)
@@ -2159,7 +2159,7 @@ static int ide_floppy_probe(ide_drive_t 
 
 	ide_init_disk(g, drive);
 
-	ide_register_subdriver(drive, &idefloppy_driver);
+	ide_proc_register_driver(drive, &idefloppy_driver);
 
 	kref_init(&floppy->kref);
 
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -3,6 +3,8 @@
  *
  *  Copyright (C) 1997-1998	Mark Lord
  *  Copyright (C) 2003		Red Hat <alan@redhat.com>
+ *
+ *  Some code was moved here from ide.c, see it for original copyrights.
  */
 
 /*
@@ -122,6 +124,265 @@ static int proc_ide_read_identify
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+/**
+ *	__ide_add_setting	-	add an ide setting option
+ *	@drive: drive to use
+ *	@name: setting name
+ *	@rw: true if the function is read write
+ *	@data_type: type of data
+ *	@min: range minimum
+ *	@max: range maximum
+ *	@mul_factor: multiplication scale
+ *	@div_factor: divison scale
+ *	@data: private data field
+ *	@set: setting
+ *	@auto_remove: setting auto removal flag
+ *
+ *	Removes the setting named from the device if it is present.
+ *	The function takes the settings_lock to protect against
+ *	parallel changes. This function must not be called from IRQ
+ *	context. Returns 0 on success or -1 on failure.
+ *
+ *	BUGS: This code is seriously over-engineered. There is also
+ *	magic about how the driver specific features are setup. If
+ *	a driver is attached we assume the driver settings are auto
+ *	remove.
+ */
+
+static int __ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set, int auto_remove)
+{
+	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
+
+	down(&ide_setting_sem);
+	while ((*p) && strcmp((*p)->name, name) < 0)
+		p = &((*p)->next);
+	if ((setting = kzalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
+		goto abort;
+	if ((setting->name = kmalloc(strlen(name) + 1, GFP_KERNEL)) == NULL)
+		goto abort;
+	strcpy(setting->name, name);
+	setting->rw = rw;
+	setting->data_type = data_type;
+	setting->min = min;
+	setting->max = max;
+	setting->mul_factor = mul_factor;
+	setting->div_factor = div_factor;
+	setting->data = data;
+	setting->set = set;
+
+	setting->next = *p;
+	if (auto_remove)
+		setting->auto_remove = 1;
+	*p = setting;
+	up(&ide_setting_sem);
+	return 0;
+abort:
+	up(&ide_setting_sem);
+	kfree(setting);
+	return -1;
+}
+
+int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+{
+	return __ide_add_setting(drive, name, rw, data_type, min, max, mul_factor, div_factor, data, set, 1);
+}
+
+EXPORT_SYMBOL(ide_add_setting);
+
+/**
+ *	__ide_remove_setting	-	remove an ide setting option
+ *	@drive: drive to use
+ *	@name: setting name
+ *
+ *	Removes the setting named from the device if it is present.
+ *	The caller must hold the setting semaphore.
+ */
+
+static void __ide_remove_setting (ide_drive_t *drive, char *name)
+{
+	ide_settings_t **p, *setting;
+
+	p = (ide_settings_t **) &drive->settings;
+
+	while ((*p) && strcmp((*p)->name, name))
+		p = &((*p)->next);
+	if ((setting = (*p)) == NULL)
+		return;
+
+	(*p) = setting->next;
+
+	kfree(setting->name);
+	kfree(setting);
+}
+
+/**
+ *	auto_remove_settings	-	remove driver specific settings
+ *	@drive: drive
+ *
+ *	Automatically remove all the driver specific settings for this
+ *	drive. This function may not be called from IRQ context. The
+ *	caller must hold ide_setting_sem.
+ */
+
+static void auto_remove_settings (ide_drive_t *drive)
+{
+	ide_settings_t *setting;
+repeat:
+	setting = drive->settings;
+	while (setting) {
+		if (setting->auto_remove) {
+			__ide_remove_setting(drive, setting->name);
+			goto repeat;
+		}
+		setting = setting->next;
+	}
+}
+
+/**
+ *	ide_find_setting_by_name	-	find a drive specific setting
+ *	@drive: drive to scan
+ *	@name: setting name
+ *
+ *	Scan's the device setting table for a matching entry and returns
+ *	this or NULL if no entry is found. The caller must hold the
+ *	setting semaphore
+ */
+
+static ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name)
+{
+	ide_settings_t *setting = drive->settings;
+
+	while (setting) {
+		if (strcmp(setting->name, name) == 0)
+			break;
+		setting = setting->next;
+	}
+	return setting;
+}
+
+/**
+ *	ide_read_setting	-	read an IDE setting
+ *	@drive: drive to read from
+ *	@setting: drive setting
+ *
+ *	Read a drive setting and return the value. The caller
+ *	must hold the ide_setting_sem when making this call.
+ *
+ *	BUGS: the data return and error are the same return value
+ *	so an error -EINVAL and true return of the same value cannot
+ *	be told apart
+ */
+
+static int ide_read_setting(ide_drive_t *drive, ide_settings_t *setting)
+{
+	int		val = -EINVAL;
+	unsigned long	flags;
+
+	if ((setting->rw & SETTING_READ)) {
+		spin_lock_irqsave(&ide_lock, flags);
+		switch(setting->data_type) {
+			case TYPE_BYTE:
+				val = *((u8 *) setting->data);
+				break;
+			case TYPE_SHORT:
+				val = *((u16 *) setting->data);
+				break;
+			case TYPE_INT:
+				val = *((u32 *) setting->data);
+				break;
+		}
+		spin_unlock_irqrestore(&ide_lock, flags);
+	}
+	return val;
+}
+
+/**
+ *	ide_write_setting	-	read an IDE setting
+ *	@drive: drive to read from
+ *	@setting: drive setting
+ *	@val: value
+ *
+ *	Write a drive setting if it is possible. The caller
+ *	must hold the ide_setting_sem when making this call.
+ *
+ *	BUGS: the data return and error are the same return value
+ *	so an error -EINVAL and true return of the same value cannot
+ *	be told apart
+ *
+ *	FIXME:  This should be changed to enqueue a special request
+ *	to the driver to change settings, and then wait on a sema for completion.
+ *	The current scheme of polling is kludgy, though safe enough.
+ */
+
+static int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (setting->set)
+		return setting->set(drive, val);
+	if (!(setting->rw & SETTING_WRITE))
+		return -EPERM;
+	if (val < setting->min || val > setting->max)
+		return -EINVAL;
+	if (ide_spin_wait_hwgroup(drive))
+		return -EBUSY;
+	switch (setting->data_type) {
+		case TYPE_BYTE:
+			*((u8 *) setting->data) = val;
+			break;
+		case TYPE_SHORT:
+			*((u16 *) setting->data) = val;
+			break;
+		case TYPE_INT:
+			*((u32 *) setting->data) = val;
+			break;
+	}
+	spin_unlock_irq(&ide_lock);
+	return 0;
+}
+
+static int set_xfer_rate (ide_drive_t *drive, int arg)
+{
+	int err;
+
+	if (arg < 0 || arg > 70)
+		return -EINVAL;
+
+	err = ide_wait_cmd(drive,
+			WIN_SETFEATURES, (u8) arg,
+			SETFEATURES_XFER, 0, NULL);
+
+	if (!err && arg) {
+		ide_set_xfer_rate(drive, (u8) arg);
+		ide_driveid_update(drive);
+	}
+	return err;
+}
+
+/**
+ *	ide_add_generic_settings	-	generic ide settings
+ *	@drive: drive being configured
+ *
+ *	Add the generic parts of the system settings to the /proc files.
+ *	The caller must not be holding the ide_setting_sem.
+ */
+
+void ide_add_generic_settings (ide_drive_t *drive)
+{
+/*
+ *			  drive		setting name		read/write access				data type	min	max				mul_factor	div_factor	data pointer			set function
+ */
+	__ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit,	0);
+	__ide_add_setting(drive,	"keepsettings",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL,		0);
+	__ide_add_setting(drive,	"nice1",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL,		0);
+	__ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode,	0);
+	__ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL,		0);
+	__ide_add_setting(drive,	"using_dma",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma,	0);
+	__ide_add_setting(drive,	"init_speed",		SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL,		0);
+	__ide_add_setting(drive,	"current_speed",	SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate,	0);
+	__ide_add_setting(drive,	"number",		SETTING_RW,					TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL,		0);
+}
+
 static void proc_ide_settings_warn(void)
 {
 	static int warned = 0;
@@ -404,7 +665,7 @@ static ide_proc_entry_t generic_drive_en
 	{ NULL,	0, NULL, NULL }
 };
 
-void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data)
+static void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data)
 {
 	struct proc_dir_entry *ent;
 
@@ -421,7 +682,7 @@ void ide_add_proc_entries(struct proc_di
 	}
 }
 
-void ide_remove_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p)
+static void ide_remove_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p)
 {
 	if (!dir || !p)
 		return;
@@ -431,6 +692,51 @@ void ide_remove_proc_entries(struct proc
 	}
 }
 
+void ide_proc_register_driver(ide_drive_t *drive, ide_driver_t *driver)
+{
+	ide_add_proc_entries(drive->proc, driver->proc, drive);
+}
+
+EXPORT_SYMBOL(ide_proc_register_driver);
+
+/**
+ *	ide_proc_unregister_driver	-	remove driver specific data
+ *	@drive: drive
+ *	@driver: driver
+ *
+ *	Clean up the driver specific /proc files and IDE settings
+ *	for a given drive.
+ *
+ *	Takes ide_setting_sem and ide_lock.
+ *	Caller must hold none of the locks.
+ */
+
+void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver)
+{
+	unsigned long flags;
+
+	ide_remove_proc_entries(drive->proc, driver->proc);
+
+	down(&ide_setting_sem);
+	spin_lock_irqsave(&ide_lock, flags);
+	/*
+	 * ide_setting_sem protects the settings list
+	 * ide_lock protects the use of settings
+	 *
+	 * so we need to hold both, ide_settings_sem because we want to
+	 * modify the settings list, and ide_lock because we cannot take
+	 * a setting out that is being used.
+	 *
+	 * OTOH both ide_{read,write}_setting are only ever used under
+	 * ide_setting_sem.
+	 */
+	auto_remove_settings(drive);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	up(&ide_setting_sem);
+}
+
+EXPORT_SYMBOL(ide_proc_unregister_driver);
+
 static void create_proc_ide_drives(ide_hwif_t *hwif)
 {
 	int	d;
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4561,6 +4561,8 @@ static void idetape_get_blocksize_from_b
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
 #endif /* IDETAPE_DEBUG_INFO */
 }
+
+#ifdef CONFIG_IDE_PROC_FS
 static void idetape_add_settings (ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -4583,6 +4585,9 @@ static void idetape_add_settings (ide_dr
 	ide_add_setting(drive,	"avg_speed",		SETTING_READ,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->avg_speed,			NULL);
 	ide_add_setting(drive,	"debug_level",		SETTING_RW,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->debug_level,			NULL);
 }
+#else
+static inline void idetape_add_settings(ide_drive_t *drive) { ; }
+#endif
 
 /*
  *	ide_setup is called to:
@@ -4703,7 +4708,7 @@ static void ide_tape_remove(ide_drive_t 
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	ide_unregister_subdriver(drive, tape->driver);
+	ide_proc_unregister_driver(drive, tape->driver);
 
 	ide_unregister_region(tape->disk);
 
@@ -4731,7 +4736,6 @@ static void ide_tape_release(struct kref
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-
 static int proc_idetape_read_name
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -4749,11 +4753,6 @@ static ide_proc_entry_t idetape_proc[] =
 	{ "name",	S_IFREG|S_IRUGO,	proc_idetape_read_name,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
-
-#else
-
-#define	idetape_proc	NULL
-
 #endif
 
 static int ide_tape_probe(ide_drive_t *);
@@ -4773,7 +4772,9 @@ static ide_driver_t idetape_driver = {
 	.end_request		= idetape_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
+#ifdef CONFIG_IDE_PROC_FS
 	.proc			= idetape_proc,
+#endif
 };
 
 /*
@@ -4864,7 +4865,7 @@ static int ide_tape_probe(ide_drive_t *d
 
 	ide_init_disk(g, drive);
 
-	ide_register_subdriver(drive, &idetape_driver);
+	ide_proc_register_driver(drive, &idetape_driver);
 
 	kref_init(&tape->kref);
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -830,178 +830,6 @@ EXPORT_SYMBOL(ide_register_hw);
 DECLARE_MUTEX(ide_setting_sem);
 
 /**
- *	__ide_add_setting	-	add an ide setting option
- *	@drive: drive to use
- *	@name: setting name
- *	@rw: true if the function is read write
- *	@data_type: type of data
- *	@min: range minimum
- *	@max: range maximum
- *	@mul_factor: multiplication scale
- *	@div_factor: divison scale
- *	@data: private data field
- *	@set: setting
- *	@auto_remove: setting auto removal flag
- *
- *	Removes the setting named from the device if it is present.
- *	The function takes the settings_lock to protect against 
- *	parallel changes. This function must not be called from IRQ
- *	context. Returns 0 on success or -1 on failure.
- *
- *	BUGS: This code is seriously over-engineered. There is also
- *	magic about how the driver specific features are setup. If
- *	a driver is attached we assume the driver settings are auto
- *	remove.
- */
-
-static int __ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set, int auto_remove)
-{
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
-
-	down(&ide_setting_sem);
-	while ((*p) && strcmp((*p)->name, name) < 0)
-		p = &((*p)->next);
-	if ((setting = kzalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
-		goto abort;
-	if ((setting->name = kmalloc(strlen(name) + 1, GFP_KERNEL)) == NULL)
-		goto abort;
-	strcpy(setting->name, name);
-	setting->rw = rw;
-	setting->data_type = data_type;
-	setting->min = min;
-	setting->max = max;
-	setting->mul_factor = mul_factor;
-	setting->div_factor = div_factor;
-	setting->data = data;
-	setting->set = set;
-	
-	setting->next = *p;
-	if (auto_remove)
-		setting->auto_remove = 1;
-	*p = setting;
-	up(&ide_setting_sem);
-	return 0;
-abort:
-	up(&ide_setting_sem);
-	kfree(setting);
-	return -1;
-}
-
-int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
-{
-	return __ide_add_setting(drive, name, rw, data_type, min, max, mul_factor, div_factor, data, set, 1);
-}
-
-EXPORT_SYMBOL(ide_add_setting);
-
-/**
- *	__ide_remove_setting	-	remove an ide setting option
- *	@drive: drive to use
- *	@name: setting name
- *
- *	Removes the setting named from the device if it is present.
- *	The caller must hold the setting semaphore.
- */
- 
-static void __ide_remove_setting (ide_drive_t *drive, char *name)
-{
-	ide_settings_t **p, *setting;
-
-	p = (ide_settings_t **) &drive->settings;
-
-	while ((*p) && strcmp((*p)->name, name))
-		p = &((*p)->next);
-	if ((setting = (*p)) == NULL)
-		return;
-
-	(*p) = setting->next;
-	
-	kfree(setting->name);
-	kfree(setting);
-}
-
-/**
- *	ide_find_setting_by_name	-	find a drive specific setting
- *	@drive: drive to scan
- *	@name: setting name
- *
- *	Scan's the device setting table for a matching entry and returns
- *	this or NULL if no entry is found. The caller must hold the
- *	setting semaphore
- */
- 
-ide_settings_t *ide_find_setting_by_name (ide_drive_t *drive, char *name)
-{
-	ide_settings_t *setting = drive->settings;
-
-	while (setting) {
-		if (strcmp(setting->name, name) == 0)
-			break;
-		setting = setting->next;
-	}
-	return setting;
-}
-
-/**
- *	auto_remove_settings	-	remove driver specific settings
- *	@drive: drive
- *
- *	Automatically remove all the driver specific settings for this
- *	drive. This function may not be called from IRQ context. The
- *	caller must hold ide_setting_sem.
- */
- 
-static void auto_remove_settings (ide_drive_t *drive)
-{
-	ide_settings_t *setting;
-repeat:
-	setting = drive->settings;
-	while (setting) {
-		if (setting->auto_remove) {
-			__ide_remove_setting(drive, setting->name);
-			goto repeat;
-		}
-		setting = setting->next;
-	}
-}
-
-/**
- *	ide_read_setting	-	read an IDE setting
- *	@drive: drive to read from
- *	@setting: drive setting
- *
- *	Read a drive setting and return the value. The caller
- *	must hold the ide_setting_sem when making this call.
- *
- *	BUGS: the data return and error are the same return value
- *	so an error -EINVAL and true return of the same value cannot
- *	be told apart
- */
- 
-int ide_read_setting (ide_drive_t *drive, ide_settings_t *setting)
-{
-	int		val = -EINVAL;
-	unsigned long	flags;
-
-	if ((setting->rw & SETTING_READ)) {
-		spin_lock_irqsave(&ide_lock, flags);
-		switch(setting->data_type) {
-			case TYPE_BYTE:
-				val = *((u8 *) setting->data);
-				break;
-			case TYPE_SHORT:
-				val = *((u16 *) setting->data);
-				break;
-			case TYPE_INT:
-				val = *((u32 *) setting->data);
-				break;
-		}
-		spin_unlock_irqrestore(&ide_lock, flags);
-	}
-	return val;
-}
-
-/**
  *	ide_spin_wait_hwgroup	-	wait for group
  *	@drive: drive in the group
  *
@@ -1034,52 +862,7 @@ int ide_spin_wait_hwgroup (ide_drive_t *
 
 EXPORT_SYMBOL(ide_spin_wait_hwgroup);
 
-/**
- *	ide_write_setting	-	read an IDE setting
- *	@drive: drive to read from
- *	@setting: drive setting
- *	@val: value
- *
- *	Write a drive setting if it is possible. The caller
- *	must hold the ide_setting_sem when making this call.
- *
- *	BUGS: the data return and error are the same return value
- *	so an error -EINVAL and true return of the same value cannot
- *	be told apart
- *
- *	FIXME:  This should be changed to enqueue a special request
- *	to the driver to change settings, and then wait on a sema for completion.
- *	The current scheme of polling is kludgy, though safe enough.
- */
-
-int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (setting->set)
-		return setting->set(drive, val);
-	if (!(setting->rw & SETTING_WRITE))
-		return -EPERM;
-	if (val < setting->min || val > setting->max)
-		return -EINVAL;
-	if (ide_spin_wait_hwgroup(drive))
-		return -EBUSY;
-	switch (setting->data_type) {
-		case TYPE_BYTE:
-			*((u8 *) setting->data) = val;
-			break;
-		case TYPE_SHORT:
-			*((u16 *) setting->data) = val;
-			break;
-		case TYPE_INT:
-			*((u32 *) setting->data) = val;
-			break;
-	}
-	spin_unlock_irq(&ide_lock);
-	return 0;
-}
-
-static int set_io_32bit(ide_drive_t *drive, int arg)
+int set_io_32bit(ide_drive_t *drive, int arg)
 {
 	if (drive->no_io_32bit)
 		return -EPERM;
@@ -1108,7 +891,7 @@ static int set_ksettings(ide_drive_t *dr
 	return 0;
 }
 
-static int set_using_dma (ide_drive_t *drive, int arg)
+int set_using_dma(ide_drive_t *drive, int arg)
 {
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
@@ -1130,7 +913,7 @@ static int set_using_dma (ide_drive_t *d
 #endif
 }
 
-static int set_pio_mode (ide_drive_t *drive, int arg)
+int set_pio_mode(ide_drive_t *drive, int arg)
 {
 	struct request rq;
 
@@ -1164,48 +947,6 @@ static int set_unmaskirq(ide_drive_t *dr
 	return 0;
 }
 
-static int set_xfer_rate (ide_drive_t *drive, int arg)
-{
-	int err;
-
-	if (arg < 0 || arg > 70)
-		return -EINVAL;
-
-	err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
-
-	if (!err && arg) {
-		ide_set_xfer_rate(drive, (u8) arg);
-		ide_driveid_update(drive);
-	}
-	return err;
-}
-
-/**
- *	ide_add_generic_settings	-	generic ide settings
- *	@drive: drive being configured
- *
- *	Add the generic parts of the system settings to the /proc files.
- *	The caller must not be holding the ide_setting_sem.
- */
-
-void ide_add_generic_settings (ide_drive_t *drive)
-{
-/*
- *			  drive		setting name		read/write access				data type	min	max				mul_factor	div_factor	data pointer			set function
- */
-	__ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit,	0);
-	__ide_add_setting(drive,	"keepsettings",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL,		0);
-	__ide_add_setting(drive,	"nice1",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL,		0);
-	__ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode,	0);
-	__ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL,		0);
-	__ide_add_setting(drive,	"using_dma",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma,	0);
-	__ide_add_setting(drive,	"init_speed",		SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL,		0);
-	__ide_add_setting(drive,	"current_speed",	SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate,	0);
-	__ide_add_setting(drive,	"number",		SETTING_RW,					TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL,		0);
-}
-
 /**
  *	system_bus_clock	-	clock guess
  *
@@ -1907,54 +1648,6 @@ static void __init probe_for_hwifs (void
 #endif
 }
 
-void ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
-{
-#ifdef CONFIG_IDE_PROC_FS
-	ide_add_proc_entries(drive->proc, driver->proc, drive);
-#endif
-}
-
-EXPORT_SYMBOL(ide_register_subdriver);
-
-/**
- *	ide_unregister_subdriver	-	disconnect drive from driver
- *	@drive: drive to unplug
- *	@driver: driver
- *
- *	Disconnect a drive from the driver it was attached to and then
- *	clean up the various proc files and other objects attached to it.
- *
- *	Takes ide_setting_sem and ide_lock.
- *	Caller must hold none of the locks.
- */
-
-void ide_unregister_subdriver(ide_drive_t *drive, ide_driver_t *driver)
-{
-	unsigned long flags;
-
-#ifdef CONFIG_IDE_PROC_FS
-	ide_remove_proc_entries(drive->proc, driver->proc);
-#endif
-	down(&ide_setting_sem);
-	spin_lock_irqsave(&ide_lock, flags);
-	/*
-	 * ide_setting_sem protects the settings list
-	 * ide_lock protects the use of settings
-	 *
-	 * so we need to hold both, ide_settings_sem because we want to
-	 * modify the settings list, and ide_lock because we cannot take
-	 * a setting out that is being used.
-	 *
-	 * OTOH both ide_{read,write}_setting are only ever used under
-	 * ide_setting_sem.
-	 */
-	auto_remove_settings(drive);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	up(&ide_setting_sem);
-}
-
-EXPORT_SYMBOL(ide_unregister_subdriver);
-
 /*
  * Probe module
  */
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -721,6 +721,7 @@ static ide_startstop_t idescsi_do_reques
 	return ide_stopped;
 }
 
+#ifdef CONFIG_IDE_PROC_FS
 static void idescsi_add_settings(ide_drive_t *drive)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
@@ -734,6 +735,9 @@ static void idescsi_add_settings(ide_dri
 	ide_add_setting(drive,	"transform",	SETTING_RW,	TYPE_INT,	0,	3,	1,		1,		&scsi->transform,	NULL);
 	ide_add_setting(drive,	"log",		SETTING_RW,	TYPE_INT,	0,	1,	1,		1,		&scsi->log,		NULL);
 }
+#else
+static inline void idescsi_add_settings(ide_drive_t *drive) { ; }
+#endif
 
 /*
  *	Driver initialization.
@@ -756,7 +760,7 @@ static void ide_scsi_remove(ide_drive_t 
 	struct ide_scsi_obj *scsi = scsihost_to_idescsi(scsihost);
 	struct gendisk *g = scsi->disk;
 
-	ide_unregister_subdriver(drive, scsi->driver);
+	ide_proc_unregister_driver(drive, scsi->driver);
 
 	ide_unregister_region(g);
 
@@ -775,8 +779,6 @@ static ide_proc_entry_t idescsi_proc[] =
 	{ "capacity", S_IFREG|S_IRUGO, proc_ide_read_capacity, NULL },
 	{ NULL, 0, NULL, NULL }
 };
-#else
-# define idescsi_proc	NULL
 #endif
 
 static ide_driver_t idescsi_driver = {
@@ -790,11 +792,13 @@ static ide_driver_t idescsi_driver = {
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
 	.supports_dsc_overlap	= 0,
-	.proc			= idescsi_proc,
 	.do_request		= idescsi_do_request,
 	.end_request		= idescsi_end_request,
 	.error                  = idescsi_atapi_error,
 	.abort                  = idescsi_atapi_abort,
+#ifdef CONFIG_IDE_PROC_FS
+	.proc			= idescsi_proc,
+#endif
 };
 
 static int idescsi_ide_open(struct inode *inode, struct file *filp)
@@ -1153,7 +1157,7 @@ static int ide_scsi_probe(ide_drive_t *d
 	idescsi->host = host;
 	idescsi->disk = g;
 	g->private_data = &idescsi->driver;
-	ide_register_subdriver(drive, &idescsi_driver);
+	ide_proc_register_driver(drive, &idescsi_driver);
 	err = 0;
 	idescsi_setup(drive, idescsi);
 	g->fops = &idescsi_ops;
@@ -1165,7 +1169,7 @@ static int ide_scsi_probe(ide_drive_t *d
 	}
 	/* fall through on error */
 	ide_unregister_region(g);
-	ide_unregister_subdriver(drive, &idescsi_driver);
+	ide_proc_unregister_driver(drive, &idescsi_driver);
 
 	put_disk(g);
 out_host_put:
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -559,9 +559,10 @@ typedef struct ide_drive_s {
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
 	void		*driver_data;	/* extra driver data */
 	struct hd_driveid	*id;	/* drive model identification info */
+#ifdef CONFIG_IDE_PROC_FS
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
-
+#endif
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 
 	unsigned long sleep;		/* sleep until this time */
@@ -856,8 +857,15 @@ typedef struct hwgroup_s {
 	unsigned char cmd_buf[4];
 } ide_hwgroup_t;
 
-/* structure attached to the request for IDE_TASK_CMDS */
+typedef struct ide_driver_s ide_driver_t;
+
+extern struct semaphore ide_setting_sem;
 
+int set_io_32bit(ide_drive_t *, int);
+int set_pio_mode(ide_drive_t *, int);
+int set_using_dma(ide_drive_t *, int);
+
+#ifdef CONFIG_IDE_PROC_FS
 /*
  * configurable drive settings
  */
@@ -885,12 +893,7 @@ typedef struct ide_settings_s {
 	struct ide_settings_s	*next;
 } ide_settings_t;
 
-extern struct semaphore ide_setting_sem;
 int ide_add_setting(ide_drive_t *, const char *, int, int, int, int, int, int, void *, ide_procset_t *set);
-extern ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
-extern int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
-extern int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
-extern void ide_add_generic_settings(ide_drive_t *drive);
 
 /*
  * /proc/ide interface
@@ -902,15 +905,17 @@ typedef struct {
 	write_proc_t	*write_proc;
 } ide_proc_entry_t;
 
-#ifdef CONFIG_IDE_PROC_FS
 extern struct proc_dir_entry *proc_ide_root;
 
 void proc_ide_create(void);
 void proc_ide_destroy(void);
 void create_proc_ide_interfaces(void);
 void destroy_proc_ide_interface(ide_hwif_t *);
-void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
-void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);
+void ide_proc_register_driver(ide_drive_t *, ide_driver_t *);
+void ide_proc_unregister_driver(ide_drive_t *, ide_driver_t *);
+
+void ide_add_generic_settings(ide_drive_t *);
+
 read_proc_t proc_ide_read_capacity;
 read_proc_t proc_ide_read_geometry;
 
@@ -938,6 +943,9 @@ static inline void proc_ide_create(void)
 static inline void proc_ide_destroy(void) { ; }
 static inline void create_proc_ide_interfaces(void) { ; }
 static inline void destroy_proc_ide_interface(ide_hwif_t *hwif) { ; }
+static inline void ide_proc_register_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
+static inline void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
+static inline void ide_add_generic_settings(ide_drive_t *drive) { ; }
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 #endif
 
@@ -980,7 +988,7 @@ enum {
  * The gendriver.owner field should be set to the module owner of this driver.
  * The gendriver.name field should be set to the name of this driver
  */
-typedef struct ide_driver_s {
+struct ide_driver_s {
 	const char			*version;
 	u8				media;
 	unsigned supports_dsc_overlap	: 1;
@@ -988,12 +996,14 @@ typedef struct ide_driver_s {
 	int		(*end_request)(ide_drive_t *, int, int);
 	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
-	ide_proc_entry_t	*proc;
 	struct device_driver	gen_driver;
 	int		(*probe)(ide_drive_t *);
 	void		(*remove)(ide_drive_t *);
 	void		(*shutdown)(ide_drive_t *);
-} ide_driver_t;
+#ifdef CONFIG_IDE_PROC_FS
+	ide_proc_entry_t	*proc;
+#endif
+};
 
 #define to_ide_driver(drv) container_of(drv, ide_driver_t, gen_driver)
 
@@ -1203,9 +1213,6 @@ extern void default_hwif_iops(ide_hwif_t
 extern void default_hwif_mmiops(ide_hwif_t *);
 extern void default_hwif_transport(ide_hwif_t *);
 
-void ide_register_subdriver(ide_drive_t *, ide_driver_t *);
-void ide_unregister_subdriver(ide_drive_t *, ide_driver_t *);
-
 #define ON_BOARD		1
 #define NEVER_BOARD		0
 
