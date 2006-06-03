From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/6] Implement the AHCI suspend/resume
Date: Sat, 3 Jun 2006 22:35:31 +0900
Message-ID: <20060603133531.GD25958@htj.dyndns.org>
References: <1149234379.13451.59.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:5935 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750766AbWFCNfl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jun 2006 09:35:41 -0400
Received: by py-out-1112.google.com with SMTP id b36so928775pyb
        for <linux-ide@vger.kernel.org>; Sat, 03 Jun 2006 06:35:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1149234379.13451.59.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, Jun 02, 2006 at 03:46:19PM +0800, zhao, forrest wrote:
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -188,6 +188,7 @@ struct ahci_host_priv {
>  	unsigned long		flags;
>  	u32			cap;	/* cache of HOST_CAP register */
>  	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
> +	u32			dev_map; /* connected devices */

I'm having difficult time understanding the usage of dev_map.  Why is
it needed?

> +static int ahci_port_resume(struct ata_port *ap)
> +{
> +	void __iomem *mmio = ap->host_set->mmio_base;
> +	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
> +	struct ahci_host_priv *hpriv = ap->host_set->private_data;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	int rc;
> +	u32 tmp;
> +
> +	/*
> +	 * Enable FIS reception
> +	 */
> +	ahci_start_fis_rx(port_mmio, pp, hpriv);
> +
> +	rc = ahci_port_spinup(port_mmio, hpriv->cap);
> +	if (rc)
> +		ata_port_printk(ap, KERN_WARNING, "Could not spinup device"
> +				" (%d)\n", rc);
> +
> +	/*
> +	 * Clear error status
> +	 */
> +	tmp = readl(port_mmio + PORT_SCR_ERR);
> +	writel(tmp, port_mmio + PORT_SCR_ERR);
> +	/*
> +	 * Clear interrupt status
> +	 */
> +	tmp = readl(mmio + HOST_CTL);
> +	if (!(tmp & HOST_IRQ_EN)) {
> +		u32 irq_stat;
> +
> +		/* ack any pending irq events for this port */
> +		irq_stat = readl(port_mmio + PORT_IRQ_STAT);
> +		if (irq_stat)
> +			writel(irq_stat, port_mmio + PORT_IRQ_STAT);
> +
> +		/* set irq mask (enables interrupts) */
> +		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
> +
> +		if ((hpriv->dev_map >> (ap->port_no + 1)) == 0) {
> +			/*
> +			 * Enable interrupts if this was the last port
> +			 */
> +			ata_port_printk(ap, KERN_INFO, "Enable interrupts\n");
> +
> +			irq_stat = readl(mmio + HOST_IRQ_STAT);
> +			if (irq_stat)
> +				writel(irq_stat, mmio + HOST_IRQ_STAT);
> +
> +			tmp |= HOST_IRQ_EN;
> +			writel(tmp, mmio + HOST_CTL);
> +			(void) readl(mmio + HOST_CTL);
> +		}

Can't above enable-IRQ block be moved into ahci_pci_device_resume()
after resuming all ports?

-- 
tejun
