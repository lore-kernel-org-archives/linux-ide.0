From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Thu, 25 Jun 2009 15:06:37 +0200
Message-ID: <19011.30301.825635.763918@pilspetsen.it.uu.se>
References: <20080113234320.GA6225@roeckx.be>
	<18315.7567.747367.84127@harpo.it.uu.se>
	<20080115000953.GA2799@roeckx.be>
	<18316.31910.973794.732242@harpo.it.uu.se>
	<20080115173557.GA3033@roeckx.be>
	<18317.54768.524651.128063@harpo.it.uu.se>
	<20090420182503.GA10768@roeckx.be>
	<18925.32310.909665.474085@pilspetsen.it.uu.se>
	<20090421162507.GA16798@roeckx.be>
	<20090621221002.GA11170@roeckx.be>
	<19008.49605.448797.606574@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:37104 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZFYNGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jun 2009 09:06:40 -0400
In-Reply-To: <19008.49605.448797.606574@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Kurt Roeckx <kurt@roeckx.be>, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > Kurt Roeckx writes:
 >  > On Tue, Apr 21, 2009 at 06:25:07PM +0200, Kurt Roeckx wrote:
 >  > > On Tue, Apr 21, 2009 at 10:05:10AM +0200, Mikael Pettersson wrote:
 >  > > > Kurt Roeckx writes:
 >  > > >  > On Wed, Jan 16, 2008 at 11:01:20AM +0100, Mikael Pettersson wrote:
 >  > > >  > > Kurt Roeckx writes:
 >  > > >  > >  > On Tue, Jan 15, 2008 at 10:28:06AM +0100, Mikael Pettersson wrote:
 >  > > >  > >  > >  > 00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
 >  > > >  > >  > > ...
 >  > > >  > >  > >  > 00:08.0 0104: 105a:3376 (rev 02)
 >  > > >  > >  > > 
 >  > > >  > >  > > Let me guess, this is a Promise chip included on the mainboard
 >  > > >  > >  > > as a RAID controller, and not an add-on PCI card?
 >  > > >  > >  > 
 >  > > >  > >  > Yes, it's a K8V motherboard which has that onboard.
 >  > > >  > >  > 
 >  > > >  > >  > > If it's a mainboard chip, please enter the BIOS and see if it
 >  > > >  > >  > > can be configured for non-RAID mode. If it can, please reconfigure
 >  > > >  > >  > > it and boot Linux. Does it still claim to be a 20376 or is it
 >  > > >  > >  > > now a 20378?
 >  > > >  > >  > 
 >  > > >  > >  > I can't find an option to turn that off in the BIOS.  If it did, I'd
 >  > > >  > >  > probably have turned it off already.  I've also opened the case and it
 >  > > >  > >  > says PDC20376 on the chip.
 >  > > >  > > 
 >  > > >  > > Ok. I haven't yet found any information about the 20376 which
 >  > > >  > > could explain why the 20376 fails while the 20378 works.
 >  > > >  > > For now, you can disable hotplugging in the driver by applying
 >  > > >  > > the patch below. This should at least bring back some stability
 >  > > >  > > to your system.
 >  > > >  > > 
 >  > > >  > > Longer-term I guess I'll have to invent a blacklist mechanism
 >  > > >  > > to automatically prevent 20376 chips from enabling hotplugging.
 >  > > >  > > That is, unless someone can show me a system where a 20376
 >  > > >  > > actually does work with hotplugging, in which case I'd need a
 >  > > >  > > module parameter (yuck) or some form of dynamic detection of
 >  > > >  > > this condition.
 >  > > >  > 
 >  > > >  > Hi,
 >  > > >  > 
 >  > > >  > I'm still having this problem with a 2.6.29 kernel.  I want to
 >  > > >  > avoid always having to patch my kernel, so I would like to see
 >  > > >  > some solution to this.  What do you think that the best way
 >  > > >  > forward is?
 >  > > > 
 >  > > > Since the previous discussion I've seen the 20378s in two
 >  > > > identical mainboards of a particular model also throw spurious
 >  > > > hotplug events. It would be possible to blacklist hotplugging
 >  > > > on all SATA1 models, but that would also affect SATA1-based
 >  > > > PCI cards like the SATA150 TX2/TX4 which don't appear to
 >  > > > have this problem.
 >  > > > 
 >  > > > Can you post the lspci -vvn output for your 20376?
 >  > > 
 >  > > 00:08.0 0104: 105a:3376 (rev 02)
 >  > >         Subsystem: 1043:809e
 >  > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 >  > >         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 >  > >         Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 256 bytes
 >  > >         Interrupt: pin A routed to IRQ 18
 >  > >         Region 0: I/O ports at ec00 [size=64]
 >  > >         Region 1: I/O ports at dc00 [size=16]
 >  > >         Region 2: I/O ports at cc00 [size=128]
 >  > >         Region 3: Memory at fdf00000 (32-bit, non-prefetchable) [size=4K]
 >  > >         Region 4: Memory at fdb00000 (32-bit, non-prefetchable) [size=128K]
 >  > >         Capabilities: [60] Power Management version 2
 >  > >                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 >  > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 >  > >         Kernel driver in use: sata_promise
 >  > >         Kernel modules: sata_promise
 >  > > 
 >  > 
 >  > Any news about this?
 > 
 > Sorry, I dropped the ball on that one. (Too many projects requiring
 > my attention.) I think the safest solution is to just disable hotplug
 > interrupts on SATA1 chips. I'll give that a try in 2-3 days (busy with
 > other stuff).

Some 1st generation Promise SATA chips generate spurious hotplug events
which can disrupt normal operation. This has been observed on 20376 and
20378 chips. This patch thus disables hotplug support on 1st gen chips
while leaving it enabled for 2nd gen chips.

Tested on a 2nd gen SATA300 PCI card and a 1st gen 20378 mainboard chip.

Kurt, does this work for your 20376?

/Mikael

--- linux-2.6.30/drivers/ata/sata_promise.c.~1~	2009-06-10 12:00:44.000000000 +0200
+++ linux-2.6.30/drivers/ata/sata_promise.c	2009-06-25 11:29:50.000000000 +0200
@@ -195,9 +195,12 @@ static struct ata_port_operations pdc_sa
 	.hardreset		= pdc_sata_hardreset,
 };
 
-/* First-generation chips need a more restrictive ->check_atapi_dma op */
+/* First-generation chips need a more restrictive ->check_atapi_dma op,
+   and ->freeze/thaw that ignore the hotplug controls. */
 static struct ata_port_operations pdc_old_sata_ops = {
 	.inherits		= &pdc_sata_ops,
+	.freeze			= pdc_freeze,
+	.thaw			= pdc_thaw,
 	.check_atapi_dma	= pdc_old_sata_check_atapi_dma,
 };
 
@@ -626,11 +629,6 @@ static unsigned int pdc_sata_ata_port_to
 	return pdc_port_no_to_ata_no(i, pdc_is_sataii_tx4(ap->flags));
 }
 
-static unsigned int pdc_sata_hotplug_offset(const struct ata_port *ap)
-{
-	return (ap->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR : PDC_SATA_PLUG_CSR;
-}
-
 static void pdc_freeze(struct ata_port *ap)
 {
 	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
@@ -647,7 +645,7 @@ static void pdc_sata_freeze(struct ata_p
 {
 	struct ata_host *host = ap->host;
 	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
-	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
+	unsigned int hotplug_offset = PDC2_SATA_PLUG_CSR;
 	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
 	u32 hotplug_status;
 
@@ -685,7 +683,7 @@ static void pdc_sata_thaw(struct ata_por
 {
 	struct ata_host *host = ap->host;
 	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
-	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
+	unsigned int hotplug_offset = PDC2_SATA_PLUG_CSR;
 	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
 	u32 hotplug_status;
 
@@ -832,14 +830,14 @@ static irqreturn_t pdc_interrupt(int irq
 	spin_lock(&host->lock);
 
 	/* read and clear hotplug flags for all ports */
-	if (host->ports[0]->flags & PDC_FLAG_GEN_II)
+	if (host->ports[0]->flags & PDC_FLAG_GEN_II) {
 		hotplug_offset = PDC2_SATA_PLUG_CSR;
-	else
-		hotplug_offset = PDC_SATA_PLUG_CSR;
-	hotplug_status = readl(host_mmio + hotplug_offset);
-	if (hotplug_status & 0xff)
-		writel(hotplug_status | 0xff, host_mmio + hotplug_offset);
-	hotplug_status &= 0xff;	/* clear uninteresting bits */
+		hotplug_status = readl(host_mmio + hotplug_offset);
+		if (hotplug_status & 0xff)
+			writel(hotplug_status | 0xff, host_mmio + hotplug_offset);
+		hotplug_status &= 0xff;	/* clear uninteresting bits */
+	} else
+		hotplug_status = 0;
 
 	/* reading should also clear interrupts */
 	mask = readl(host_mmio + PDC_INT_SEQMASK);
@@ -1034,9 +1032,11 @@ static void pdc_host_init(struct ata_hos
 	tmp = readl(host_mmio + hotplug_offset);
 	writel(tmp | 0xff, host_mmio + hotplug_offset);
 
-	/* unmask plug/unplug ints */
 	tmp = readl(host_mmio + hotplug_offset);
-	writel(tmp & ~0xff0000, host_mmio + hotplug_offset);
+	if (is_gen2)	/* unmask plug/unplug ints */
+		writel(tmp & ~0xff0000, host_mmio + hotplug_offset);
+	else		/* mask plug/unplug ints */
+		writel(tmp | 0xff0000, host_mmio + hotplug_offset);
 
 	/* don't initialise TBG or SLEW on 2nd generation chips */
 	if (is_gen2)
