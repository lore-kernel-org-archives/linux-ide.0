From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 12:56:48 -0400
Message-ID: <4852A6D0.8030607@rtr.ca>
References: <20080512132611.GA15410@deprecation.cyrius.com> <20080612181851.GA19874@deprecation.cyrius.com> <48526B44.4060600@rtr.ca> <200806131812.38055.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3486 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750700AbYFMQ46 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 12:56:58 -0400
In-Reply-To: <200806131812.38055.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

=46rans Pop wrote:
> Hello Mark,
>=20
> Martin forwarded your mail to me as I'm seeing the same/similar issue=
 on
> my QNAP TS-109 running arm 2.6.26-rc6 (old ABI).
>=20
> On Friday 13 June 2008, Mark Lord wrote:
>> Mmm.. I don't know how this can happen, even if it does happen.
>> Unless perhaps the plaform code doesn't do a (driver).remove() call,
>> which is where we disable the interrupt you see above.
>>
>> This *is* a "platform" (non-PCI) device, right?
>=20
> With your debug patch included, I get on boot:
>=20
> console [ttyS0] enabled
> serial8250.0: ttyS1 at MMIO 0xf1012100 (irq =3D 4) is a 16550A
> brd: module loaded
> Driver 'sd' needs updating - please use bus_type methods
> mv_platform_probe(c02ec910)
> sata_mv sata_mv.0: version 1.24
> sata_mv sata_mv.0: slots 32 ports 2
> scsi0 : sata_mv
> scsi1 : sata_mv
> ata1: SATA max UDMA/133 irq 29
> ata2: SATA max UDMA/133 irq 29
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
> ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> ata2: SATA link down (SStatus 0 SControl 300)
> scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 =
ANSI: 5
> sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
> sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
>  sda: sda1 sda2 < sda5 sda6 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
>=20
> Which has your 'mv_platform_probe(c02ec910)'
>=20
>> That being the case, can you stick a printk() into mv_platform_remov=
e()
>> so we can see whether or not it gets called before "power down" ?
>=20
> But on poweroff:
>=20
> Will now halt.
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Stopping disk
> Power down.
> qnap_ts209_power_off: triggering power-off...
> ata1: exception Emask 0=EF=BF=BD
>=20
> So no sign of anything getting called here.
=2E.

Mmm.. I suppose .remove() is not supposed to be called, then.
What does happen, is sd_shutdown() runs ("Stopping disk"),
and that's that.

Weird.  I'd have thought there'd be a call somewhere to .port_stop()
or even .host_stop() on shutdown, but I don't see one anywhere.

Tejun?
Don't we try and turn off the hardware (IRQs) after stopping the drives=
?
Because these guys are seeing interrupts afterwards (loss of PHY, it se=
ems),
and that looks somewhat risky -- such an interrupt might kill the shutd=
own sequence,
leaving a machine in limbo.  Or not (?).

-ml
