From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Wed, 15 Jul 2009 17:49:35 +0900
Message-ID: <4A5D981F.9020404@kernel.org>
References: <4A4FD162.30604@gmail.com> <4A552185.7090301@kernel.org> <4A5546AA.8000404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070600030709090000000603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33454 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbZGOIti (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Jul 2009 04:49:38 -0400
In-Reply-To: <4A5546AA.8000404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zdenek Kaspar <zkaspar82@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600030709090000000603
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Zdenek Kaspar wrote:
> Hello Tejun, thanks for your reply. Attaching logs from my testing machine..
> 
> I see this behavior on ICH7R with i3000 chipset too:
> 00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
> Family) SATA RAID Controller [8086:27c3] (rev 01)

Can you please apply the attached patch and report the resulting boot
log?  Thanks.

-- 
tejun

--------------070600030709090000000603
Content-Type: text/x-patch;
 name="ahci-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci-debug.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 336eb1e..54c9c6d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1667,6 +1667,7 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	DPRINTK("ENTER\n");
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
+	ata_link_printk(link, KERN_INFO, "XXX softresetting link, kicking engine\n");
 	rc = ahci_kick_engine(ap, 1);
 	if (rc && rc != -EOPNOTSUPP)
 		ata_link_printk(link, KERN_WARNING,
@@ -1680,6 +1681,7 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (time_after(now, deadline))
 		msecs = jiffies_to_msecs(deadline - now);
 
+	ata_link_printk(link, KERN_INFO, "XXX setting SRST\n");
 	tf.ctl |= ATA_SRST;
 	if (ahci_exec_polled_cmd(ap, pmp, &tf, 0,
 				 AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY, msecs)) {
@@ -1692,10 +1694,12 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	msleep(1);
 
 	/* issue the second D2H Register FIS */
+	ata_link_printk(link, KERN_INFO, "XXX clearing SRST\n");
 	tf.ctl &= ~ATA_SRST;
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
 	/* wait for link to become ready */
+	ata_link_printk(link, KERN_INFO, "XXX waiting for DRDY\n");
 	rc = ata_wait_after_reset(link, deadline, check_ready);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
@@ -1704,6 +1708,7 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	}
 	*class = ahci_dev_classify(ap);
 
+	ata_link_printk(link, KERN_INFO, "XXX rc=%d, class=%u\n", rc, *class);
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
@@ -1791,6 +1796,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
+	ata_link_printk(link, KERN_INFO, "XXX hardresetting link, stopping engine\n");
 	ahci_stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
@@ -1798,14 +1804,17 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ata_link_printk(link, KERN_INFO, "XXX flipping SControl\n");
 	rc = sata_link_hardreset(link, timing, deadline, &online,
 				 ahci_check_ready);
 
+	ata_link_printk(link, KERN_INFO, "XXX starting engine\n");
 	ahci_start_engine(ap);
 
 	if (online)
 		*class = ahci_dev_classify(ap);
 
+	ata_link_printk(link, KERN_INFO, "XXX rc=%d, class=%u\n", rc, *class);
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
@@ -2035,6 +2044,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
+		ata_port_printk(ap, KERN_INFO, "XXX irq_stat=%x CONN|PHY\n", irq_stat);
 		ata_ehi_hotplugged(host_ehi);
 		ata_ehi_push_desc(host_ehi, "%s",
 			irq_stat & PORT_IRQ_CONNECT ?
@@ -2217,6 +2227,7 @@ static void ahci_freeze(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 
+	ata_port_printk(ap, KERN_INFO, "XXX port freeze\n");
 	/* turn IRQ off */
 	writel(0, port_mmio + PORT_IRQ_MASK);
 }
@@ -2229,12 +2240,14 @@ static void ahci_thaw(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 
 	/* clear IRQ */
+	ata_port_printk(ap, KERN_INFO, "XXX clearing IRQs for thawing\n");
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
 	writel(tmp, port_mmio + PORT_IRQ_STAT);
 	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);
 
 	/* turn IRQ back on */
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+	ata_port_printk(ap, KERN_INFO, "XXX port thawed\n");
 }
 
 static void ahci_error_handler(struct ata_port *ap)

--------------070600030709090000000603--
