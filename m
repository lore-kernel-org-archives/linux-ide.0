From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/18] ide-cd: fold cdrom_start_seek into ide_cd_do_request
Date: Thu, 12 Jun 2008 08:41:01 +0200
Message-ID: <1213252870-20474-10-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:21650 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759497AbYFLGrs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:47:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2383441fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:47:48 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Do what the compiler does anyway: inline a function that is used only once. This
saves us the overhead of a function call and the function is small enough to be
embedded in the callsite anyways.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index abf9af2..b8c98e1 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -778,14 +778,6 @@ static ide_startstop_t cdrom_start_seek_continuation(ide_drive_t *drive)
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_seek_intr);
 }
 
-static void cdrom_start_seek(ide_drive_t *drive)
-{
-	struct cdrom_info *info = drive->driver_data;
-
-	info->dma = 0;
-	info->start_seek = jiffies;
-}
-
 /*
  * Fix up a possibly partially-processed request so that we can start it over
  * entirely, or even put it back on the request queue.
@@ -1233,7 +1225,8 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		    drive->dsc_overlap) {
 			xferlen = 0;
 			fn = cdrom_start_seek_continuation;
-			cdrom_start_seek(drive);
+			info->dma = 0;
+			info->start_seek = jiffies;
 		} else {
 			xferlen = 32768;
 			fn = cdrom_start_rw_cont;
-- 
1.5.5.1

