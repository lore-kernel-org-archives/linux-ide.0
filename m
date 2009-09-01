From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Tue, 1 Sep 2009 20:22:01 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:50051 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbZIAMWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Sep 2009 08:22:15 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9B8368.1080807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun, 


> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> 
> 
> Why does fbs_need_dec need to be in ahci_port_priv?  Can't it be a
> local variable of error_intr()?

Yes, it should be replaced by one local variable.


> > +static void ahci_fbs_dec_intr(struct ata_port *ap)
> > +{
> > +	struct ahci_port_priv *pp = ap->private_data;
> > +	DPRINTK("ENTER\n");
> > +
> > +	if (pp->fbs_enabled) {
> 
> Just do BUG_ON(!pp->fbs_enabled);

OK.

 
> > +		void __iomem *port_mmio = ahci_port_base(ap);
> > +		u32 fbs = readl(port_mmio + PORT_FBS);
> > +		int retries = 3;
> > +
> > +		/* time to wait for DEC is not specified by AHCI spec,
> > +		 * add a retry loop for safety */
> > +		do {
> > +			writel(fbs | PORT_FBS_DEC, port_mmio + 
> PORT_FBS);
> > +			fbs = readl(port_mmio + PORT_FBS);
> > +			retries--;
> > +		} while ((fbs & PORT_FBS_DEC) && retries);
> 
> Hmmm... shouldn't it be more like the following?
> 
> 	writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
> 	fbs = readl(port_mmio + PORT_FBS);
> 	while ((fbs & PORT_FBS_DEC) && retries--) {
> 		udelay(1);
> 		fbs = readl(port_mmio + PORT_FBS);
> 	}

OK.


> > @@ -1984,10 +2042,22 @@ static void ahci_error_intr(struct 
> ata_port *ap, u32 irq_stat)
> >  	struct ata_eh_info *active_ehi;
> >  	u32 serror;
> >  
> > -	/* determine active link */
> > -	ata_for_each_link(link, ap, EDGE)
> > -		if (ata_link_active(link))
> > -			break;
> > +	/* determine active link with error */
> > +	if (pp->fbs_enabled) {
> > +		void __iomem *port_mmio = ahci_port_base(ap);
> > +		u32 fbs = readl(port_mmio + PORT_FBS);
> > +
> > +		ata_for_each_link(link, ap, EDGE)
> > +			if (ata_link_active(link) && (fbs & 
> PORT_FBS_SDE) &&
> > +			    (link->pmp == (fbs >> 
> PORT_FBS_DWE_OFFSET))) {
> > +				pp->fbs_need_dec = true;
> > +				break;
> > +			}
> 
> You can do
> 
> 	pmp = fbs >> PORT_FBS_DWE_OFFSET;
> 	if (pmp < ap->nr_pmp_links && 
> ata_link_online(&ap->pmp_link[pmp])) {
> 		link = &ap->pmp_link[pmp];
> 		pp->fbs_need_dec = true;
> 	}

PORT_FBS_SDE also need check, because(ahci v1.2  3.3.16):
Device With Error (DWE): Set by hardware to the value of the
Port Multiplier port number of the device that experienced a fatal
error condition. This field is only valid when PxFBS.SDE = '1'.

So I'll update the code into:
	u32 fbs = readl(port_mmio + PORT_FBS);
	int pmp = fbs >> PORT_FBS_DWE_OFFSET;

	if ((fbs & PORT_FBS_SDE) && (pmp < ap->nr_pmp_links) &&
	    ata_link_online(&ap->pmp_link[pmp])) {
		link = &ap->pmp_link[pmp];
		fbs_need_dec = true;
	}

 
> >  	if (irq_stat & PORT_IRQ_IF_ERR) {
> > -		host_ehi->err_mask |= AC_ERR_ATA_BUS;
> > -		host_ehi->action |= ATA_EH_RESET;
> > +		if (pp->fbs_need_dec)
> > +			active_ehi->err_mask |= AC_ERR_DEV;
> > +		else {
> > +			host_ehi->err_mask |= AC_ERR_ATA_BUS;
> > +			host_ehi->action |= ATA_EH_RESET;
> > +		}
> > +
> 
> Are you sure IF_ERR is device specific and doesn't require host link
> reset?

Because I referred to the AHCI spec v1.2  9.3.6:
An interface fatal error may be localized to a particular device or may
be fatal to the entire port.....If the error is fatal to the entire
port, then
PxFBS.SDE shall be cleared to '0' by the hardware. Software should
follow either the device specific or non-device specific error procedure
depending on whether PxFBS.SDE is set to '1'.


> > @@ -2061,7 +2136,12 @@ static void ahci_error_intr(struct 
> ata_port *ap, u32 irq_stat)
> >  	if (irq_stat & PORT_IRQ_FREEZE)
> >  		ata_port_freeze(ap);
> >  	else
> > -		ata_port_abort(ap);
> > +		if (pp->fbs_enabled && pp->fbs_need_dec &&
> 
> 	else if (pp->fbs_need_dec) {
> 
> should be enough, right?

Yes, I'll update that.


> > +	} else {
> > +		dev_printk(KERN_ERR, ap->host->dev,
> > +			   "FBS is not supported or already enabled\n");
> > +		return -EINVAL;
> 
> The above message will be printed on every !FBS ahcis, right?  It
> would be better to do the following at the top of the function.
> 
> 	if (!pp->fbs_supported)
> 		return;
> 	WARN_ON(pp->fbs_enabled);
> 
> and drop the if/else.

OK, updated as below, and returns "void" instead of "int":
static void ahci_enable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported)
		return;

	WARN_ON(pp->fbs_enabled);

	rc = ahci_stop_engine(ap);
	if (rc)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN) {
		dev_printk(KERN_INFO, ap->host->dev, "FBS is
enabled.\n");
		pp->fbs_enabled = true;
		pp->fbs_last_dev = -1; /* initialization */
	} else
		dev_printk(KERN_ERR, ap->host->dev, "Failed to enable
FBS\n");

	ahci_start_engine(ap);
}


> > +static int ahci_disable_fbs(struct ata_port *ap)
> > +{
> > +	struct ahci_port_priv *pp = ap->private_data;
> > +
> > +	if (pp->fbs_enabled) {
> > +		void __iomem *port_mmio = ahci_port_base(ap);
> > +		u32 fbs;
> > +		int rc = ahci_stop_engine(ap);
> > +		if (rc)
> > +			return rc;
> > +
> > +		fbs = readl(port_mmio + PORT_FBS);
> > +		writel(fbs & ~PORT_FBS_EN, port_mmio + PORT_FBS);
> > +		fbs = readl(port_mmio + PORT_FBS);
> > +		if (fbs & PORT_FBS_EN) {
> > +			dev_printk(KERN_ERR, ap->host->dev,
> > +				   "Failed to disable FBS\n");
> > +			ahci_start_engine(ap);
> > +			return -EIO;
> > +		} else {
> > +			dev_printk(KERN_INFO, ap->host->dev,
> > +				   "FBS is disabled.\n");
> > +			pp->fbs_enabled = false;
> > +		}
> > +
> > +		ahci_start_engine(ap);
> > +	} else if (sata_pmp_attached(ap)) {
> > +		dev_printk(KERN_ERR, ap->host->dev,
> > +			   "FBS is not supported or already 
> disabled\n");
> > +		return -EINVAL;
> > +	}
> 
> Ditto.  Just drop sanity checks.  Upper layer should take 
> care of them.
> No need to check that this deep in the stack.

static void ahci_disable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported)
		return;

	WARN_ON(!pp->fbs_enabled);

	rc = ahci_stop_engine(ap);
	if (rc)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	writel(fbs & ~PORT_FBS_EN, port_mmio + PORT_FBS);
	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN)
		dev_printk(KERN_ERR, ap->host->dev, "Failed to disable
FBS\n");
	else {
		dev_printk(KERN_INFO, ap->host->dev, "FBS is
disabled.\n");
		pp->fbs_enabled = false;
	}

	ahci_start_engine(ap);
}


> >  static int ahci_port_start(struct ata_port *ap)
> >  {
> > +	struct ahci_host_priv *hpriv = ap->host->private_data;
> >  	struct device *dev = ap->host->dev;
> >  	struct ahci_port_priv *pp;
> >  	void *mem;
> >  	dma_addr_t mem_dma;
> > +	size_t dma_sz, rx_fis_sz;
> >  
> >  	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
> >  	if (!pp)
> >  		return -ENOMEM;
> >  
> > -	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
> > -				  GFP_KERNEL);
> > +	/* check FBS capability */
> > +	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
> > +		void __iomem *port_mmio = ahci_port_base(ap);
> > +		u32 cmd = readl(port_mmio + PORT_CMD);
> > +		if (cmd & PORT_CMD_FBSCP)
> > +			pp->fbs_supported = true;
> 
> Maybe whine a bit if CAP indicates FBS but PORT_CMD doesn't?

Sure, updated as below:
	if (cmd & PORT_CMD_FBSCP)
		pp->fbs_supported = true;
	else
		WARN_ON(1);


> Other than the above, looks great to me.

OK, thanks for your nice suggestions, I'll have to submit v3 later...


Best Regards,
Shane

