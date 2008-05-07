From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide: fix do_probe() to use SELECT_DRIVE()
Date: Wed, 7 May 2008 19:41:29 +0200
Message-ID: <200805071941.29674.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:24445 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633AbYEGR3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 13:29:07 -0400
Received: by mu-out-0910.google.com with SMTP id w8so327384mue.1
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 10:29:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fix one place in do_probe() which used ->OUTB directly instead
of calling SELECT_DRIVE() (so ->selectproc method is also used).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -478,7 +478,7 @@ static int do_probe (ide_drive_t *drive,
 			printk(KERN_ERR "%s: no response (status = 0x%02x), "
 					"resetting drive\n", drive->name, stat);
 			msleep(50);
-			hwif->OUTB(drive->select.all, io_ports->device_addr);
+			SELECT_DRIVE(drive);
 			msleep(50);
 			hwif->OUTBSYNC(drive, WIN_SRST, io_ports->command_addr);
 			(void)ide_busy_sleep(hwif);
