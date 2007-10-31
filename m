From: Li Yang <leoli@freescale.com>
Subject: [PATCH 08/12] ata/sata_fsl: remove unneeded sata_fsl_hardreset()
Date: Wed, 31 Oct 2007 19:28:00 +0800
Message-ID: <1193830084-22298-8-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
 <1193830084-22298-7-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56759 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbXJaLRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:55 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHqsa004876
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHJ005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:52 -0500 (CDT)
In-Reply-To: <1193830084-22298-7-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Li Yang <leoli@freescale.com>

From: Jeff Garzik <jeff@garzik.org>

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index c47f2d4..03629b6 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -991,25 +991,13 @@ err:
 	return -EIO;
 }
 
-static int sata_fsl_hardreset(struct ata_port *ap, unsigned int *class,
-			      unsigned long deadline)
-{
-	int retval;
-
-	retval = sata_std_hardreset(ap, class, deadline);
-
-	DPRINTK("SATA FSL : in xx_hardreset, retval = 0x%d\n", retval);
-
-	return retval;
-}
-
 static void sata_fsl_error_handler(struct ata_port *ap)
 {
 
 	DPRINTK("in xx_error_handler\n");
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, sata_fsl_softreset, sata_fsl_hardreset,
+	ata_do_eh(ap, ata_std_prereset, sata_fsl_softreset, sata_std_hardreset,
 		  ata_std_postreset);
 }
 
-- 
1.5.3.2.104.g41ef

