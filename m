From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] sata_fsl.c: fix 8315DS workaround
Date: Mon, 4 Aug 2008 11:46:11 +0300
Message-ID: <20080804084611.GA6088@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:39883 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbYHDIr2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 04:47:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ashish kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>, Jeff Garzik <jeff@garzik.org>, galak@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, "Robert P. J. Day" <rpjday@crashcourse.ca>

Commit e7eac96e8f0e57a6e9f94943557bc2b23be31471 (ata/sata_fsl: Move 
MPC8315DS link speed limit workaround to specific ifdef) aimed at 
limiting the workaround only to the affected hardware, but since the 
#ifdef used a nonexisting kconfig variable it actually killed
the workaround.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cd54dd8b6a8bca44ead212d12fe116702cc31ed7 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 3924e72..45878ef 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -640,7 +640,7 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
-#ifdef CONFIG_MPC8315_DS
+#ifdef CONFIG_MPC831x_RDB
 	/*
 	 * Workaround for 8315DS board 3gbps link-up issue,
 	 * currently limit SATA port to GEN1 speed

