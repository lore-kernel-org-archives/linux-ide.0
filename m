From: Ralf Baechle <ralf@linux-mips.org>
Subject: [IDE] au1xxx: Fix use of mixed declarations and code
Date: Wed, 14 Mar 2007 15:26:03 +0000
Message-ID: <20070314152603.GA5934@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751033AbXCNP27@vger.kernel.org>
Received: from localhost.localdomain ([127.0.0.1]:52681 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022456AbXCNP2T (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Wed, 14 Mar 2007 15:28:19 +0000
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

drivers/ide/mips/au1xxx-ide.c:684: warning: ISO C90 forbids mixed declarations and code

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index b2dc028..d54d9fe 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -639,6 +639,7 @@ static int au_ide_probe(struct device *dev)
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
 	struct resource *res;
+	hw_regs_t *hw;
 	int ret = 0;
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA)
@@ -681,7 +682,7 @@ static int au_ide_probe(struct device *dev)
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw_regs_t *hw 			= &hwif->hw;
+	hw 				= &hwif->hw;
 	hwif->irq = hw->irq             = ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
 
