From: Li Yang <leoli@freescale.com>
Subject: [PATCH 07/12] ata/sata_fsl: remove unneeded on-stack copy of FIS
Date: Wed, 31 Oct 2007 19:27:59 +0800
Message-ID: <1193830084-22298-7-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56745 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbXJaLRx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:53 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHp9v004872
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:51 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHH005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:50 -0500 (CDT)
In-Reply-To: <1193830084-22298-6-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Li Yang <leoli@freescale.com>

From: Jeff Garzik <jeff@garzik.org>

Remove unneeded on-stack copy of FIS
in sata_fsl_cache_taskfile_from_d2h_fis().

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e3bf954..c47f2d4 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -561,7 +561,6 @@ static inline void sata_fsl_cache_taskfile_from_d2h_fis(struct ata_queued_cmd
 							struct ata_port *ap)
 {
 	struct sata_fsl_port_priv *pp = ap->private_data;
-	u8 fis[6 * 4];
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
 	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
@@ -569,8 +568,7 @@ static inline void sata_fsl_cache_taskfile_from_d2h_fis(struct ata_queued_cmd
 
 	cd = pp->cmdentry + tag;
 
-	memcpy(fis, &cd->sfis, 6 * 4);	/* should we use memcpy_from_io() */
-	ata_tf_from_fis(fis, &pp->tf);
+	ata_tf_from_fis(cd->sfis, &pp->tf);
 }
 
 static u8 sata_fsl_check_status(struct ata_port *ap)
-- 
1.5.3.2.104.g41ef

