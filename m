From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
Date: Fri, 17 Mar 2017 12:59:56 +0100
Message-ID: <1533391.BtkrkgvqUW@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <3458240.9SL7iGif3L@amdc3058> <20170316212654.GD1480@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170316212654.GD1480@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Thursday, March 16, 2017 05:26:54 PM Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 14, 2017 at 06:50:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > +static struct ata_port_operations pcmcia_ebsa110_port_ops = {
> > +	.inherits		= &ata_sff_port_ops,
> > +	.sff_dev_select		= pmcmia_ebsa110_dev_select,
>                                   ^^^^^^
> > +	.sff_set_devctl         = pcmcia_ebsa110_set_devctl,
> > +	.sff_check_status	= pcmcia_ebsa110_check_status,
> > +	.sff_check_altstatus    = pcmcia_ebsa110_check_altstatus,
> > +	.sff_tf_load		= pcmcia_ebsa110_tf_load,
> > +	.sff_tf_read		= pcmcia_ebsa110_tf_read,
> > +	.sff_exec_command	= pcmcia_ebsa110_exec_command,
> > +	.sff_data_xfer		= ata_sff_data_xfer_noirq,
> > +	.softreset		= pata_pcmcia_ebsa110_softreset,
> > +	.cable_detect		= ata_cable_40wire,
> > +	.set_mode		= pcmcia_set_mode,
> > +};
> 
> Heh, that's a fat driver for a sff device.  I suppose this is mostly
> copied from the matching ide driver but it'd be nice to explain why it
> needs duplicate most standard functions.  Is it because PCMCIA
> assigned address doesn't fall under the usual read/io boundary on the
> arch?

There is no support for this device in the upstream ide driver but
Russell has a hacky patch to make it work by redefining inb()/outb()
operations globally for the whole ide subsystem, please see:

https://www.spinics.net/lists/arm-kernel/msg567454.html

and

arch/arm/mach-ebsa110/io.c

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
