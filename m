From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3][pata-2.6] ide: split off ioctl handling from IDE settings
Date: Thu, 08 Feb 2007 04:11:02 +0100
Message-ID: <20070208031102.2771.56185.sendpatchset@localhost.localdomain>
References: <20070208031055.2771.34444.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:8745 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933359AbXBHDFx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 22:05:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so360624uga
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2007 19:05:52 -0800 (PST)
In-Reply-To: <20070208031055.2771.34444.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: split off ioctl handling from IDE settings

* do write permission and min/max checks in ide_procset_t functions

* ide-disk.c: drive->id is always available so cleanup "multcount" setting
  accordingly

* ide-disk.c: "address" setting was incorrectly defined as type TYPE_INTA,
  fix it by using type TYPE_BYTE and updating ide_drive_t->adressing field,
  the bug didn't trigger because this IDE setting uses custom ->set function

* ide.c: add set_ksettings() for handling HDIO_SET_KEEPSETTINGS ioctl

* ide.c: add set_unmaskirq() for handling HDIO_SET_UNMASKINTR ioctl

* handle ioctls directly in generic_ide_ioclt() and idedisk_ioctl()
  instead of using IDE settings to deal with them

* remove no longer needed ide_find_setting_by_ioctl() and {read,write}_ioctl
  fields from ide_settings_t, also remove now unused TYPE_INTA handling

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-cd.c     |    2 
 drivers/ide/ide-disk.c   |   81 ++++++++++++++++++----
 drivers/ide/ide-floppy.c |   10 +-
 drivers/ide/ide-tape.c   |   30 ++++----
 drivers/ide/ide.c        |  171 +++++++++++++++++++++++++++--------------------
 drivers/scsi/ide-scsi.c  |   12 +--
 include/linux/ide.h      |   16 +---
 7 files changed, 198 insertions(+), 124 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3052,7 +3052,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 
 static void ide_cdrom_add_settings(ide_drive_t *drive)
 {
-	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
+	ide_add_setting(drive, "dsc_overlap", SETTING_RW, TYPE_BYTE, 0, 1, 1, 1, &drive->dsc_overlap, NULL);
 }
 
 /*
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -739,6 +739,9 @@ static int set_multcount(ide_drive_t *dr
 {
 	struct request rq;
 
+	if (arg < 0 || arg > drive->id->max_multsect)
+		return -EINVAL;
+
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
@@ -751,6 +754,9 @@ static int set_multcount(ide_drive_t *dr
 
 static int set_nowerr(ide_drive_t *drive, int arg)
 {
+	if (arg < 0 || arg > 1)
+		return -EINVAL;
+
 	if (ide_spin_wait_hwgroup(drive))
 		return -EBUSY;
 	drive->nowerr = arg;
@@ -802,6 +808,9 @@ static int write_cache(ide_drive_t *driv
 	ide_task_t args;
 	int err = 1;
 
+	if (arg < 0 || arg > 1)
+		return -EINVAL;
+
 	if (ide_id_has_flush_cache(drive->id)) {
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
@@ -837,6 +846,9 @@ static int set_acoustic (ide_drive_t *dr
 {
 	ide_task_t args;
 
+	if (arg < 0 || arg > 254)
+		return -EINVAL;
+
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ? SETFEATURES_EN_AAM :
 							  SETFEATURES_DIS_AAM;
@@ -857,6 +869,9 @@ static int set_acoustic (ide_drive_t *dr
  */
 static int set_lba_addressing(ide_drive_t *drive, int arg)
 {
+	if (arg < 0 || arg > 2)
+		return -EINVAL;
+
 	drive->addressing =  0;
 
 	if (HWIF(drive)->no_lba48)
@@ -872,18 +887,18 @@ static void idedisk_add_settings(ide_dri
 {
 	struct hd_driveid *id = drive->id;
 
-	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->bios_cyl,		NULL);
-	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
-	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"address",		SETTING_RW,					HDIO_GET_ADDRESS,	HDIO_SET_ADDRESS,	TYPE_INTA,	0,	2,				1,	1,	&drive->addressing,	set_lba_addressing);
-	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
-	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
-	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
-	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
-	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
- 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
- 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	TYPE_INT,	0,	65535,			1,	1,	&drive->bios_cyl,	NULL);
+	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,			1,	1,	&drive->bios_head,	NULL);
+	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,			1,	1,	&drive->bios_sect,	NULL);
+	ide_add_setting(drive,	"address",	SETTING_RW,	TYPE_BYTE,	0,	2,			1,	1,	&drive->addressing,	set_lba_addressing);
+	ide_add_setting(drive,	"bswap",	SETTING_READ,	TYPE_BYTE,	0,	1,			1,	1,	&drive->bswap,		NULL);
+	ide_add_setting(drive,	"multcount",	SETTING_RW,	TYPE_BYTE,	0,	id->max_multsect,	1,	1,	&drive->mult_count,	set_multcount);
+	ide_add_setting(drive,	"nowerr",	SETTING_RW,	TYPE_BYTE,	0,	1,			1,	1,	&drive->nowerr,		set_nowerr);
+	ide_add_setting(drive,	"lun",		SETTING_RW,	TYPE_INT,	0,	7,			1,	1,	&drive->lun,		NULL);
+	ide_add_setting(drive,	"wcache",	SETTING_RW,	TYPE_BYTE,	0,	1,			1,	1,	&drive->wcache,		write_cache);
+	ide_add_setting(drive,	"acoustic",	SETTING_RW,	TYPE_BYTE,	0,	254,			1,	1,	&drive->acoustic,	set_acoustic);
+ 	ide_add_setting(drive,	"failures",	SETTING_RW,	TYPE_INT,	0,	65535,			1,	1,	&drive->failures,	NULL);
+ 	ide_add_setting(drive,	"max_failures",	SETTING_RW,	TYPE_INT,	0,	65535,			1,	1,	&drive->max_failures,	NULL);
 }
 
 static void idedisk_setup (ide_drive_t *drive)
@@ -1142,9 +1157,49 @@ static int idedisk_getgeo(struct block_d
 static int idedisk_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
+	unsigned long flags;
 	struct block_device *bdev = inode->i_bdev;
 	struct ide_disk_obj *idkp = ide_disk_g(bdev->bd_disk);
-	return generic_ide_ioctl(idkp->drive, file, bdev, cmd, arg);
+	ide_drive_t *drive = idkp->drive;
+	int err, (*setfunc)(ide_drive_t *, int);
+	u8 *val;
+
+	switch (cmd) {
+	case HDIO_GET_ADDRESS:	 val = &drive->addressing;	goto read_val;
+	case HDIO_GET_MULTCOUNT: val = &drive->mult_count;	goto read_val;
+	case HDIO_GET_NOWERR:	 val = &drive->nowerr;		goto read_val;
+	case HDIO_GET_WCACHE:	 val = &drive->wcache;		goto read_val;
+	case HDIO_GET_ACOUSTIC:	 val = &drive->acoustic;	goto read_val;
+	case HDIO_SET_ADDRESS:	 setfunc = set_lba_addressing;	goto set_val;
+	case HDIO_SET_MULTCOUNT: setfunc = set_multcount;	goto set_val;
+	case HDIO_SET_NOWERR:	 setfunc = set_nowerr;		goto set_val;
+	case HDIO_SET_WCACHE:	 setfunc = write_cache;		goto set_val;
+	case HDIO_SET_ACOUSTIC:	 setfunc = set_acoustic;	goto set_val;
+	}
+
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
+
+read_val:
+	down(&ide_setting_sem);
+	spin_lock_irqsave(&ide_lock, flags);
+	err = *val;
+	spin_unlock_irqrestore(&ide_lock, flags);
+	up(&ide_setting_sem);
+	return err >= 0 ? put_user(err, (long __user *)arg) : err;
+
+set_val:
+	if (bdev != bdev->bd_contains)
+		err = -EINVAL;
+	else {
+		if (!capable(CAP_SYS_ADMIN))
+			err = -EACCES;
+		else {
+			down(&ide_setting_sem);
+			err = setfunc(drive, arg);
+			up(&ide_setting_sem);
+		}
+	}
+	return err;
 }
 
 static int idedisk_media_changed(struct gendisk *disk)
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1816,12 +1816,12 @@ static void idefloppy_add_settings(ide_d
 	idefloppy_floppy_t *floppy = drive->driver_data;
 
 /*
- *			drive	setting name	read/write	ioctl	ioctl		data type	min	max	mul_factor	div_factor	data pointer		set function
+ *			drive	setting name	read/write	data type	min	max	mul_factor	div_factor	data pointer		set function
  */
-	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
-	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
-	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"ticks",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&floppy->ticks,		NULL);
+	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	TYPE_INT,	0,	1023,		1,		1,	&drive->bios_cyl,	NULL);
+	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,		1,		1,	&drive->bios_head,	NULL);
+	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,		1,		1,	&drive->bios_sect,	NULL);
+	ide_add_setting(drive,	"ticks",	SETTING_RW,	TYPE_BYTE,	0,	255,		1,		1,	&floppy->ticks,		NULL);
 }
 
 /*
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4566,22 +4566,22 @@ static void idetape_add_settings (ide_dr
 	idetape_tape_t *tape = drive->driver_data;
 
 /*
- *			drive	setting name	read/write	ioctl	ioctl		data type	min			max			mul_factor			div_factor			data pointer				set function
+ *			drive	setting name		read/write	data type	min			max			mul_factor			div_factor	data pointer				set function
  */
-	ide_add_setting(drive,	"buffer",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				2,				&tape->capabilities.buffer_size,	NULL);
-	ide_add_setting(drive,	"pipeline_min",	SETTING_RW,	-1,	-1,		TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,				&tape->min_pipeline,			NULL);
-	ide_add_setting(drive,	"pipeline",	SETTING_RW,	-1,	-1,		TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,				&tape->max_stages,			NULL);
-	ide_add_setting(drive,	"pipeline_max",	SETTING_RW,	-1,	-1,		TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,				&tape->max_pipeline,			NULL);
-	ide_add_setting(drive,	"pipeline_used",SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,				&tape->nr_stages,			NULL);
-	ide_add_setting(drive,	"pipeline_pending",SETTING_READ,-1,	-1,		TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,				&tape->nr_pending_stages,		NULL);
-	ide_add_setting(drive,	"speed",	SETTING_READ,	-1,	-1,		TYPE_SHORT,	0,			0xffff,			1,				1,				&tape->capabilities.speed,		NULL);
-	ide_add_setting(drive,	"stage",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1024,				&tape->stage_size,			NULL);
-	ide_add_setting(drive,	"tdsc",		SETTING_RW,	-1,	-1,		TYPE_INT,	IDETAPE_DSC_RW_MIN,	IDETAPE_DSC_RW_MAX,	1000,				HZ,				&tape->best_dsc_rw_frequency,		NULL);
-	ide_add_setting(drive,	"dsc_overlap",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,			1,			1,				1,				&drive->dsc_overlap,			NULL);
-	ide_add_setting(drive,	"pipeline_head_speed_c",SETTING_READ,	-1,	-1,	TYPE_INT,	0,			0xffff,			1,				1,				&tape->controlled_pipeline_head_speed,	NULL);
-	ide_add_setting(drive,	"pipeline_head_speed_u",SETTING_READ,	-1,	-1,	TYPE_INT,	0,			0xffff,			1,				1,				&tape->uncontrolled_pipeline_head_speed,	NULL);
-	ide_add_setting(drive,	"avg_speed",	SETTING_READ,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->avg_speed,		NULL);
-	ide_add_setting(drive,	"debug_level",SETTING_RW,	-1,	-1,		TYPE_INT,	0,			0xffff,			1,				1,				&tape->debug_level,		NULL);
+	ide_add_setting(drive,	"buffer",		SETTING_READ,	TYPE_SHORT,	0,			0xffff,			1,				2,		&tape->capabilities.buffer_size,	NULL);
+	ide_add_setting(drive,	"pipeline_min",		SETTING_RW,	TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,		&tape->min_pipeline,			NULL);
+	ide_add_setting(drive,	"pipeline",		SETTING_RW,	TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,		&tape->max_stages,			NULL);
+	ide_add_setting(drive,	"pipeline_max",		SETTING_RW,	TYPE_INT,	1,			0xffff,			tape->stage_size / 1024,	1,		&tape->max_pipeline,			NULL);
+	ide_add_setting(drive,	"pipeline_used",	SETTING_READ,	TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,		&tape->nr_stages,			NULL);
+	ide_add_setting(drive,	"pipeline_pending",	SETTING_READ,	TYPE_INT,	0,			0xffff,			tape->stage_size / 1024,	1,		&tape->nr_pending_stages,		NULL);
+	ide_add_setting(drive,	"speed",		SETTING_READ,	TYPE_SHORT,	0,			0xffff,			1,				1,		&tape->capabilities.speed,		NULL);
+	ide_add_setting(drive,	"stage",		SETTING_READ,	TYPE_INT,	0,			0xffff,			1,				1024,		&tape->stage_size,			NULL);
+	ide_add_setting(drive,	"tdsc",			SETTING_RW,	TYPE_INT,	IDETAPE_DSC_RW_MIN,	IDETAPE_DSC_RW_MAX,	1000,				HZ,		&tape->best_dsc_rw_frequency,		NULL);
+	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW,	TYPE_BYTE,	0,			1,			1,				1,		&drive->dsc_overlap,			NULL);
+	ide_add_setting(drive,	"pipeline_head_speed_c",SETTING_READ,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->controlled_pipeline_head_speed,	NULL);
+	ide_add_setting(drive,	"pipeline_head_speed_u",SETTING_READ,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->uncontrolled_pipeline_head_speed,NULL);
+	ide_add_setting(drive,	"avg_speed",		SETTING_READ,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->avg_speed,			NULL);
+	ide_add_setting(drive,	"debug_level",		SETTING_RW,	TYPE_INT,	0,			0xffff,			1,				1,		&tape->debug_level,			NULL);
 }
 
 /*
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -834,8 +834,6 @@ DECLARE_MUTEX(ide_setting_sem);
  *	@drive: drive to use
  *	@name: setting name
  *	@rw: true if the function is read write
- *	@read_ioctl: function to call on read
- *	@write_ioctl: function to call on write
  *	@data_type: type of data
  *	@min: range minimum
  *	@max: range maximum
@@ -856,7 +854,7 @@ DECLARE_MUTEX(ide_setting_sem);
  *	remove.
  */
 
-static int __ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set, int auto_remove)
+static int __ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set, int auto_remove)
 {
 	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
 
@@ -869,8 +867,6 @@ static int __ide_add_setting(ide_drive_t
 		goto abort;
 	strcpy(setting->name, name);
 	setting->rw = rw;
-	setting->read_ioctl = read_ioctl;
-	setting->write_ioctl = write_ioctl;
 	setting->data_type = data_type;
 	setting->min = min;
 	setting->max = max;
@@ -891,9 +887,9 @@ abort:
 	return -1;
 }
 
-int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
-	return __ide_add_setting(drive, name, rw, read_ioctl, write_ioctl, data_type, min, max, mul_factor, div_factor, data, set, 1);
+	return __ide_add_setting(drive, name, rw, data_type, min, max, mul_factor, div_factor, data, set, 1);
 }
 
 EXPORT_SYMBOL(ide_add_setting);
@@ -925,29 +921,6 @@ static void __ide_remove_setting (ide_dr
 }
 
 /**
- *	ide_find_setting_by_ioctl	-	find a drive specific ioctl
- *	@drive: drive to scan
- *	@cmd: ioctl command to handle
- *
- *	Scan's the device setting table for a matching entry and returns
- *	this or NULL if no entry is found. The caller must hold the
- *	setting semaphore
- */
- 
-static ide_settings_t *ide_find_setting_by_ioctl (ide_drive_t *drive, int cmd)
-{
-	ide_settings_t *setting = drive->settings;
-
-	while (setting) {
-		if (setting->read_ioctl == cmd || setting->write_ioctl == cmd)
-			break;
-		setting = setting->next;
-	}
-	
-	return setting;
-}
-
-/**
  *	ide_find_setting_by_name	-	find a drive specific setting
  *	@drive: drive to scan
  *	@name: setting name
@@ -1020,7 +993,6 @@ int ide_read_setting (ide_drive_t *drive
 				val = *((u16 *) setting->data);
 				break;
 			case TYPE_INT:
-			case TYPE_INTA:
 				val = *((u32 *) setting->data);
 				break;
 		}
@@ -1082,17 +1054,14 @@ EXPORT_SYMBOL(ide_spin_wait_hwgroup);
 
 int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
 {
-	int i;
-	u32 *p;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (setting->set)
+		return setting->set(drive, val);
 	if (!(setting->rw & SETTING_WRITE))
 		return -EPERM;
 	if (val < setting->min || val > setting->max)
 		return -EINVAL;
-	if (setting->set)
-		return setting->set(drive, val);
 	if (ide_spin_wait_hwgroup(drive))
 		return -EBUSY;
 	switch (setting->data_type) {
@@ -1105,11 +1074,6 @@ int ide_write_setting (ide_drive_t *driv
 		case TYPE_INT:
 			*((u32 *) setting->data) = val;
 			break;
-		case TYPE_INTA:
-			p = (u32 *) setting->data;
-			for (i = 0; i < 1 << PARTN_BITS; i++, p++)
-				*p = val;
-			break;
 	}
 	spin_unlock_irq(&ide_lock);
 	return 0;
@@ -1117,6 +1081,12 @@ int ide_write_setting (ide_drive_t *driv
 
 static int set_io_32bit(ide_drive_t *drive, int arg)
 {
+	if (drive->no_io_32bit)
+		return -EPERM;
+
+	if (arg < 0 || arg > 1 + (SUPPORT_VLB_SYNC << 1))
+		return -EINVAL;
+
 	drive->io_32bit = arg;
 #ifdef CONFIG_BLK_DEV_DTC2278
 	if (HWIF(drive)->chipset == ide_dtc2278)
@@ -1125,8 +1095,24 @@ static int set_io_32bit(ide_drive_t *dri
 	return 0;
 }
 
+static int set_ksettings(ide_drive_t *drive, int arg)
+{
+	if (arg < 0 || arg > 1)
+		return -EINVAL;
+
+	if (ide_spin_wait_hwgroup(drive))
+		return -EBUSY;
+	drive->keep_settings = arg;
+	spin_unlock_irq(&ide_lock);
+
+	return 0;
+}
+
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
+	if (arg < 0 || arg > 1)
+		return -EINVAL;
+
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (!drive->id || !(drive->id->capability & 1))
 		return -EPERM;
@@ -1148,6 +1134,9 @@ static int set_pio_mode (ide_drive_t *dr
 {
 	struct request rq;
 
+	if (arg < 0 || arg > 255)
+		return -EINVAL;
+
 	if (!HWIF(drive)->tuneproc)
 		return -ENOSYS;
 	if (drive->special.b.set_tune)
@@ -1159,9 +1148,30 @@ static int set_pio_mode (ide_drive_t *dr
 	return 0;
 }
 
+static int set_unmaskirq(ide_drive_t *drive, int arg)
+{
+	if (drive->no_unmask)
+		return -EPERM;
+
+	if (arg < 0 || arg > 1)
+		return -EINVAL;
+
+	if (ide_spin_wait_hwgroup(drive))
+		return -EBUSY;
+	drive->unmask = arg;
+	spin_unlock_irq(&ide_lock);
+
+	return 0;
+}
+
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
-	int err = ide_wait_cmd(drive,
+	int err;
+
+	if (arg < 0 || arg > 70)
+		return -EINVAL;
+
+	err = ide_wait_cmd(drive,
 			WIN_SETFEATURES, (u8) arg,
 			SETFEATURES_XFER, 0, NULL);
 
@@ -1176,25 +1186,24 @@ static int set_xfer_rate (ide_drive_t *d
  *	ide_add_generic_settings	-	generic ide settings
  *	@drive: drive being configured
  *
- *	Add the generic parts of the system settings to the /proc files and
- *	ioctls for this IDE device. The caller must not be holding the
- *	ide_setting_sem.
+ *	Add the generic parts of the system settings to the /proc files.
+ *	The caller must not be holding the ide_setting_sem.
  */
 
 void ide_add_generic_settings (ide_drive_t *drive)
 {
 /*
- *			  drive		setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function
+ *			  drive		setting name		read/write access				data type	min	max				mul_factor	div_factor	data pointer			set function
  */
-	__ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit,	0);
-	__ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL,		0);
-	__ide_add_setting(drive,	"nice1",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL,		0);
-	__ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode,	0);
-	__ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL,		0);
-	__ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma,	0);
-	__ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL,		0);
-	__ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate,	0);
-	__ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL,		0);
+	__ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit,	0);
+	__ide_add_setting(drive,	"keepsettings",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL,		0);
+	__ide_add_setting(drive,	"nice1",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL,		0);
+	__ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode,	0);
+	__ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL,		0);
+	__ide_add_setting(drive,	"using_dma",		SETTING_RW,					TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma,	0);
+	__ide_add_setting(drive,	"init_speed",		SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL,		0);
+	__ide_add_setting(drive,	"current_speed",	SETTING_RW,					TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate,	0);
+	__ide_add_setting(drive,	"number",		SETTING_RW,					TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL,		0);
 }
 
 /**
@@ -1266,27 +1275,23 @@ static int generic_ide_resume(struct dev
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
 			unsigned int cmd, unsigned long arg)
 {
-	ide_settings_t *setting;
+	unsigned long flags;
 	ide_driver_t *drv;
-	int err = 0;
 	void __user *p = (void __user *)arg;
+	int err = 0, (*setfunc)(ide_drive_t *, int);
+	u8 *val;
 
-	down(&ide_setting_sem);
-	if ((setting = ide_find_setting_by_ioctl(drive, cmd)) != NULL) {
-		if (cmd == setting->read_ioctl) {
-			err = ide_read_setting(drive, setting);
-			up(&ide_setting_sem);
-			return err >= 0 ? put_user(err, (long __user *)arg) : err;
-		} else {
-			if (bdev != bdev->bd_contains)
-				err = -EINVAL;
-			else
-				err = ide_write_setting(drive, setting, arg);
-			up(&ide_setting_sem);
-			return err;
-		}
+	switch (cmd) {
+	case HDIO_GET_32BIT:	    val = &drive->io_32bit;	 goto read_val;
+	case HDIO_GET_KEEPSETTINGS: val = &drive->keep_settings; goto read_val;
+	case HDIO_GET_UNMASKINTR:   val = &drive->unmask;	 goto read_val;
+	case HDIO_GET_DMA:	    val = &drive->using_dma;	 goto read_val;
+	case HDIO_SET_32BIT:	    setfunc = set_io_32bit;	 goto set_val;
+	case HDIO_SET_KEEPSETTINGS: setfunc = set_ksettings;	 goto set_val;
+	case HDIO_SET_PIO_MODE:	    setfunc = set_pio_mode;	 goto set_val;
+	case HDIO_SET_UNMASKINTR:   setfunc = set_unmaskirq;	 goto set_val;
+	case HDIO_SET_DMA:	    setfunc = set_using_dma;	 goto set_val;
 	}
-	up(&ide_setting_sem);
 
 	switch (cmd) {
 		case HDIO_OBSOLETE_IDENTITY:
@@ -1415,6 +1420,28 @@ int generic_ide_ioctl(ide_drive_t *drive
 		default:
 			return -EINVAL;
 	}
+
+read_val:
+	down(&ide_setting_sem);
+	spin_lock_irqsave(&ide_lock, flags);
+	err = *val;
+	spin_unlock_irqrestore(&ide_lock, flags);
+	up(&ide_setting_sem);
+	return err >= 0 ? put_user(err, (long __user *)arg) : err;
+
+set_val:
+	if (bdev != bdev->bd_contains)
+		err = -EINVAL;
+	else {
+		if (!capable(CAP_SYS_ADMIN))
+			err = -EACCES;
+		else {
+			down(&ide_setting_sem);
+			err = setfunc(drive, arg);
+			up(&ide_setting_sem);
+		}
+	}
+	return err;
 }
 
 EXPORT_SYMBOL(generic_ide_ioctl);
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -726,13 +726,13 @@ static void idescsi_add_settings(ide_dri
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 
 /*
- *			drive	setting name	read/write	ioctl	ioctl		data type	min	max	mul_factor	div_factor	data pointer		set function
+ *			drive	setting name	read/write	data type	min	max	mul_factor	div_factor	data pointer		set function
  */
-	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	-1,	-1,		TYPE_INT,	0,	1023,	1,		1,		&drive->bios_cyl,	NULL);
-	ide_add_setting(drive,	"bios_head",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,	255,	1,		1,		&drive->bios_head,	NULL);
-	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	-1,	-1,		TYPE_BYTE,	0,	63,	1,		1,		&drive->bios_sect,	NULL);
-	ide_add_setting(drive,	"transform",	SETTING_RW,	-1,	-1,		TYPE_INT,	0,	3,	1,		1,		&scsi->transform,	NULL);
-	ide_add_setting(drive,	"log",		SETTING_RW,	-1,	-1,		TYPE_INT,	0,	1,	1,		1,		&scsi->log,		NULL);
+	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	TYPE_INT,	0,	1023,	1,		1,		&drive->bios_cyl,	NULL);
+	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,	1,		1,		&drive->bios_head,	NULL);
+	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,	1,		1,		&drive->bios_sect,	NULL);
+	ide_add_setting(drive,	"transform",	SETTING_RW,	TYPE_INT,	0,	3,	1,		1,		&scsi->transform,	NULL);
+	ide_add_setting(drive,	"log",		SETTING_RW,	TYPE_INT,	0,	1,	1,		1,		&scsi->log,		NULL);
 }
 
 /*
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -601,16 +601,11 @@ typedef struct ide_drive_s {
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
-	unsigned addressing;		/*      : 3;
-					 *  0=28-bit
-					 *  1=48-bit
-					 *  2=48-bit doing 28-bit
-					 *  3=64-bit
-					 */
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
 	unsigned post_reset	: 1;
 
+	u8	addressing;	/* 0=28-bit, 1=48-bit, 2=48-bit doing 28-bit */
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
         u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
@@ -868,9 +863,8 @@ typedef struct hwgroup_s {
  */
 
 #define TYPE_INT	0
-#define TYPE_INTA	1
-#define TYPE_BYTE	2
-#define TYPE_SHORT	3
+#define TYPE_BYTE	1
+#define TYPE_SHORT	2
 
 #define SETTING_READ	(1 << 0)
 #define SETTING_WRITE	(1 << 1)
@@ -880,8 +874,6 @@ typedef int (ide_procset_t)(ide_drive_t 
 typedef struct ide_settings_s {
 	char			*name;
 	int			rw;
-	int			read_ioctl;
-	int			write_ioctl;
 	int			data_type;
 	int			min;
 	int			max;
@@ -894,7 +886,7 @@ typedef struct ide_settings_s {
 } ide_settings_t;
 
 extern struct semaphore ide_setting_sem;
-extern int ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
+int ide_add_setting(ide_drive_t *, const char *, int, int, int, int, int, int, void *, ide_procset_t *set);
 extern ide_settings_t *ide_find_setting_by_name(ide_drive_t *drive, char *name);
 extern int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
 extern int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
