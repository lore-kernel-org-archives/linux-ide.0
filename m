From: Bob Ham <rah@bash.sh>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 22:03:45 +0100
Message-ID: <1186002225.16340.11.camel@orchid.arb.net>
References: <1185880124.3483.25.camel@localhost>
	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>
	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com>
	 <1185983536.16340.3.camel@orchid.arb.net>  <46B0ADB6.60207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v6Wc11XMh9zeOa/gZl8k"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:50996 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbXHAVDv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 17:03:51 -0400
In-Reply-To: <46B0ADB6.60207@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


--=-v6Wc11XMh9zeOa/gZl8k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-01 at 19:58 +0400, Sergei Shtylyov wrote:
> > hpt37x: DPLL did not stabilize.
> > pata_hpt37x: BIOS has not set timing clocks.
> > hpt37x: DPLL did not stabilize.
>=20
>    Yes, this ia a known issue, and the fix for it is in the -mm tree:

I applied just that pata_hpt37x.c patch, not the whole -mm tree.  It
locks the machine hard again.  Here is the transcribed output:

hpt37x: Bus clock 66 MHz, using DPLL.
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
scsi2: pata_hpt37x
scsi3: pata_hpt37x
ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq =
17
ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq =
17


--=20
Bob Ham <rah@bash.sh>

--=-v6Wc11XMh9zeOa/gZl8k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGsPUt7whsMRnFexQRAiAjAJ9GHM7NGaWhmNJGlCaGzZ2+dBSVQACfYRrd
muXkSopNRJbcn8xRujGOITc=
=IGPX
-----END PGP SIGNATURE-----

--=-v6Wc11XMh9zeOa/gZl8k--

