From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pcmcia: Minor cleanups and support for dual channel
 cards
Date: Mon, 19 Nov 2007 14:43:07 +0000
Message-ID: <20071119144307.7b67f09e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58050 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753240AbXKSOoz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:44:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c linux-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/pata_pcmcia.c	2007-11-16 18:18:38.000000000 +0000
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.3.3"
 
 /*
  *	Private data structure to glue stuff together
@@ -198,7 +198,6 @@
 /**
  *	pcmcia_init_one		-	attach a PCMCIA interface
  *	@pdev: pcmcia device
- *	@ops: operations for this device
  *
  *	Register a PCMCIA IDE interface. Such interfaces are PIO 0 and
  *	shared IRQ.
@@ -217,9 +216,10 @@
 		cistpl_cftable_entry_t dflt;
 	} *stk = NULL;
 	cistpl_cftable_entry_t *cfg;
-	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM;
+	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
 	unsigned long io_base, ctl_base;
 	void __iomem *io_addr, *ctl_addr;
+	int n_ports = 1;
 
 	struct ata_port_operations *ops = &pcmcia_port_ops;
 
@@ -348,7 +348,7 @@
 	/* FIXME: Could be more ports at base + 0x10 but we only deal with
 	   one right now */
 	if (pdev->io.NumPorts1 >= 0x20)
-		printk(KERN_WARNING DRV_NAME ": second channel not yet supported.\n");
+		n_ports = 2;
 
 	if (pdev->manf_id == 0x0097 && pdev->card_id == 0x1620)
 		ops = &pcmcia_8bit_port_ops;
@@ -357,20 +357,23 @@
 	 *	sane.
 	 */
 	ret = -ENOMEM;
-	host = ata_host_alloc(&pdev->dev, 1);
+	host = ata_host_alloc(&pdev->dev, n_ports);
 	if (!host)
 		goto failed;
-	ap = host->ports[0];
 
-	ap->ops = ops;
-	ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
-	ap->flags |= ATA_FLAG_SLAVE_POSS;
-	ap->ioaddr.cmd_addr = io_addr;
-	ap->ioaddr.altstatus_addr = ctl_addr;
-	ap->ioaddr.ctl_addr = ctl_addr;
-	ata_std_ports(&ap->ioaddr);
+	for (p = 0; p < n_ports; p++) {
+		ap = host->ports[p];
 
-	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io_base, ctl_base);
+		ap->ops = ops;
+		ap->pio_mask = 1;		/* ISA so PIO 0 cycles */
+		ap->flags |= ATA_FLAG_SLAVE_POSS;
+		ap->ioaddr.cmd_addr = io_addr + 0x10 * p;
+		ap->ioaddr.altstatus_addr = ctl_addr + 0x10 * p;
+		ap->ioaddr.ctl_addr = ctl_addr + 0x10 * p;
+		ata_std_ports(&ap->ioaddr);
+
+		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io_base, ctl_base);
+	}
 
 	/* activate */
 	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_interrupt,
