From: Bob Ham <rah@bash.sh>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 22:22:05 +0100
Message-ID: <1185916925.8484.23.camel@orchid.arb.net>
References: <1185880124.3483.25.camel@localhost>
	 <46AF3939.8020805@ru.mvista.com>  <46AF76D7.8050800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E4dGmD9Q+NDLuM+nzoT6"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:53702 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbXGaVWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 17:22:51 -0400
In-Reply-To: <46AF76D7.8050800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


--=-E4dGmD9Q+NDLuM+nzoT6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-31 at 21:52 +0400, Sergei Shtylyov wrote:
> Hello, I wrote:
>=20
> >> I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller fo=
r
> >> a while now, using a proprietary binary driver from Highpoint in a lin=
ux
> >> 2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
> >> boot, as reported by others.
>=20
> >    Can we see a bootlog please?
>=20
>     ... and the output of 'lspci -v' too.

The machine locks hard when the driver is loaded so I can't give a full
transcription, but here is the driver's output:

HPT374: IDE controller at PCI slot 0000:00:0d.0
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT374: chipset revision 7
HPT374: DPLL base: 48 MHz, f_CNT: 141, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
HPT374: 100% native mode on irq 16
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 16 (level, low) -> IRQ 16
HPT374: no clock data saved by BIOS
HPT374: DPLL base: 48 MHz, f_CNT: 93, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
    ide4: BM-DMA at 0xed00-0xed07, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xed08-0xed0f, BIOS settings: hdk:DMA, hdl:pio


The pata_hpt37x driver is refusing to work as well but it doesn't crash
the machine.  Here is the relevant error message:

hpt37x: DPLL did not stabilize.
pata_hpt37x: BIOS has not set timing clocks.
hpt37x: DPLL did not stabilize.


lspci gives:

00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc. Unknown device 0001
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
        I/O ports at efa0 [size=3D8]
        I/O ports at ef9c [size=3D4]
        I/O ports at ef90 [size=3D8]
        I/O ports at ef98 [size=3D4]
        I/O ports at ec00 [size=3D256]
        Expansion ROM at fe700000 [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2

00:0d.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc. Unknown device 0001
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
        I/O ports at eff0 [size=3D8]
        I/O ports at efe4 [size=3D4]
        I/O ports at efa8 [size=3D8]
        I/O ports at efe0 [size=3D4]
        I/O ports at ed00 [size=3D256]
        Capabilities: [60] Power Management version 2


Bob

--=20
Bob Ham <rah@bash.sh>

--=-E4dGmD9Q+NDLuM+nzoT6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGr6f47whsMRnFexQRArhYAJ9UfylZbN2vSVOU7NnIEQsExKBx1ACgwom6
JizdN4LBV7wwqZca5LePyvY=
=Nw0D
-----END PGP SIGNATURE-----

--=-E4dGmD9Q+NDLuM+nzoT6--

