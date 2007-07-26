From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_mpiix: Forget a conversion
Date: Thu, 26 Jul 2007 19:25:41 +0100
Message-ID: <20070726192541.24202e5a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55210 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934857AbXGZSTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 14:19:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

This one applies after the big patch. Without it the mpiix module won't
load as it still tries to use the old ata_std_ports symbol which I only
just noticed after posting the main diff.

(Andrew you might want to just cat the two together, sorry about that)

Signed-off-by: Alan Cox <alan@redhat.com.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_mpiix.c linux-2.6.23rc1-mm1/drivers/ata/pata_mpiix.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_mpiix.c	2007-07-26 15:01:52.951747064 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/pata_mpiix.c	2007-07-26 15:21:13.273351368 +0100
@@ -201,6 +201,7 @@
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *cmd_addr, *ctl_addr;
+	unsigned long cmd_port, ctl_port;
 	u16 idetim;
 	int irq;
 
@@ -222,14 +223,17 @@
 	/* See if it's primary or secondary channel... */
 	if (!(idetim & SECONDARY)) {
 		irq = 14;
-		cmd_addr = devm_ioport_map(&dev->dev, 0x1F0, 8);
-		ctl_addr = devm_ioport_map(&dev->dev, 0x3F6, 1);
+		cmd_port = 0x1F0;
+		ctl_port = 0x3F6;
 	} else {
 		irq = 15;
-		cmd_addr = devm_ioport_map(&dev->dev, 0x170, 8);
-		ctl_addr = devm_ioport_map(&dev->dev, 0x376, 1);
+		cmd_port = 0x170;
+		ctl_port = 0x376;
 	}
 
+	cmd_addr = devm_ioport_map(&dev->dev, cmd_port, 8);
+	ctl_addr = devm_ioport_map(&dev->dev, ctl_port, 1);
+
 	if (!cmd_addr || !ctl_addr)
 		return -ENOMEM;
 
@@ -247,9 +251,12 @@
 	ap->ioaddr.cmd_addr = cmd_addr;
 	ap->ioaddr.ctl_addr = ctl_addr;
 	ap->ioaddr.altstatus_addr = ctl_addr;
+	
+	ap->busaddr.cmd_addr = cmd_port;
+	ap->busaddr.ctl_addr = ctl_port;
 
 	/* Let libata fill in the port details */
-	ata_std_ports(&ap->ioaddr);
+	ata_std_io_ports(&ap->ioaddr, &ap->busaddr);
 
 	/* activate host */
 	return ata_host_activate(host, irq, ata_interrupt, IRQF_SHARED,
