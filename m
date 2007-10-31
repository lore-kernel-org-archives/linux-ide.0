From: Li Yang <leoli@freescale.com>
Subject: [PATCH 10/12] ata/sata_fsl: Move MPC8315DS link speed limit workaround to specific ifdef
Date: Wed, 31 Oct 2007 19:28:02 +0800
Message-ID: <1193830084-22298-10-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
 <1193830084-22298-3-git-send-email-leoli@freescale.com>
 <1193830084-22298-4-git-send-email-leoli@freescale.com>
 <1193830084-22298-5-git-send-email-leoli@freescale.com>
 <1193830084-22298-6-git-send-email-leoli@freescale.com>
 <1193830084-22298-7-git-send-email-leoli@freescale.com>
 <1193830084-22298-8-git-send-email-leoli@freescale.com>
 <1193830084-22298-9-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:44094 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762AbXJaLR6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:58 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9VBHuTZ007358
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:56 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdHN005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:55 -0500 (CDT)
In-Reply-To: <1193830084-22298-9-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: ashish kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>

From: ashish kalra <ashish.kalra@freescale.com>

Signed-off-by: ashish kalra <ashish.kalra@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5892472..e076e1f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -652,6 +652,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
+#ifdef CONFIG_MPC8315_DS
 	/*
 	 * Workaround for 8315DS board 3gbps link-up issue,
 	 * currently limit SATA port to GEN1 speed
@@ -664,6 +665,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	sata_fsl_scr_read(ap, SCR_CONTROL, &temp);
 	dev_printk(KERN_WARNING, dev, "scr_control, speed limited to %x\n",
 			temp);
+#endif
 
 	return 0;
 }
-- 
1.5.3.2.104.g41ef

