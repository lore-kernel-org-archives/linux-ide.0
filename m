From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_mpc52xx: NO_IRQ is zero
Date: Thu, 3 Jan 2008 16:50:14 +0000
Message-ID: <20080103165014.483fcf10@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33394 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752306AbYACQvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 11:51:53 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c linux-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c
--- linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c	2008-01-02 16:03:58.000000000 +0000
+++ linux-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c	2008-01-02 16:13:08.000000000 +0000
@@ -364,7 +364,7 @@
 {
 	unsigned int ipb_freq;
 	struct resource res_mem;
-	int ata_irq = NO_IRQ;
+	int ata_irq;
 	struct mpc52xx_ata __iomem *ata_regs;
 	struct mpc52xx_ata_priv *priv;
 	int rv;
