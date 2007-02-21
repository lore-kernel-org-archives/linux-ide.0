From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_vsc: clean up vsc_sata_interrupt
Date: Wed, 21 Feb 2007 15:28:47 +0900
Message-ID: <20070221062847.GU1625@htj.dyndns.org>
References: <20070221012109.31723.65182.stgit@dwillia2-linux.ch.intel.com> <20070221012132.31723.47307.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:30921 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbXBUHAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:00:09 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2155400nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:00:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070221012132.31723.47307.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Hello,

On Tue, Feb 20, 2007 at 06:21:32PM -0700, Dan Williams wrote:
> @@ -149,9 +145,9 @@ static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
>  		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
>  	mask = readb(mask_addr);
>  	if (ctl & ATA_NIEN)
> -		mask |= 0x80;
> +		mask = 0xff;
>  	else
> -		mask &= 0x7F;
> +		mask = 0x0;
>  	writeb(mask, mask_addr);

Wouldn't it be better to listen for SATA error interrupt
(e.g. hotplug) even during polling commands?

> @@ -290,59 +286,35 @@ static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance)
>  	struct ata_host *host = dev_instance;
>  	unsigned int i;
>  	unsigned int handled = 0;
> -	u32 int_status;
> +	u32 status;
>  
> -	spin_lock(&host->lock);
> +	status = readl(host->iomap[VSC_MMIO_BAR] + VSC_SATA_INT_STAT_OFFSET);
>  
> -	int_status = readl(host->iomap[VSC_MMIO_BAR] +
> -			   VSC_SATA_INT_STAT_OFFSET);
> -
> -	for (i = 0; i < host->n_ports; i++) {
> -		if (int_status & ((u32) 0xFF << (8 * i))) {
> -			struct ata_port *ap;
> +	if (status == 0xffffffff) {
> +		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
> +			"PCI fault or device removal?\n");
> +		goto out;
> +	} else if (!status)
> +		goto out;

I think unlikely() here will be helpful.  e.g.

	if (unlikely(status == 0 || status == 0xffffffff)) {
		/* blah blah */
		goto out;
	}

Thanks.

-- 
tejun
