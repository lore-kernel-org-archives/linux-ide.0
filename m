From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/11] ide-pmac: remove nIEN clearing from pmac_ide_do_setfeature()
Date: Sun, 22 Jul 2007 20:33:55 +0200
Message-ID: <200707222033.55198.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48318 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339AbXGVSTM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so97866nfb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Upper layers are responsible for controlling nIEN so don't clear nIEN after
command execution in pmac_ide_do_setfeature().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -555,7 +555,6 @@ pmac_ide_do_setfeature(ide_drive_t *driv
 	result = __ide_wait_stat(drive, drive->ready_stat,
 				 BUSY_STAT|DRQ_STAT|ERR_STAT,
 				 WAIT_CMD, &stat);
-	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	if (result)
 		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
 			"after SET_FEATURE !\n", drive->name);
