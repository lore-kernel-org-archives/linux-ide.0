From: Li Yang <leoli@freescale.com>
Subject: [PATCH 06/12] ata/sata_fsl: cleanup needless casts to/from void __iomem *
Date: Wed, 31 Oct 2007 19:27:58 +0800
Message-ID: <1193830084-22298-6-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:44054 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbXJaLRv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:51 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9VBHnQ1007322
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:49 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHF005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:48 -0500 (CDT)
In-Reply-To: <1193830084-22298-5-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Li Yang <leoli@freescale.com>

From: Jeff Garzik <jeff@garzik.org>

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e04fb75..e3bf954 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -483,7 +483,7 @@ static int sata_fsl_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
 
 	VPRINTK("xx_scr_write, reg_in = %d\n", sc_reg);
 
-	iowrite32(val, (void __iomem *)ssr_base + (sc_reg * 4));
+	iowrite32(val, ssr_base + (sc_reg * 4));
 	return 0;
 }
 
@@ -507,7 +507,7 @@ static int sata_fsl_scr_read(struct ata_port *ap, unsigned int sc_reg_in,
 
 	VPRINTK("xx_scr_read, reg_in = %d\n", sc_reg);
 
-	*val = ioread32((void __iomem *)ssr_base + (sc_reg * 4));
+	*val = ioread32(ssr_base + (sc_reg * 4));
 	return 0;
 }
 
-- 
1.5.3.2.104.g41ef

