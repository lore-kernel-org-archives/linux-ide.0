From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Wed, 2 Sep 2009 14:42:27 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC99B7@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com> <4A9DD153.5050106@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC988D@sshaexmb1.amd.com> <4A9DDB28.7070709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:11497 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZIBGmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2009 02:42:38 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9DDB28.7070709@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Tejun,
 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> > 
> > 
> > static void ahci_disable_fbs(struct ata_port *ap)
> > {
> > 	struct ahci_port_priv *pp = ap->private_data;
> > 	void __iomem *port_mmio = ahci_port_base(ap);
> > 	u32 fbs;
> > 	int rc;
> > 
> > 	if (!pp->fbs_supported)
> > 		return;
> > 
> > 	fbs = readl(port_mmio + PORT_FBS);
> > 	if ((fbs & PORT_FBS_EN) == 0)
> > 		return;
> 
> This can leave pp->fbs_enabled out of sync, right?  Just don't check
> and set the bit anyway.
> Ditto.

Yes, it can leave pp->fbs_enabled out of sync, but just removing the
check and setting the bit anyway will still lead to the print of this
message for each SATA port:
ahci 0000:00:11.0: FBS is disabled.

So I would suggest to keep the check and also add the sync of
pp->fbs_enabled, which can also save the restart of DMA engine:

static void ahci_disable_fbs(struct ata_port *ap)
{
	......
	if (!pp->fbs_supported)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	if ((fbs & PORT_FBS_EN) == 0) {
		pp->fbs_enabled = false;
		return;
	}

	rc = ahci_stop_engine(ap);



static void ahci_enable_fbs(struct ata_port *ap)
{
	......
	if (!pp->fbs_supported)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN) {
		pp->fbs_enabled = true;
		pp->fbs_last_dev = -1; /* initialization */
		return;
	}

	rc = ahci_stop_engine(ap);



Thanks,
Shane

