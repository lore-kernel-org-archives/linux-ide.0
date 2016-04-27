From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/5] ata: ahci: add support for non-standard port
 offset/length
Date: Wed, 27 Apr 2016 14:22:50 +0200
Message-ID: <20160427142250.12764279@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1461335561-18363-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160422175936.GU7822@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53959 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751241AbcD0MW7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Apr 2016 08:22:59 -0400
In-Reply-To: <20160422175936.GU7822@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

Hello,

Thanks for your review and feedback!

On Fri, 22 Apr 2016 13:59:36 -0400, Tejun Heo wrote:

> On Fri, Apr 22, 2016 at 04:32:37PM +0200, Thomas Petazzoni wrote:
> > @@ -1714,10 +1714,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  
> >  	for (i = 0; i < host->n_ports; i++) {
> >  		struct ata_port *ap = host->ports[i];
> > +		unsigned int offset =
> > +			hpriv->port_offset + ap->port_no * hpriv->port_length;
> >  
> >  		ata_port_pbar_desc(ap, ahci_pci_bar, -1, "abar");
> > -		ata_port_pbar_desc(ap, ahci_pci_bar,
> > -				   0x100 + ap->port_no * 0x80, "port");
> > +		ata_port_pbar_desc(ap, ahci_pci_bar, offset, "port");
> 
> Doesn't this just affect ahci_platform?

No, because the main source of the problem is the ahci_port_base()
function, which is used all over the place in libahci.c (which is used
by all AHCI drivers, not only ahci_platform drivers). And this
ahci_port_base() currently hardcodes the 0x100 / 0x80 values:

429 static inline void __iomem *__ahci_port_base(struct ata_host *host,
430                                              unsigned int port_no)
431 {
432         struct ahci_host_priv *hpriv = host->private_data;
433         void __iomem *mmio = hpriv->mmio;
434 
435         return mmio + 0x100 + (port_no * 0x80);
436 }
437 
438 static inline void __iomem *ahci_port_base(struct ata_port *ap)
439 {
440         return __ahci_port_base(ap->host, ap->port_no);
441 }

In essence all what we want to change is the __ahci_port_base()
function so that it doesn't use hardcoded values.

>  Why is ahci_init_one() being updated?

The idea why ahci_init_one() was updated is also to remove hardcoded
values. Once we have the correct values in the ahci_host_priv, why not
use them everywhere instead of keeping some hardcoded values?

> Also, who's setting port_offet and port_length for non-platform ahci
> drivers?

This is obviously a mistake in my proposal. And the non-platform
drivers are allocating manually their ahci_host_priv structure, which
makes it a bit difficult/annoying to initialize those new fields.

I see a few possibilities:

 1/ Adjust all the drivers allocating manually an ahci_host_priv
    structure, and make sure they initialize the fields to their default
    values.

 2/ Add a new helper function that allows to allocate the
    ahci_host_priv structure and initialize it with sane default values,
    and use this helper in all drivers.

 3/ Add a flag in ahci_host_priv that tells whether non-standard port
    offset/length are to be used. This is the most minimal solution,
    but also maybe not the nicest one.

> If this needs to be configurable, wouldn't it be better to just let it
> be specified per port?

How could it be per-port? The base for a port is calculated as:

	base + <port_offset> + (port_no * <port_length>)

So, port_offset is clearly not per-port, there's only one of them. And
if we were to make <port_length> a per-port property, then the formula
would become a lot more complicated: we would have to iterate over each
port, and see what is the length of the register area for each of them,
to calculate the base address of the registers for the n-th port. This
is clearly a complexity that is not needed for my use case: all ports
have the same register area length, it's just that this length is
non-standard.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
