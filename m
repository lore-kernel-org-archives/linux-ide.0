From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 06/08] ide: convert set_xfer_rate() to use taskfile ioctl
Date: Sat,  5 Mar 2005 10:48:28 +0900 (KST)
Message-ID: <20050305014823.8EA1C3D9@htj.dyndns.org>
References: <20050305014758.4EDB4992@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org


06_ide_taskfile_set_xfer_rate.patch

	Convert set_xfer_rate() to use taskfile ioctl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide.c	2005-03-05 10:37:51.451393268 +0900
+++ linux-taskfile-ng/drivers/ide/ide.c	2005-03-05 10:46:59.933824315 +0900
@@ -1250,10 +1250,19 @@ static int set_pio_mode (ide_drive_t *dr
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
-	int err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	ide_task_t task;
+	struct ata_taskfile *tf = &task.tf;
+	int err;
+
+	memset(&task, 0, sizeof(task));
+
+	tf->protocol	= ATA_PROT_NODATA;
+	tf->flags	= ATA_TFLAG_OUT_ADDR;
+	tf->feature	= SETFEATURES_XFER;
+	tf->nsect	= arg;
+	tf->command	= WIN_SETFEATURES;
 
+	err = ide_raw_taskfile(drive, &task, 0, NULL);
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
 		ide_driveid_update(drive);
