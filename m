From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
Date: Thu, 3 Mar 2005 12:03:18 +0900
Message-ID: <20050303030318.GA25410@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from wproxy.gmail.com ([64.233.184.201]:49074 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVCCDDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2005 22:03:33 -0500
Received: by wproxy.gmail.com with SMTP id 68so426795wra
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2005 19:03:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

 Hello, Bartlomiej.

 This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
all your recent 9 patches.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: linux-taskfile-ng/drivers/ide/ide-dma.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-03 11:59:16.485582413 +0900
+++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-03 12:00:07.753376048 +0900
@@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
 			struct request *rq = HWGROUP(drive)->rq;
-			ide_driver_t *drv;
 
-			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
-			drv->end_request(drive, 1, rq->nr_sectors);
+			if (rq->rq_disk) {
+				ide_driver_t *drv;
+
+				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+				drv->end_request(drive, 1, rq->nr_sectors);
+			} else
+				ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
