From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/14] ide_platform: use struct ide_port_info
Date: Tue, 10 Jun 2008 22:51:49 +0200
Message-ID: <20080610205149.18469.97463.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbYFJUuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:50:15 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:50:12 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use struct ide_port_info.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide_platform.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -44,6 +44,10 @@ static void __devinit plat_ide_setup_por
 	hw->chipset = ide_generic;
 }
 
+static const struct ide_port_info platform_ide_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static int __devinit plat_ide_probe(struct platform_device *pdev)
 {
 	struct resource *res_base, *res_alt, *res_irq;
@@ -54,6 +58,7 @@ static int __devinit plat_ide_probe(stru
 	int ret = 0;
 	int mmio = 0;
 	hw_regs_t hw;
+	struct ide_port_info d = platform_ide_port_info;
 
 	pdata = pdev->dev.platform_data;
 
@@ -102,13 +107,13 @@ static int __devinit plat_ide_probe(stru
 	ide_init_port_hw(hwif, &hw);
 
 	if (mmio) {
-		hwif->host_flags = IDE_HFLAG_MMIO;
+		d.host_flags |= IDE_HFLAG_MMIO;
 		default_hwif_mmiops(hwif);
 	}
 
 	idx[0] = hwif->index;
 
-	ide_device_add(idx, NULL);
+	ide_device_add(idx, &d);
 
 	platform_set_drvdata(pdev, hwif);
 
