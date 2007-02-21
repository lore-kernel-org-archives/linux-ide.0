From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: [git patches] libata ACPI support
Date: Wed, 21 Feb 2007 18:56:33 +0100
Message-ID: <20070221175633.GE5143@mail.muni.cz>
References: <20070220214716.GA3690@mail.muni.cz> <45DB74D9.206@garzik.org> <20070220232633.GA3598@mail.muni.cz> <45DB88FD.5020509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tirith.ics.muni.cz ([147.251.4.36]:49384 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422732AbXBUR4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 12:56:17 -0500
Content-Disposition: inline
In-Reply-To: <45DB88FD.5020509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Feb 20, 2007 at 06:49:17PM -0500, Jeff Garzik wrote:
> Can you narrow down the -gitX release further?  i.e. does 2.6.20-git1=
3=20
> perform at full speed?  -git13 includes several libata changes, but d=
oes=20
> not include the ACPI additions.
>=20
> Since this is an ACPI execution error in the bug, that would tend to=20
> point to bad BIOS tables.  But since there is a performance drop that=
=20
> does not disappear with acpi=3Doff, there might also be another facto=
r,=20
> unrelated to ACPI, at play here.

I've noticed on lkm another bug report which has pointed me to this:
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 =
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 =
irq 15
scsi0 : ata_piix
ata1.00: ATA-6: ST9100824A, 3.04, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33

Both ports are for some reason configured as UDMA/33.

--=20
Luk=E1=B9 Hejtm=E1nek
