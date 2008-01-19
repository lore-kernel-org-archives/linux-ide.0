From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_mpc52xx: remove un-needed assignment
Date: Sat, 19 Jan 2008 15:48:59 +0000
Message-ID: <20080119154859.1d8d0b3a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38289 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761016AbYASPux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 10:50:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org


ata_irq is always assigned so does not need to be initialised to zero.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_mpc52xx.c linux-2.6.24-rc8-mm1/drivers/ata/pata_mpc52xx.c
--- linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_mpc52xx.c	2008-01-19 14:22:32.000000000 +0000
+++ linux-2.6.24-rc8-mm1/drivers/ata/pata_mpc52xx.c	2008-01-19 14:56:41.000000000 +0000
@@ -364,7 +364,7 @@
 {
 	unsigned int ipb_freq;
 	struct resource res_mem;
-	int ata_irq = NO_IRQ;
+	int ata_irq;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv;
 	int rv;
