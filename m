From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25 to 2.6.26-rc8 regression  (related to ahci and acpi _GTF)
Date: Tue, 1 Jul 2008 16:14:20 +0200
Message-ID: <200807011614.21491.rjw@sisk.pl>
References: <4869FB3C.4060509@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4869FB3C.4060509@crans.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mathieu =?iso-8859-15?q?B=E9rard?= <Mathieu.Berard@crans.org>, linux-ide@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

[Adding CCs.]

On Tuesday, 1 of July 2008, Mathieu B=E9rard wrote:
> Hi,
> I have a laptop with an ICH6M SATA Controller and a Hitachi hard driv=
e.
> While it worked well using the ahci module and Linux 2.6.25,=20
> it get randomly 'stuck' for several seconds to several minutes with 2=
=2E6.26-rc8.
> Successive errors progressively reduce the ATA link speed.
>=20
> Passing the libata.noacpi parameter is an effective workaround.
>=20
> Please note that it's not the first time i have this kind of issue, s=
ee:
> http://marc.info/?l=3Dlinux-ide&m=3D117305595312399&w=3D2
> This was found to be a bad interaction between my _GTF taskfile, whic=
h enable the
> "Enable Device-Initiated Interface Power State Transitions" feature, =
and NCQ.
> The driver was later NCQ blacklisted to correct the problem.
>=20
>=20
> Device detection:
>=20
> [    0.567684] ahci 0000:00:1f.2: version 3.0
> [    1.568027] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5=
 Gbps 0x5 impl IDE mode
> [    1.568091] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part=20
> [    1.568695] ata1: SATA max UDMA/133 abar m1024@0xb8000c00 port 0xb=
8000d00 irq 19
> [    1.873016] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.874045] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
> [    1.875000] ata1.00: ATA-7: HTS541010G9SA00, MBZOC60D, max UDMA/10=
0
> [    1.875000] ata1.00: 195371568 sectors, multi 0: LBA48 NCQ (not us=
ed)
> [    1.875000] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
> [    1.875000] ata1.00: configured for UDMA/100
>=20
> Typical error:
>=20
> [  499.178040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6 frozen
> [  499.178105] ata1.00: cmd ca/00:3e:76:45:81/00:00:00:00:00/e1 tag 0=
 dma 31744 out
> [  499.178106]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask=
 0x4 (timeout)
> [  499.178168] ata1.00: status: { DRDY }
> [  499.178220] ata1: hard resetting link
> [  499.942034] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  499.943540] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
> [  499.946056] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 succeeded
> [  499.947174] ata1.00: configured for UDMA/100
> [  499.947174] ata1: EH complete
>=20
> Full dmesg is attached.
>=20



--=20
"Premature optimization is the root of all evil." - Donald Knuth
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
