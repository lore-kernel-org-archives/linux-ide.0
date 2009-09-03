From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Thu, 3 Sep 2009 12:53:47 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC9C7F@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:57601 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZICEx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Sep 2009 00:53:58 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun, 

> -----Original Message-----
> From: Huang, Shane 
> 
> > > +static void ahci_fbs_dec_intr(struct ata_port *ap)
> > > +{
> > > +	struct ahci_port_priv *pp = ap->private_data;
> > > +	DPRINTK("ENTER\n");
> > > +
> > > +	if (pp->fbs_enabled) {
> > 
> > Just do BUG_ON(!pp->fbs_enabled);
> 
> OK.
> 
>  
> > > +		void __iomem *port_mmio = ahci_port_base(ap);
> > > +		u32 fbs = readl(port_mmio + PORT_FBS);
> > > +		int retries = 3;
> > > +
> > > +		/* time to wait for DEC is not specified by AHCI spec,
> > > +		 * add a retry loop for safety */
> > > +		do {
> > > +			writel(fbs | PORT_FBS_DEC, port_mmio + 
> > PORT_FBS);
> > > +			fbs = readl(port_mmio + PORT_FBS);
> > > +			retries--;
> > > +		} while ((fbs & PORT_FBS_DEC) && retries);


At the 2nd thought, if (!pp->fbs_enabled) appears unfortunately
(although it should not), replacement of if (pp->fbs_enabled) with
BUG_ON() will lead to the execution of the followed DEC, which
might lead to indeterminate result, because of AHCI v1.2 3.3.16:

Device Error Clear (DEC): ....... Software shall only set this bit to
'1' if
PxFBS.EN is set to '1' and PxFBS.SDE is set to '1'.

So I would suggest to keep my original implementation in v2, or put
BUG_ON to the else case, if you insist, to replace the original
dev_printk(KERN_ERR).



Thanks
Shane

