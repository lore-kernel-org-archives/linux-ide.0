From: akpm@linux-foundation.org
Subject: [patch 4/9] pata_pcmcia: minor cleanups and support for dual channel cards
Date: Thu, 13 Dec 2007 16:01:39 -0800
Message-ID: <200712140001.lBE01daJ025435@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48543 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758829AbXLNAC3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:02:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_pcmcia.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff -puN drivers/ata/pata_pcmcia.c~pata_pcmcia-minor-cleanups-and-support-for-dual-channel-cards drivers/ata/pata_pcmcia.c
--- a/drivers/ata/pata_pcmcia.c~pata_pcmcia-minor-cleanups-and-support-for-dual-channel-cards
+++ a/drivers/ata/pata_pcmcia.c
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.3.3"
 
 /*
  *	Private data structure to glue stuff together
@@ -198,7 +198,6 @@ do { last_fn = (fn); if ((last_ret = (re
 /**
  *	pcmcia_init_one		-	attach a PCMCIA interface
  *	@pdev: pcmcia device
- *	@ops: operations for this device
  *
  *	Register a PCMCIA IDE interface. Such interfaces are PIO 0 and
  *	shared IRQ.
@@ -217,9 +216,10 @@ static int pcmcia_init_one(struct pcmcia
 		cistpl_cftable_entry_t dflt;
 	} *stk = NULL;
 	cistpl_cftable_entry_t *cfg;
-	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM;
+	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
 	unsigned long io_base, ctl_base;
 	void __iomem *io_addr, *ctl_addr;
+	int n_ports = 1;
 
 	struct ata_port_operations *ops = &pcmcia_port_ops;
 
@@ -348,7 +348,7 @@ next_entry:
 	/* FIXME: Could be more ports at base + 0x10 but we only deal with
 	   one right now */
 	if (pdev->io.NumPorts1 >= 0x20)
-		printk(KERN_WARNING DRV_NAME ": second channel not yet supported.\n");
+		n_ports = 2;
 
 	if (pdev->manf_id == 0x0097 && pdev->card_id == 0x1620)
 		ops = &pcmcia_8bit_port_ops;
@@ -357,20 +357,23 @@ next_entry:
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
_
