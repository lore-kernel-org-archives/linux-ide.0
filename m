From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cs: use ide_std_init_ports()
Date: Wed, 23 Jan 2008 00:03:06 +0100
Message-ID: <200801230003.07211.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:6365 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbYAVW74 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 17:59:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so13788ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 14:59:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


No reason to use ide_init_hwif_ports() in ide-cs (as a nice side-effect
this makes ide-cs work on archs that don't define IDE_ARCH_OBSOLETE_INIT).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide-cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/legacy/ide-cs.c
===================================================================
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -151,7 +151,7 @@ static int idecs_register(unsigned long 
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    ide_std_init_ports(&hw, io, ctl);
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
