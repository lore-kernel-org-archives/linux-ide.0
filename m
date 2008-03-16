From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Subject should be [PATCHSET libata-dev#upstream-fixes] libata: prefer
 hardreset, take #3
Date: Sun, 16 Mar 2008 23:07:38 +0100
Message-ID: <18397.39466.462694.412688@harpo.it.uu.se>
References: <12052096544056-git-send-email-htejun@gmail.com>
	<47D60A9E.1060609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33166 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYCPWHv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Mar 2008 18:07:51 -0400
In-Reply-To: <47D60A9E.1060609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, mikpe@it.uu.se

Tejun Heo wrote (in first mail with wrong Subject):
> It still needs Mikael's ack regarding behavior
> change on sata_promise.

Unfortunately it breaks sata_promise:

ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7: ST3120813AS, 3.AAD, max UDMA/133
ata5.00: 234441648 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata5: hotplug_status 0x10
ata5: hard resetting link
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: configured for UDMA/133
ata5: limiting SATA link speed to 1.5 Gbps
ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t3
ata5: hotplug_status 0x10
ata5: hard resetting link
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: configured for UDMA/133
ata5.00: limiting speed to UDMA/100:PIO4
ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t2
ata5: hotplug_status 0x10
ata5: hard resetting link
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: configured for UDMA/100
ata5.00: limiting speed to UDMA/33:PIO4
ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t1
ata5: hotplug_status 0x10
ata5: hard resetting link
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: configured for UDMA/33
ata5: EH pending after 5 tries, giving up
ata5: EH complete

What happens is that a hard reset triggers cable sensing and
reporting, so we get stray hotplug events which confuses things.

One solution is to mask/unmask a port's hotplug events around
calls to sata_std_hardreset(). (This also matches what Promise's
reference driver does, except their hard reset fiddles with
Promise specific registers.) The patch below is a draft which
implements that solution.

A problem is that Promise SATA chips implement per-port hotplug
control using port-specific bits in a single global register.
So I have to map the link to the corresponding ata engine number:
this mapping doesn't seem to be present anywhere, so in this
draft patch I'm resorting to searching the host's ports[] array.

Also, since the ports share a global register it's important that
at most one port goes through a hard reset sequence at a time.
Can I assume that libata EH guarantees mutual exclusion?

With this patch in place the hard reset conversion does seem to
work Ok on a SATA300 TX4 card.

/Mikael

--- linux-2.6.25-rc5/drivers/ata/sata_promise.c.~1~	2008-03-16 20:38:11.000000000 +0100
+++ linux-2.6.25-rc5/drivers/ata/sata_promise.c	2008-03-16 22:31:48.000000000 +0100
@@ -673,9 +673,65 @@ static void pdc_pata_error_handler(struc
 	pdc_common_error_handler(ap, NULL);
 }
 
+static int pdc_is_sataii_tx4(unsigned long flags)
+{
+	const unsigned long mask = PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS;
+	return (flags & mask) == mask;
+}
+
+static unsigned int pdc_port_no_to_ata_no(unsigned int port_no,
+					  int is_sataii_tx4)
+{
+	static const unsigned char sataii_tx4_port_remap[4] = { 3, 1, 0, 2};
+	return is_sataii_tx4 ? sataii_tx4_port_remap[port_no] : port_no;
+}
+
+static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_host *host = ap->host;
+	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
+	unsigned int hotplug_offset, ata_no;
+	u32 hotplug_status;
+	int is_sataii_tx4, i, ret;
+
+	if (host->ports[0]->flags & PDC_FLAG_GEN_II)
+		hotplug_offset = PDC2_SATA_PLUG_CSR;
+	else
+		hotplug_offset = PDC_SATA_PLUG_CSR;
+	is_sataii_tx4 = pdc_is_sataii_tx4(host->ports[0]->flags);
+
+	/* XXX: this is gross and only works for 4-port SATA chips */
+	for(i = 0; i < 4/*XXX: how to detect # ports?*/ && host->ports[i] != ap; ++i)
+		;
+	if (i >= 4) {
+		printk(KERN_ERR "%s: unable to map ap to ata_no\n", __FUNCTION__);
+		return sata_std_hardreset(link, class, deadline);
+	}
+	ata_no = pdc_port_no_to_ata_no(i, is_sataii_tx4);
+
+	hotplug_status = readl(mmio_base + hotplug_offset);
+
+	/* clear hotplug flags, mask hotplug ints */
+	hotplug_status |= (0x11 << ata_no);
+	hotplug_status |= (0x11 << ata_no) << 16;
+	writel(hotplug_status, mmio_base + hotplug_offset);
+	readl(mmio_base + hotplug_offset); /* flush */
+
+	ret = sata_std_hardreset(link, class, deadline);
+
+	/* clear hotplug flags, unmask hotplug ints */
+	hotplug_status &= ~((0x11 << ata_no) << 16);
+	writel(hotplug_status, mmio_base + hotplug_offset);
+	readl(mmio_base + hotplug_offset); /* flush */
+
+	return ret;
+}
+
 static void pdc_sata_error_handler(struct ata_port *ap)
 {
-	pdc_common_error_handler(ap, sata_std_hardreset);
+	pdc_common_error_handler(ap, pdc_sata_hardreset);
 }
 
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -765,19 +821,6 @@ static void pdc_irq_clear(struct ata_por
 	readl(mmio + PDC_INT_SEQMASK);
 }
 
-static int pdc_is_sataii_tx4(unsigned long flags)
-{
-	const unsigned long mask = PDC_FLAG_GEN_II | PDC_FLAG_4_PORTS;
-	return (flags & mask) == mask;
-}
-
-static unsigned int pdc_port_no_to_ata_no(unsigned int port_no,
-					  int is_sataii_tx4)
-{
-	static const unsigned char sataii_tx4_port_remap[4] = { 3, 1, 0, 2};
-	return is_sataii_tx4 ? sataii_tx4_port_remap[port_no] : port_no;
-}
-
 static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
