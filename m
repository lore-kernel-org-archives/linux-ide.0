From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Tue, 1 Sep 2009 21:08:39 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:55026 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbZIANIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Sep 2009 09:08:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9D1387.6040709@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> 
> >>> +	/* check FBS capability */
> >>> +	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
> >>> +		void __iomem *port_mmio = ahci_port_base(ap);
> >>> +		u32 cmd = readl(port_mmio + PORT_CMD);
> >>> +		if (cmd & PORT_CMD_FBSCP)
> >>> +			pp->fbs_supported = true;
> >> Maybe whine a bit if CAP indicates FBS but PORT_CMD doesn't?
> > 
> > Sure, updated as below:
> > 	if (cmd & PORT_CMD_FBSCP)
> > 		pp->fbs_supported = true;
> > 	else
> > 		WARN_ON(1);
> 
> WARN_ON() would be a tad bit too scary.  Given that on certain
> hardwares it would always trigger.  A dev_printk() would be better.

Well..., then:
	if (cmd & PORT_CMD_FBSCP)
		pp->fbs_supported = true;
	else
		dev_printk(KERN_WARNING, ap->host->dev,
			   "The port is not capable of FBS\n");


Quoting myself:
> static void ahci_disable_fbs(struct ata_port *ap)
> {
> 	struct ahci_port_priv *pp = ap->private_data;
> 	void __iomem *port_mmio = ahci_port_base(ap);
> 	u32 fbs;
> 	int rc;
> 
> 	if (!pp->fbs_supported)
> 		return;
> 
> 	WARN_ON(!pp->fbs_enabled);
> 
> 	rc = ahci_stop_engine(ap);

I find that ahci_pmp_detach() will be called for each SATA port
during the initialization, right after print:
> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs...

so will ahci_disable_fbs() be called, which leads to the trigger
of WARN_ON().

I'll also add the condition sata_pmp_attached() as below:
static void ahci_disable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported || !sata_pmp_attached(ap))
		return;

	WARN_ON(!pp->fbs_enabled);

	rc = ahci_stop_engine(ap);



Thanks,
Shane

