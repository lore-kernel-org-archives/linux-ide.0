From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/14] rapide: use struct ide_port_info
Date: Tue, 10 Jun 2008 22:51:29 +0200
Message-ID: <20080610205129.18469.30843.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbYFJUtx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:49:53 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:49:52 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use struct ide_port_info.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -11,6 +11,10 @@
 
 #include <asm/ecard.h>
 
+static struct const ide_port_info rapide_port_info = {
+	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
+};
+
 static void rapide_setup_ports(hw_regs_t *hw, void __iomem *base,
 			       void __iomem *ctrl, unsigned int sz, int irq)
 {
@@ -53,12 +57,11 @@ rapide_probe(struct expansion_card *ec, 
 
 		ide_init_port_hw(hwif, &hw);
 
-		hwif->host_flags = IDE_HFLAG_MMIO;
 		default_hwif_mmiops(hwif);
 
 		idx[0] = hwif->index;
 
-		ide_device_add(idx, NULL);
+		ide_device_add(idx, &rapide_port_info);
 
 		ecard_set_drvdata(ec, hwif);
 		goto out;
