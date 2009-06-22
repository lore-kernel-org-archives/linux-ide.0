From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 18:56:21 -0700 (PDT)
Message-ID: <20090621.185621.31766784.davem@davemloft.net>
References: <200906202352.33894.elendil@planet.nl>
	<20090620.171945.140676687.davem@davemloft.net>
	<200906211446.38598.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906211446.38598.elendil@planet.nl>
Sender: sparclinux-owner@vger.kernel.org
To: elendil@planet.nl
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Sun, 21 Jun 2009 14:46:37 +0200

> I tried the following additional patch, but unfortunately that did not help:
> --- a/drivers/ide/cmd64x.c
> +++ b/drivers/ide/cmd64x.c
> @@ -426,6 +426,7 @@ static const struct ide_port_info cmd64x_chipsets[]
>  		.port_ops	= &cmd64x_port_ops,
>  		.dma_ops	= &cmd648_dma_ops,
>  		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
> +		.irq_flags	= IRQF_SHARED,
>  		.pio_mask	= ATA_PIO5,
>  		.mwdma_mask	= ATA_MWDMA2,
>  		.udma_mask	= ATA_UDMA2,
> 
> I got the idea for that from 255115fb and had hoped it would compensate
> for this change from Bart's commit:

That won't help.  All PCI IDE interfaces unconditionally set the
irq_flags to IRQF_SHARED.  This occurs in drivers/ide/setup-pci.c
via ide_pci_init_one(), which calls ide_pci_init_two(), which goes:

	host->irq_flags = IRQF_SHARED;

The key to this bug seems to be the setting of host->cur_port when the
interrupts arrive.  That's really the only major case where the IDE
driver interrupt handler elides at least reading the status register
to clear the interrupt.

That's why clearing the IDE_HFLAG_SERIALIZE flag makes the initial
bulk of unclearable interrupts go away.

I suspect that whatever is causing trouble due to IDE_HFLAG_SERIALIZE
is also, down the road, causing the hdd problem you still see.

Can you apply this debugging patch and print out the output?

Thanks!

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 1059f80..8992fda 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -797,6 +797,25 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 	int plug_device = 0;
 	struct request *uninitialized_var(rq_in_flight);
 
+#if 1
+	{
+		static int times = 0;
+		
+		if (++times <= 32)
+			goto no_log;
+
+		printk(KERN_INFO "IDE-DEBUG: host->host_flags[0x%lx] "
+		       "hwif(%p) host->cur_port(%p) "
+		       "hwif->port_ops(%pS) hwif->handler(%pS) "
+		       "hwif->polling(%d)\n",
+		       host->host_flags, hwif, host->cur_port,
+		       hwif->port_ops, hwif->handler, (int) hwif->polling);
+
+	no_log:
+		;
+	}
+#endif
+
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		if (hwif != host->cur_port)
 			goto out_early;
