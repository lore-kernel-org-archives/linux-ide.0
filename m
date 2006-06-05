From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Mon, 05 Jun 2006 13:05:49 +0800
Message-ID: <1149483949.29552.19.camel@forrest26.sh.intel.com>
References: <1149234379.13451.59.camel@forrest26.sh.intel.com>
	 <20060603133531.GD25958@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55077 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932414AbWFEFUO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jun 2006 01:20:14 -0400
In-Reply-To: <20060603133531.GD25958@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Sat, 2006-06-03 at 22:35 +0900, Tejun Heo wrote:
> > +	 */
> > +	tmp = readl(mmio + HOST_CTL);
> > +	if (!(tmp & HOST_IRQ_EN)) {
> > +		u32 irq_stat;
> > +
> > +		/* ack any pending irq events for this port */
> > +		irq_stat = readl(port_mmio + PORT_IRQ_STAT);
> > +		if (irq_stat)
> > +			writel(irq_stat, port_mmio + PORT_IRQ_STAT);
> > +
> > +		/* set irq mask (enables interrupts) */
> > +		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
> > +
> > +		if ((hpriv->dev_map >> (ap->port_no + 1)) == 0) {
> > +			/*
> > +			 * Enable interrupts if this was the last port
> > +			 */
> > +			ata_port_printk(ap, KERN_INFO, "Enable interrupts\n");
> > +
> > +			irq_stat = readl(mmio + HOST_IRQ_STAT);
> > +			if (irq_stat)
> > +				writel(irq_stat, mmio + HOST_IRQ_STAT);
> > +
> > +			tmp |= HOST_IRQ_EN;
> > +			writel(tmp, mmio + HOST_CTL);
> > +			(void) readl(mmio + HOST_CTL);
> > +		}
> 
> Can't above enable-IRQ block be moved into ahci_pci_device_resume()
> after resuming all ports?

Tejun,

I think you're right, the "dev_map" is an ugly hack. I'll move above
enable-IRQ block to ahci_pci_device_resume(), thus removing "dev_map" in
the next round of updated patches.

Thanks,
Forrest
