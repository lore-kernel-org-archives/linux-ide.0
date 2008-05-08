From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Thu, 8 May 2008 16:35:55 -0700
Message-ID: <20080508163555.51380949@appleyard>
References: <20080508161008.59361de5@appleyard>
	<20080508233713.GB15377@srcf.ucam.org>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64717 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbYEHXnR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 May 2008 19:43:17 -0400
In-Reply-To: <20080508233713.GB15377@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 9 May 2008 00:37:13 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 08, 2008 at 04:10:08PM -0700, Kristen Carlson Accardi wrote:
> 
> > +static int ahci_is_hotplug_capable(struct ata_port *ap)
> > +{
> > +	void __iomem *port_mmio = ahci_port_base(ap);
> > +	u8 cmd;
> > +
> > +	if (!ahci_power_save)
> > +		return 1;
> > +
> > +	cmd = readl(port_mmio + PORT_CMD);
> > +	return ((cmd & PORT_CMD_HPCP) || (cmd & PORT_CMD_ESP));
> > +}
> 
> Just out of interest, is this set on laptop bays? (Are any of those even 
> native SATA yet?)

I haven't seen any yet that are.  Most of them are PATA.  I expect
that will change in the future.

