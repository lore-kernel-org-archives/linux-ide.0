From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 4/8] ide-cd: remove xferlen arg to cdrom_start_packet_command
Date: Thu, 18 Dec 2008 08:40:48 +0100
Message-ID: <1229586052-3542-5-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34257 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbYLRHlB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:01 -0500
Received: by bwz14 with SMTP id 14so1054022bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:40:59 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 105e4d8..34981f5 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -520,10 +520,13 @@ end_request:
  * will be called immediately after the drive is prepared for the transfer.
  */
 static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
-						  int xferlen,
 						  ide_handler_t *handler)
 {
 	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->hwgroup->rq;
+	int xferlen;
+
+	xferlen = ide_cd_get_xferlen(rq);
 
 	ide_debug_log(IDE_DBG_PC, "Call %s, xferlen: %d\n", __func__, xferlen);
 
@@ -1175,15 +1178,12 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 					sector_t block)
 {
 	ide_handler_t *fn;
-	int xferlen;
 
 	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd[0]: 0x%x, "
 		      "rq->cmd_type: 0x%x, block: %llu\n",
 		      __func__, rq->cmd[0], rq->cmd_type,
 		      (unsigned long long)block);
 
-	xferlen = ide_cd_get_xferlen(rq);
-
 	if (blk_fs_request(rq)) {
 		fn = cdrom_start_rw_cont;
 
@@ -1210,7 +1210,7 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		return ide_stopped;
 	}
 
-	return cdrom_start_packet_command(drive, xferlen, fn);
+	return cdrom_start_packet_command(drive, fn);
 }
 
 /*
-- 
1.6.0.4

