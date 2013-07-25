From: Xinghai Yu <yuxinghai@cn.fujitsu.com>
Subject: [PATCH] ide-disk_proc: use macro to replace magic number
Date: Thu, 25 Jul 2013 18:32:42 +0800
Message-ID: <1374748362-19687-1-git-send-email-yuxinghai@cn.fujitsu.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:45218 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755345Ab3GYKgL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jul 2013 06:36:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, Xinghai Yu <yuxinghai@cn.fujitsu.com>

Signed-off-by: Xinghai Yu <yuxinghai@cn.fujitsu.com>
---
 drivers/ide/ide-ioctls.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 4d19eb9..6233fa2 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -141,8 +141,8 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	if (args[0] == ATA_CMD_SMART) {
 		tf->nsect = args[3];
 		tf->lbal  = args[1];
-		tf->lbam  = 0x4f;
-		tf->lbah  = 0xc2;
+		tf->lbam  = ATA_SMART_LBAM_PASS;
+		tf->lbah  = ATA_SMART_LBAH_PASS;
 		cmd.valid.out.tf = IDE_VALID_OUT_TF;
 		cmd.valid.in.tf  = IDE_VALID_NSECT;
 	} else {
-- 
1.7.1

