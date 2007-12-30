From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] au1xxx-ide: device tree bugfix
Date: Sun, 30 Dec 2007 18:23:49 +0100
Message-ID: <200712301823.49573.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:7547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbXL3Rbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 12:31:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2175201ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Dec 2007 09:31:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Add missing hw.dev setup (so hwif->gendev.parent will be set by
ide_init_port_hw() to point to the parent device).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -602,6 +602,7 @@ static int au_ide_probe(struct device *d
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
 	hw.irq = ahwif->irq;
+	hw.dev = dev;
 	hw.chipset = ide_au1xxx;
 
 	ide_init_port_hw(hwif, &hw);
