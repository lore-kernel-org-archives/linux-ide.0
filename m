From: Frans Pop <elendil@planet.nl>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Fri, 13 Jun 2008 18:12:36 +0200
Message-ID: <200806131812.38055.elendil@planet.nl>
References: <20080512132611.GA15410@deprecation.cyrius.com> <20080612181851.GA19874@deprecation.cyrius.com> <48526B44.4060600@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml14.kpnxchange.com ([213.75.38.114]:18328 "EHLO
	hpsmtp-eml14.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756936AbYFMQ1w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 12:27:52 -0400
In-Reply-To: <48526B44.4060600@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

Hello Mark,

Martin forwarded your mail to me as I'm seeing the same/similar issue o=
n
my QNAP TS-109 running arm 2.6.26-rc6 (old ABI).

On Friday 13 June 2008, Mark Lord wrote:
> Mmm.. I don't know how this can happen, even if it does happen.
> Unless perhaps the plaform code doesn't do a (driver).remove() call,
> which is where we disable the interrupt you see above.
>
> This *is* a "platform" (non-PCI) device, right?

With your debug patch included, I get on boot:

console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xf1012100 (irq =3D 4) is a 16550A
brd: module loaded
Driver 'sd' needs updating - please use bus_type methods
mv_platform_probe(c02ec910)
sata_mv sata_mv.0: version 1.24
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 29
ata2: SATA max UDMA/133 irq 29
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: HDT722516DLA380, V43OA91A, max UDMA/133
ata1.00: 321672960 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 AN=
SI: 5
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
sd 0:0:0:0: [sda] 321672960 512-byte hardware sectors (164697 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
 sda: sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0

Which has your 'mv_platform_probe(c02ec910)'

> That being the case, can you stick a printk() into mv_platform_remove=
()
> so we can see whether or not it gets called before "power down" ?

But on poweroff:

Will now halt.
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
Power down.
qnap_ts209_power_off: triggering power-off...
ata1: exception Emask 0=EF=BF=BD

So no sign of anything getting called here.

Cheers,
=46JP
