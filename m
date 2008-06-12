From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 10/18] ide-cd: move request prep from cdrom_start_seek_continuation to rq issue path
Date: Thu, 12 Jun 2008 08:41:02 +0200
Message-ID: <1213252870-20474-11-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:8725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbYFLGlK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381826fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:06 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... by factoring out the rq preparation code into a separate
function called in the request routine. Bart: As a nice
side effect, this minimizes the IRQ handler execution time.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b8c98e1..da0f28c 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -763,9 +763,8 @@ static ide_startstop_t cdrom_seek_intr(ide_drive_t *drive)
 	return ide_stopped;
 }
 
-static ide_startstop_t cdrom_start_seek_continuation(ide_drive_t *drive)
+static void ide_cd_prepare_seek_request(ide_drive_t *drive, struct request *rq)
 {
-	struct request *rq = HWGROUP(drive)->rq;
 	sector_t frame = rq->sector;
 
 	sector_div(frame, queue_hardsect_size(drive->queue) >> SECTOR_BITS);
@@ -775,6 +774,11 @@ static ide_startstop_t cdrom_start_seek_continuation(ide_drive_t *drive)
 	put_unaligned(cpu_to_be32(frame), (unsigned int *) &rq->cmd[2]);
 
 	rq->timeout = ATAPI_WAIT_PC;
+}
+
+static ide_startstop_t cdrom_start_seek_continuation(ide_drive_t *drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_seek_intr);
 }
 
@@ -1223,10 +1227,14 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		    IDE_LARGE_SEEK(info->last_block, block,
 			    IDECD_SEEK_THRESHOLD) &&
 		    drive->dsc_overlap) {
+
 			xferlen = 0;
 			fn = cdrom_start_seek_continuation;
 			info->dma = 0;
 			info->start_seek = jiffies;
+
+			ide_cd_prepare_seek_request(drive, rq);
+
 		} else {
 			xferlen = 32768;
 			fn = cdrom_start_rw_cont;
-- 
1.5.5.1

