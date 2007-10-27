From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/15] ide: fix registers loading order for WIN_SMART in execute_drive_cmd()
Date: Sat, 27 Oct 2007 19:46:06 +0200
Message-ID: <200710271946.06768.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:48608 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbXJ0Rqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026731nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Fix registers loading order for REQ_TYPE_ATA_CMD request with WIN_SMART
command in execute_drive_cmd() (load IDE_FEATURE_REG and IDE_SECTOR_REG
before loading IDE_LCYL_REG and IDE_HCYL_REG).

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -932,10 +932,10 @@ static ide_startstop_t execute_drive_cmd
  		printk("xx=0x%02x\n", args[3]);
 #endif
  		if (args[0] == WIN_SMART) {
- 			hwif->OUTB(0x4f, IDE_LCYL_REG);
- 			hwif->OUTB(0xc2, IDE_HCYL_REG);
  			hwif->OUTB(args[2],IDE_FEATURE_REG);
  			hwif->OUTB(args[1],IDE_SECTOR_REG);
+			hwif->OUTB(0x4f, IDE_LCYL_REG);
+			hwif->OUTB(0xc2, IDE_HCYL_REG);
  			ide_cmd(drive, args[0], args[3], &drive_cmd_intr);
  			return ide_started;
  		}
