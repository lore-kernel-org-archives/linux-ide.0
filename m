From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Current git --> kaboom [bisect] seems IDE related.
Date: Sat, 9 Feb 2008 21:28:39 +0100
Message-ID: <200802092128.39247.bzolnier@gmail.com>
References: <20080209193224.GA21448@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:23110 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbYBIUPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 15:15:25 -0500
Received: by py-out-1112.google.com with SMTP id u52so6037874pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 12:15:23 -0800 (PST)
In-Reply-To: <20080209193224.GA21448@Chamillionaire.breakpoint.cc>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Siewior <ide-bug@ml.breakpoint.cc>
Cc: Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


Hi,

On Saturday 09 February 2008, Sebastian Siewior wrote:
> Hello,
>=20
> current git results in a freeze. I tracked it down to
>=20
> |         error =3D type->get_sb(type, flags, name, data, mnt);
> in vfs_kern_mount(), fs/super.c (what is called from mount_root() dur=
ing
> the boot process). I use XFS on my rootfs partition. After this, I
> started to bisect.
> During the bisect process I stepped into two things. The commit
>=20
> |commit 813a0eb233ee67d7166241a8b389b6a76f2247f9
> |Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> |Date:   Fri Jan 25 22:17:10 2008 +0100
> |
> |    ide: switch idedisk_prepare_flush() to use REQ_TYPE_ATA_TASKFILE=
 requests
> |
> |    Based on the earlier work by Tejun Heo.
> |
> |    There should be no functionality changes caused by this patch.
> |
> |    Cc: Tejun Heo <htejun@gmail.com>
> |    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> |
> |:040000 040000 e4708c62aef233d2b07da20aedd644182258f1f1 66aea951e7c3=
2aa82621d8460b0f97ff132f23a6 M      drivers
> =20
> turned the working boot process into [1]. Since this isn't the freeze=
 I
> was looking I continued my bisect process. The commit

It could be that due to block layer changes to I/O barrier handling
allocating ATA command structure on the stack is no longer safe.

Please try booting with "hdx=3Dnoflush" kernel parameter or please try
the attached patch which should fix the issue (if my theory is correct)=
=2E

[...]

> turned the Oops into the freeze. There was no working commit in betwe=
en
> (well, git-bisect did not find one).
>=20
> My .config [2], my lspci and cpuinfo [3].
>=20
> [1] http://download.breakpoint.cc/lnx-2.6.24-post-crash.jpg
> [2] http://download.breakpoint.cc/notebook-config.txt
> [3] http://download.breakpoint.cc/system.txt

---
 drivers/ide/ide-disk.c |   14 +--
 include/linux/ide.h    |  206 ++++++++++++++++++++++++----------------=
---------
 2 files changed, 111 insertions(+), 109 deletions(-)

Index: b/drivers/ide/ide-disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -590,20 +590,20 @@ static ide_proc_entry_t idedisk_proc[] =3D
 static void idedisk_prepare_flush(struct request_queue *q, struct requ=
est *rq)
 {
 	ide_drive_t *drive =3D q->queuedata;
-	ide_task_t task;
+	ide_task_t *task =3D &drive->tf_task;
=20
-	memset(&task, 0, sizeof(task));
+	memset(task, 0, sizeof(*task));
 	if (ide_id_has_flush_cache_ext(drive->id) &&
 	    (drive->capacity64 >=3D (1UL << 28)))
-		task.tf.command =3D WIN_FLUSH_CACHE_EXT;
+		task->tf.command =3D WIN_FLUSH_CACHE_EXT;
 	else
-		task.tf.command =3D WIN_FLUSH_CACHE;
-	task.tf_flags	=3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
-	task.data_phase	=3D TASKFILE_NO_DATA;
+		task->tf.command =3D WIN_FLUSH_CACHE;
+	task->tf_flags	 =3D IDE_TFLAG_OUT_TF | IDE_TFLAG_OUT_DEVICE;
+	task->data_phase =3D TASKFILE_NO_DATA;
=20
 	rq->cmd_type =3D REQ_TYPE_ATA_TASKFILE;
 	rq->cmd_flags |=3D REQ_SOFTBARRIER;
-	rq->special =3D &task;
+	rq->special =3D task;
 }
=20
 /*
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -32,6 +32,108 @@
 # define SUPPORT_VLB_SYNC 1
 #endif
=20
+enum {
+	IDE_TFLAG_LBA48			=3D (1 << 0),
+	IDE_TFLAG_NO_SELECT_MASK	=3D (1 << 1),
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
+	union {			/* =A07: */
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
+		u8 status;	/* =A0read: status =A0*/
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
 /*
  * Used to indicate "no IRQ", should be a value that cannot be an IRQ
  * number.
@@ -386,6 +488,8 @@ typedef struct ide_drive_s {
 	struct list_head list;
 	struct device	gendev;
 	struct completion gendev_rel_comp;	/* to deal with device release() *=
/
+
+	struct ide_task_s tf_task;
 } ide_drive_t;
=20
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
@@ -798,108 +902,6 @@ extern int ide_do_drive_cmd(ide_drive_t=20
=20
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
=20
-enum {
-	IDE_TFLAG_LBA48			=3D (1 << 0),
-	IDE_TFLAG_NO_SELECT_MASK	=3D (1 << 1),
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
-	union {			/* =A07: */
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
-		u8 status;	/* =A0read: status =A0*/
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
 void ide_tf_load(ide_drive_t *, ide_task_t *);
 void ide_tf_read(ide_drive_t *, ide_task_t *);
=20
