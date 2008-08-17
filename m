From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/9] ide: merge all TASKFILE_NO_DATA data phase handlers into taskfile_no_intr()
Date: Sun, 17 Aug 2008 21:54:32 +0200
Message-ID: <20080817195432.13393.20639.sendpatchset@localhost.localdomain>
References: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:50284 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYHQT4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 15:56:52 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2865213mue.1
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 12:56:51 -0700 (PDT)
In-Reply-To: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Add 'struct task_s' to ide_hwif_t and init it to the current command
  in do_rw_taskfile().

* Merge all TASKFILE_NO_DATA data phase handlers into taskfile_no_intr(=
).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |  105 +++++-----------------
 include/linux/ide.h        |  211 ++++++++++++++++++++++--------------=
---------
 2 files changed, 131 insertions(+), 185 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -53,9 +53,6 @@ int taskfile_lib_get_identify (ide_drive
 }
=20
 static ide_startstop_t task_no_data_intr(ide_drive_t *);
-static ide_startstop_t set_geometry_intr(ide_drive_t *);
-static ide_startstop_t recal_intr(ide_drive_t *);
-static ide_startstop_t set_multmode_intr(ide_drive_t *);
 static ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request=
 *);
 static ide_startstop_t task_in_intr(ide_drive_t *);
=20
@@ -79,6 +76,8 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	if (task->tf_flags & IDE_TFLAG_FLAGGED)
 		task->tf_flags |=3D IDE_TFLAG_FLAGGED_SET_IN_FLAGS;
=20
+	memcpy(&hwif->task, task, sizeof(*task));
+
 	if ((task->tf_flags & IDE_TFLAG_DMA_PIO_FALLBACK) =3D=3D 0) {
 		ide_tf_dump(drive->name, tf);
 		tp_ops->set_irq(hwif, 1);
@@ -99,19 +98,6 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	case TASKFILE_NO_DATA:
 		if (handler =3D=3D NULL)
 			handler =3D task_no_data_intr;
-		if (task->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) {
-			switch (tf->command) {
-			case ATA_CMD_INIT_DEV_PARAMS:
-				handler =3D set_geometry_intr;
-				break;
-			case ATA_CMD_RESTORE:
-				handler =3D recal_intr;
-				break;
-			case ATA_CMD_SET_MULTI:
-				handler =3D set_multmode_intr;
-				break;
-			}
-		}
 		ide_execute_command(drive, tf->command, handler,
 				    WAIT_WORSTCASE, NULL);
 		return ide_started;
@@ -127,33 +113,15 @@ ide_startstop_t do_rw_taskfile (ide_driv
 EXPORT_SYMBOL_GPL(do_rw_taskfile);
=20
 /*
- * set_multmode_intr() is invoked on completion of a ATA_CMD_SET_MULTI=
 cmd.
- */
-static ide_startstop_t set_multmode_intr(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif =3D drive->hwif;
-	u8 stat;
-
-	local_irq_enable_in_hardirq();
-	stat =3D hwif->tp_ops->read_status(hwif);
-
-	if (OK_STAT(stat, ATA_DRDY, BAD_STAT))
-		drive->mult_count =3D drive->mult_req;
-	else {
-		drive->mult_req =3D drive->mult_count =3D 0;
-		drive->special.b.recalibrate =3D 1;
-		(void) ide_dump_status(drive, "set_multmode", stat);
-	}
-	return ide_stopped;
-}
-
-/*
- * set_geometry_intr() is invoked on completion of a ATA_CMD_INIT_DEV_=
PARAMS cmd.
+ * Handler for commands without a data phase
  */
-static ide_startstop_t set_geometry_intr(ide_drive_t *drive)
+static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
-	int retries =3D 5;
+	ide_task_t *task =3D &hwif->task;
+	struct ide_taskfile *tf =3D &task->tf;
+	int custom =3D (task->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) ? 1 : 0;
+	int retries =3D (custom && tf->command =3D=3D ATA_CMD_INIT_DEV_PARAMS=
) ? 5 : 1;
 	u8 stat;
=20
 	local_irq_enable_in_hardirq();
@@ -165,50 +133,27 @@ static ide_startstop_t set_geometry_intr
 		udelay(10);
 	};
=20
-	if (OK_STAT(stat, ATA_DRDY, BAD_STAT))
-		return ide_stopped;
-
-	if (stat & (ATA_ERR | ATA_DRQ))
-		return ide_error(drive, "set_geometry_intr", stat);
-
-	ide_set_handler(drive, &set_geometry_intr, WAIT_WORSTCASE, NULL);
-	return ide_started;
-}
-
-/*
- * recal_intr() is invoked on completion of a ATA_CMD_RESTORE (recalib=
rate) cmd.
- */
-static ide_startstop_t recal_intr(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif =3D drive->hwif;
-	u8 stat;
-
-	local_irq_enable_in_hardirq();
-	stat =3D hwif->tp_ops->read_status(hwif);
-
-	if (!OK_STAT(stat, ATA_DRDY, BAD_STAT))
-		return ide_error(drive, "recal_intr", stat);
-	return ide_stopped;
-}
-
-/*
- * Handler for commands without a data phase
- */
-static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif =3D drive->hwif;
-	ide_task_t *args =3D hwif->hwgroup->rq->special;
-	u8 stat;
-
-	local_irq_enable_in_hardirq();
-	stat =3D hwif->tp_ops->read_status(hwif);
-
-	if (!OK_STAT(stat, ATA_DRDY, BAD_STAT))
+	if (!OK_STAT(stat, ATA_DRDY, BAD_STAT)) {
+		if (custom && tf->command =3D=3D ATA_CMD_SET_MULTI) {
+			drive->mult_req =3D drive->mult_count =3D 0;
+			drive->special.b.recalibrate =3D 1;
+			(void)ide_dump_status(drive, __func__, stat);
+			return ide_stopped;
+		} else if (custom && tf->command =3D=3D ATA_CMD_INIT_DEV_PARAMS) {
+			if ((stat & (ATA_ERR | ATA_DRQ)) =3D=3D 0) {
+				ide_set_handler(drive, &task_no_data_intr,
+						WAIT_WORSTCASE, NULL);
+				return ide_started;
+			}
+		}
 		return ide_error(drive, "task_no_data_intr", stat);
 		/* calls ide_end_drive_cmd */
+	}
=20
-	if (args)
+	if (!custom)
 		ide_end_drive_cmd(drive, stat, ide_read_error(drive));
+	else if (tf->command =3D=3D ATA_CMD_SET_MULTI)
+		drive->mult_count =3D drive->mult_req;
=20
 	return ide_stopped;
 }
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -282,6 +282,110 @@ typedef enum {
 	ide_started,	/* a drive operation was started, handler was set */
 } ide_startstop_t;
=20
+enum {
+	IDE_TFLAG_LBA48			=3D (1 << 0),
+	IDE_TFLAG_FLAGGED		=3D (1 << 2),
+	IDE_TFLAG_OUT_DATA		=3D (1 << 3),
+	IDE_TFLAG_OUT_HOB_FEATURE	=3D (1 << 4),
+	IDE_TFLAG_OUT_HOB_NSECT		=3D (1 << 5),
+	IDE_TFLAG_OUT_HOB_LBAL		=3D (1 << 6),
+	IDE_TFLAG_OUT_HOB_LBAM		=3D (1 << 7),
+	IDE_TFLAG_OUT_HOB_LBAH		=3D (1 << 8),
+	IDE_TFLAG_OUT_HOB		=3D IDE_TFLAG_OUT_HOB_FEATURE |
+					  IDE_TFLAG_OUT_HOB_NSECT |
+					  IDE_TFLAG_OUT_HOB_LBAL |
+					  IDE_TFLAG_OUT_HOB_LBAM |
+					  IDE_TFLAG_OUT_HOB_LBAH,
+	IDE_TFLAG_OUT_FEATURE		=3D (1 << 9),
+	IDE_TFLAG_OUT_NSECT		=3D (1 << 10),
+	IDE_TFLAG_OUT_LBAL		=3D (1 << 11),
+	IDE_TFLAG_OUT_LBAM		=3D (1 << 12),
+	IDE_TFLAG_OUT_LBAH		=3D (1 << 13),
+	IDE_TFLAG_OUT_TF		=3D IDE_TFLAG_OUT_FEATURE |
+					  IDE_TFLAG_OUT_NSECT |
+					  IDE_TFLAG_OUT_LBAL |
+					  IDE_TFLAG_OUT_LBAM |
+					  IDE_TFLAG_OUT_LBAH,
+	IDE_TFLAG_OUT_DEVICE		=3D (1 << 14),
+	IDE_TFLAG_WRITE			=3D (1 << 15),
+	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	=3D (1 << 16),
+	IDE_TFLAG_IN_DATA		=3D (1 << 17),
+	IDE_TFLAG_CUSTOM_HANDLER	=3D (1 << 18),
+	IDE_TFLAG_DMA_PIO_FALLBACK	=3D (1 << 19),
+	IDE_TFLAG_IN_HOB_FEATURE	=3D (1 << 20),
+	IDE_TFLAG_IN_HOB_NSECT		=3D (1 << 21),
+	IDE_TFLAG_IN_HOB_LBAL		=3D (1 << 22),
+	IDE_TFLAG_IN_HOB_LBAM		=3D (1 << 23),
+	IDE_TFLAG_IN_HOB_LBAH		=3D (1 << 24),
+	IDE_TFLAG_IN_HOB_LBA		=3D IDE_TFLAG_IN_HOB_LBAL |
+					  IDE_TFLAG_IN_HOB_LBAM |
+					  IDE_TFLAG_IN_HOB_LBAH,
+	IDE_TFLAG_IN_HOB		=3D IDE_TFLAG_IN_HOB_FEATURE |
+					  IDE_TFLAG_IN_HOB_NSECT |
+					  IDE_TFLAG_IN_HOB_LBA,
+	IDE_TFLAG_IN_FEATURE		=3D (1 << 1),
+	IDE_TFLAG_IN_NSECT		=3D (1 << 25),
+	IDE_TFLAG_IN_LBAL		=3D (1 << 26),
+	IDE_TFLAG_IN_LBAM		=3D (1 << 27),
+	IDE_TFLAG_IN_LBAH		=3D (1 << 28),
+	IDE_TFLAG_IN_LBA		=3D IDE_TFLAG_IN_LBAL |
+					  IDE_TFLAG_IN_LBAM |
+					  IDE_TFLAG_IN_LBAH,
+	IDE_TFLAG_IN_TF			=3D IDE_TFLAG_IN_NSECT |
+					  IDE_TFLAG_IN_LBA,
+	IDE_TFLAG_IN_DEVICE		=3D (1 << 29),
+	IDE_TFLAG_HOB			=3D IDE_TFLAG_OUT_HOB |
+					  IDE_TFLAG_IN_HOB,
+	IDE_TFLAG_TF			=3D IDE_TFLAG_OUT_TF |
+					  IDE_TFLAG_IN_TF,
+	IDE_TFLAG_DEVICE		=3D IDE_TFLAG_OUT_DEVICE |
+					  IDE_TFLAG_IN_DEVICE,
+	/* force 16-bit I/O operations */
+	IDE_TFLAG_IO_16BIT		=3D (1 << 30),
+	/* ide_task_t was allocated using kmalloc() */
+	IDE_TFLAG_DYN			=3D (1 << 31),
+};
+
+struct ide_taskfile {
+	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
+
+	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
+	u8	hob_nsect;
+	u8	hob_lbal;
+	u8	hob_lbam;
+	u8	hob_lbah;
+
+	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
+
+	union {			/* =C2=A07: */
+		u8 error;	/*   read:  error */
+		u8 feature;	/*  write: feature */
+	};
+
+	u8	nsect;		/*  8: number of sectors */
+	u8	lbal;		/*  9: LBA low */
+	u8	lbam;		/* 10: LBA mid */
+	u8	lbah;		/* 11: LBA high */
+
+	u8	device;		/* 12: device select */
+
+	union {			/* 13: */
+		u8 status;	/* =C2=A0read: status =C2=A0*/
+		u8 command;	/* write: command */
+	};
+};
+
+typedef struct ide_task_s {
+	union {
+		struct ide_taskfile	tf;
+		u8			tf_array[14];
+	};
+	u32			tf_flags;
+	int			data_phase;
+	struct request		*rq;		/* copy of request */
+	void			*special;	/* valid_t generally */
+} ide_task_t;
+
 /* ATAPI packet command flags */
 enum {
 	/* set when an error is considered normal - no retry (ide-tape) */
@@ -556,7 +660,6 @@ typedef struct ide_drive_s ide_drive_t;
=20
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
=20
-struct ide_task_s;
 struct ide_port_info;
=20
 struct ide_tp_ops {
@@ -683,6 +786,8 @@ typedef struct hwif_s {
 	/* data phase of the active command (currently only valid for PIO/DMA=
) */
 	int		data_phase;
=20
+	struct ide_task_s task;		/* current command */
+
 	unsigned int nsect;
 	unsigned int nleft;
 	struct scatterlist *cursg;
@@ -1028,110 +1133,6 @@ extern void ide_do_drive_cmd(ide_drive_t
=20
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
=20
-enum {
-	IDE_TFLAG_LBA48			=3D (1 << 0),
-	IDE_TFLAG_FLAGGED		=3D (1 << 2),
-	IDE_TFLAG_OUT_DATA		=3D (1 << 3),
-	IDE_TFLAG_OUT_HOB_FEATURE	=3D (1 << 4),
-	IDE_TFLAG_OUT_HOB_NSECT		=3D (1 << 5),
-	IDE_TFLAG_OUT_HOB_LBAL		=3D (1 << 6),
-	IDE_TFLAG_OUT_HOB_LBAM		=3D (1 << 7),
-	IDE_TFLAG_OUT_HOB_LBAH		=3D (1 << 8),
-	IDE_TFLAG_OUT_HOB		=3D IDE_TFLAG_OUT_HOB_FEATURE |
-					  IDE_TFLAG_OUT_HOB_NSECT |
-					  IDE_TFLAG_OUT_HOB_LBAL |
-					  IDE_TFLAG_OUT_HOB_LBAM |
-					  IDE_TFLAG_OUT_HOB_LBAH,
-	IDE_TFLAG_OUT_FEATURE		=3D (1 << 9),
-	IDE_TFLAG_OUT_NSECT		=3D (1 << 10),
-	IDE_TFLAG_OUT_LBAL		=3D (1 << 11),
-	IDE_TFLAG_OUT_LBAM		=3D (1 << 12),
-	IDE_TFLAG_OUT_LBAH		=3D (1 << 13),
-	IDE_TFLAG_OUT_TF		=3D IDE_TFLAG_OUT_FEATURE |
-					  IDE_TFLAG_OUT_NSECT |
-					  IDE_TFLAG_OUT_LBAL |
-					  IDE_TFLAG_OUT_LBAM |
-					  IDE_TFLAG_OUT_LBAH,
-	IDE_TFLAG_OUT_DEVICE		=3D (1 << 14),
-	IDE_TFLAG_WRITE			=3D (1 << 15),
-	IDE_TFLAG_FLAGGED_SET_IN_FLAGS	=3D (1 << 16),
-	IDE_TFLAG_IN_DATA		=3D (1 << 17),
-	IDE_TFLAG_CUSTOM_HANDLER	=3D (1 << 18),
-	IDE_TFLAG_DMA_PIO_FALLBACK	=3D (1 << 19),
-	IDE_TFLAG_IN_HOB_FEATURE	=3D (1 << 20),
-	IDE_TFLAG_IN_HOB_NSECT		=3D (1 << 21),
-	IDE_TFLAG_IN_HOB_LBAL		=3D (1 << 22),
-	IDE_TFLAG_IN_HOB_LBAM		=3D (1 << 23),
-	IDE_TFLAG_IN_HOB_LBAH		=3D (1 << 24),
-	IDE_TFLAG_IN_HOB_LBA		=3D IDE_TFLAG_IN_HOB_LBAL |
-					  IDE_TFLAG_IN_HOB_LBAM |
-					  IDE_TFLAG_IN_HOB_LBAH,
-	IDE_TFLAG_IN_HOB		=3D IDE_TFLAG_IN_HOB_FEATURE |
-					  IDE_TFLAG_IN_HOB_NSECT |
-					  IDE_TFLAG_IN_HOB_LBA,
-	IDE_TFLAG_IN_FEATURE		=3D (1 << 1),
-	IDE_TFLAG_IN_NSECT		=3D (1 << 25),
-	IDE_TFLAG_IN_LBAL		=3D (1 << 26),
-	IDE_TFLAG_IN_LBAM		=3D (1 << 27),
-	IDE_TFLAG_IN_LBAH		=3D (1 << 28),
-	IDE_TFLAG_IN_LBA		=3D IDE_TFLAG_IN_LBAL |
-					  IDE_TFLAG_IN_LBAM |
-					  IDE_TFLAG_IN_LBAH,
-	IDE_TFLAG_IN_TF			=3D IDE_TFLAG_IN_NSECT |
-					  IDE_TFLAG_IN_LBA,
-	IDE_TFLAG_IN_DEVICE		=3D (1 << 29),
-	IDE_TFLAG_HOB			=3D IDE_TFLAG_OUT_HOB |
-					  IDE_TFLAG_IN_HOB,
-	IDE_TFLAG_TF			=3D IDE_TFLAG_OUT_TF |
-					  IDE_TFLAG_IN_TF,
-	IDE_TFLAG_DEVICE		=3D IDE_TFLAG_OUT_DEVICE |
-					  IDE_TFLAG_IN_DEVICE,
-	/* force 16-bit I/O operations */
-	IDE_TFLAG_IO_16BIT		=3D (1 << 30),
-	/* ide_task_t was allocated using kmalloc() */
-	IDE_TFLAG_DYN			=3D (1 << 31),
-};
-
-struct ide_taskfile {
-	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
-
-	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
-	u8	hob_nsect;
-	u8	hob_lbal;
-	u8	hob_lbam;
-	u8	hob_lbah;
-
-	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
-
-	union {			/* =C2=A07: */
-		u8 error;	/*   read:  error */
-		u8 feature;	/*  write: feature */
-	};
-
-	u8	nsect;		/*  8: number of sectors */
-	u8	lbal;		/*  9: LBA low */
-	u8	lbam;		/* 10: LBA mid */
-	u8	lbah;		/* 11: LBA high */
-
-	u8	device;		/* 12: device select */
-
-	union {			/* 13: */
-		u8 status;	/* =C2=A0read: status =C2=A0*/
-		u8 command;	/* write: command */
-	};
-};
-
-typedef struct ide_task_s {
-	union {
-		struct ide_taskfile	tf;
-		u8			tf_array[14];
-	};
-	u32			tf_flags;
-	int			data_phase;
-	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
-} ide_task_t;
-
 void ide_tf_dump(const char *, struct ide_taskfile *);
=20
 void ide_exec_command(ide_hwif_t *, u8);
