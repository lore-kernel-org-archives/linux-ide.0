From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 09/09] sata_mv cache main_irq_mask register in hpriv
Date: Sat, 17 May 2008 13:38:00 -0400
Message-ID: <482F17F8.3010403@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca> <482F179E.8020602@rtr.ca> <482F17C3.8020106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2708 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991AbYEQRiB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:38:01 -0400
In-Reply-To: <482F17C3.8020106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Part five of simplifying/fixing handling of the main_irq_mask register
to resolve unexpected interrupt issues observed in 2.6.26-rc*.

Keep a cached copy of the main_irq_mask so that we don't have
to stall the CPU to read it on every pass through mv_interrupt.

This significantly speeds up interrupt handling, both for sata_mv,
and for any other driver/device sharing the same PCI IRQ line.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-16 16:06:23.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-16 16:02:55.000000000 -0400
@@ -458,6 +458,7 @@
 
 struct mv_host_priv {
 	u32			hp_flags;
+	u32			main_irq_mask;
 	struct mv_port_signal	signal[8];
 	const struct mv_hw_ops	*ops;
 	int			n_ports;
@@ -843,10 +844,12 @@
 	struct mv_host_priv *hpriv = host->private_data;
 	u32 old_mask, new_mask;
 
-	old_mask = readl(hpriv->main_irq_mask_addr);
+	old_mask = hpriv->main_irq_mask;
 	new_mask = (old_mask & ~disable_bits) | enable_bits;
-	if (new_mask != old_mask)
+	if (new_mask != old_mask) {
+		hpriv->main_irq_mask = new_mask;
 		writelfl(new_mask, hpriv->main_irq_mask_addr);
+	}
 }
 
 static void mv_enable_port_irqs(struct ata_port *ap,
@@ -2200,12 +2203,11 @@
 	struct ata_host *host = dev_instance;
 	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int handled = 0;
-	u32 main_irq_cause, main_irq_mask, pending_irqs;
+	u32 main_irq_cause, pending_irqs;
 
 	spin_lock(&host->lock);
 	main_irq_cause = readl(hpriv->main_irq_cause_addr);
-	main_irq_mask  = readl(hpriv->main_irq_mask_addr);
-	pending_irqs   = main_irq_cause & main_irq_mask;
+	pending_irqs   = main_irq_cause & hpriv->main_irq_mask;
 	/*
 	 * Deal with cases where we either have nothing pending, or have read
 	 * a bogus register value which can indicate HW removal or PCI fault.
