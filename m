From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/15] ali14xx: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:31:26 +0200
Message-ID: <200710012331.26965.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:25973 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbXJAVjf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:35 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3067279nfb
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Stop abusing ide_lock lock by switching to a private locking.

Fixes same issue as fixed by Alan Cox in atiixp host driver with
commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ali14xx.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -102,6 +102,8 @@ static void outReg (u8 data, u8 reg)
 	outb_p(data, dataPort);
 }
 
+static DEFINE_SPINLOCK(ali14xx_lock);
+
 /*
  * Set PIO mode for the specified drive.
  * This function computes timing parameters
@@ -129,14 +131,14 @@ static void ali14xx_set_pio_mode(ide_dri
 
 	/* stuff timing parameters into controller registers */
 	driveNum = (HWIF(drive)->index << 1) + drive->select.b.unit;
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&ali14xx_lock, flags);
 	outb_p(regOn, basePort);
 	outReg(param1, regTab[driveNum].reg1);
 	outReg(param2, regTab[driveNum].reg2);
 	outReg(param3, regTab[driveNum].reg3);
 	outReg(param4, regTab[driveNum].reg4);
 	outb_p(regOff, basePort);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&ali14xx_lock, flags);
 }
 
 /*
