From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug quirk
Date: Sun, 23 Mar 2008 12:21:39 +0900
Message-ID: <47E5CCC3.3000301@gmail.com>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:53906 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbYCWDVt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Mar 2008 23:21:49 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2351792wff.4
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 20:21:49 -0700 (PDT)
In-Reply-To: <200803221421.m2MEL1oY021558@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Mikael.

Mikael Pettersson wrote:
> There is an undocumented hardware quirk in Promise's SATA controllers,
> where a SATA COMRESET causes the controller to signal hotplug events.
> These unexpected interrupts confuse libata's error handler and cause
> a sequence of failed reset attempts until EH finally gives up.

Actually, this is common to many SATA controllers.  Lots of them raise
PHY event or hotplug interrupt during COMRESET and they all plug PHY
events from ->freeze.

> Although SATA hotplug status and control is per-port, it resides in
> a single register shared by all ports. Therefore accesses to it must
> be serialised: the controller's host->lock is used for that. The
> interrupt handler is also adjusted so its hotplug register accesses
> are inside the region protected by host->lock.

Hmmm... This is supposed to be handled by setting ap->lock appropriately
and ap->lock already is initialized to &host->lock, so sticking with
ap->lock is the right thing to do.

> +static void pdc_sata_disable_hotplug(const struct ata_port *ap)
> +{
> +	struct ata_host *host = ap->host;
> +	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
> +	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
> +	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
> +	u32 hotplug_status;
> +
> +	spin_lock(&host->lock);
> +
> +	hotplug_status = readl(host_mmio + hotplug_offset);
> +	hotplug_status |= 0x11 << (ata_no + 16);
> +	writel(hotplug_status, host_mmio + hotplug_offset);
> +	readl(host_mmio + hotplug_offset); /* flush */
> +
> +	spin_unlock(&host->lock);
> +}
> +
> +static void pdc_sata_enable_hotplug(const struct ata_port *ap)
> +{
> +	struct ata_host *host = ap->host;
> +	void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
> +	unsigned int hotplug_offset = pdc_sata_hotplug_offset(ap);
> +	unsigned int ata_no = pdc_sata_ata_port_to_ata_no(ap);
> +	u32 hotplug_status;
> +
> +	spin_lock(&host->lock);
> +
> +	hotplug_status = readl(host_mmio + hotplug_offset);
> +	hotplug_status |= 0x11 << ata_no;
> +	hotplug_status &= ~(0x11 << (ata_no + 16));
> +	writel(hotplug_status, host_mmio + hotplug_offset);
> +	readl(host_mmio + hotplug_offset); /* flush */
> +
> +	spin_unlock(&host->lock);
> +}
> +
>  static void pdc_freeze(struct ata_port *ap)
>  {
>  	void __iomem *mmio = ap->ioaddr.cmd_addr;
> @@ -643,6 +717,12 @@ static void pdc_freeze(struct ata_port *
>  	readl(mmio + PDC_CTLSTAT); /* flush */
>  }
>  
> +static void pdc_sata_freeze(struct ata_port *ap)
> +{
> +	pdc_sata_disable_hotplug(ap);
> +	pdc_freeze(ap);
> +}

->freeze() is called with ap->lock held, trying to lock host->lock
inside pdc_sata_enable/disable_hotplug() will result in deadlock.  Have
you tested w/ SMP configuration or spinlock debugging turned on?

-- 
tejun
