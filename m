From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Wed, 02 Sep 2009 11:40:40 +0900
Message-ID: <4A9DDB28.7070709@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com> <4A9DD153.5050106@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC988D@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36176 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbZIBCkn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 22:40:43 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC988D@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Huang, Shane wrote:
> static void ahci_enable_fbs(struct ata_port *ap)
> {
> 	struct ahci_port_priv *pp = ap->private_data;
> 	void __iomem *port_mmio = ahci_port_base(ap);
> 	u32 fbs;
> 	int rc;
> 
> 	if (!pp->fbs_supported)
> 		return;
> 
> 	fbs = readl(port_mmio + PORT_FBS);
> 	if (fbs & PORT_FBS_EN)
> 		return;

This can leave pp->fbs_enabled out of sync, right?  Just don't check
and set the bit anyway.

> 	rc = ahci_stop_engine(ap);
> 	if (rc)
> 		return;
> 
> 	writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
> 	fbs = readl(port_mmio + PORT_FBS);
> 	if (fbs & PORT_FBS_EN) {
> 		dev_printk(KERN_INFO, ap->host->dev, "FBS is
> enabled.\n");
> 		pp->fbs_enabled = true;
> 		pp->fbs_last_dev = -1; /* initialization */
> 	} else
> 		dev_printk(KERN_ERR, ap->host->dev, "Failed to enable
> FBS\n");
> 
> 	ahci_start_engine(ap);
> }
> 
> 
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
> 	fbs = readl(port_mmio + PORT_FBS);
> 	if ((fbs & PORT_FBS_EN) == 0)
> 		return;

Ditto.

Thanks.

-- 
tejun
