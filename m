From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 05/11] ide: fixes io_32bit race in ide_taskfile_ioctl()
Date: Thu, 10 Feb 2005 17:38:34 +0900 (KST)
Message-ID: <20050210083829.8739C4AB@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
Received: from wproxy.gmail.com ([64.233.184.204]:18902 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262059AbVBJIio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2005 03:38:44 -0500
Received: by wproxy.gmail.com with SMTP id 36so227988wri
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2005 00:38:43 -0800 (PST)
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>


05_ide_ATA_TFLAG_IO_16BIT.patch

	In ide_taskfile_ioctl(), there was a race condition involving
	drive->io_32bit.  It was cleared and restored during ioctl
	requests but there was no synchronization with other requests.
	So, other requests could execute with the altered io_32bit
	setting or updated drive->io_32bit could be overwritten by
	ide_taskfile_ioctl().

	This patch adds ATA_TFLAG_IO_16BIT flag to indicate to
	ide_pio_datablock() that 16bit IO is needed regardless of
	drive->io_32bit settting.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-taskfile.c |   14 ++++++++++----
 include/linux/ata.h        |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.172900876 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:01.539839336 +0900
@@ -315,8 +315,15 @@ static void ide_pio_multi(ide_drive_t *d
 static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
+	int saved_io_32bit = drive->io_32bit;
+
 	if (rq->bio)	/* fs request */
 		rq->errors = 0;
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
+		ide_task_t *task = rq->special;
+		if (task->flags & ATA_TFLAG_IO_16BIT)
+			drive->io_32bit = 0;
+	}
 
 	switch (drive->hwif->data_phase) {
 	case TASKFILE_MULTI_IN:
@@ -327,6 +334,8 @@ static inline void ide_pio_datablock(ide
 		ide_pio_sector(drive, write);
 		break;
 	}
+
+	drive->io_32bit = saved_io_32bit;
 }
 
 static ide_startstop_t task_error(ide_drive_t *drive, struct request *rq,
@@ -520,7 +529,6 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	int tasksize		= sizeof(struct ide_task_request_s);
 	int taskin		= 0;
 	int taskout		= 0;
-	u8 io_32bit		= drive->io_32bit;
 	char __user *buf = (char __user *)arg;
 
 //	printk("IDE Taskfile ...\n");
@@ -573,10 +581,10 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	args.data_phase   = req_task->data_phase;
 	args.command_type = req_task->req_cmd;
 
+	args.flags = ATA_TFLAG_IO_16BIT;
 	if (drive->addressing == 1)
 		args.flags |= ATA_TFLAG_LBA48;
 
-	drive->io_32bit = 0;
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
@@ -656,8 +664,6 @@ abort:
 
 //	printk("IDE Taskfile ioctl ended. rc = %i\n", err);
 
-	drive->io_32bit = io_32bit;
-
 	return err;
 }
 
Index: linux-ide/include/linux/ata.h
===================================================================
--- linux-ide.orig/include/linux/ata.h	2005-02-10 17:31:48.610711131 +0900
+++ linux-ide/include/linux/ata.h	2005-02-10 17:38:01.540839168 +0900
@@ -174,6 +174,7 @@ enum {
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
 	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+	ATA_TFLAG_IO_16BIT	= (1 << 4), /* force 16bit pio */
 };
 
 enum ata_tf_protocols {
