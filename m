From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Wed, 2 Sep 2009 10:32:01 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC988D@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com> <4A9DD153.5050106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:32171
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751536AbZIBCcm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 22:32:42 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9DD153.5050106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> 
> I meant that sata_pmp_attached() is a driver state and might not match
> the controller state after resume which is why the ahci driver calls
> detach in the first place regardless of sata_pmp_attached(), so it
> might be better to check the register directly and set or clear it
> regardless of sata_pmp_attached().

OK, right, here is the updated implementation, WARN_ON() has been
replaced by direct register check.

static void ahci_enable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	if (fbs & PORT_FBS_EN)
		return;

	rc = ahci_stop_engine(ap);
	if (rc)
		return;

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


static void ahci_disable_fbs(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 fbs;
	int rc;

	if (!pp->fbs_supported)
		return;

	fbs = readl(port_mmio + PORT_FBS);
	if ((fbs & PORT_FBS_EN) == 0)
		return;

	rc = ahci_stop_engine(ap);
	if (rc)
		return;

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


Thanks
Shane

