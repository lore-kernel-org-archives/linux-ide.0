From: Bob Ham <rah@bash.sh>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Mon, 06 Aug 2007 17:53:43 +0100
Message-ID: <1186419223.23890.3.camel@orchid.arb.net>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lqK6MhpF1AUkxcaWwwy8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:58188 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbXHFQxy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 12:53:54 -0400
In-Reply-To: <200708052245.16406.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


--=-lqK6MhpF1AUkxcaWwwy8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-08-05 at 22:45 +0400, Sergei Shtylyov wrote:
> The DPLL tuning code always set up it for 66 MHz due to wrong UltraDMA ma=
sk
> including mode 5 used to check for the necessity of 66 MHz clocking -- Th=
is
> caused 66 MHz clock to be used for HPT374 chip that does not tolerate it.
> While fixing this, also remove PLL mode from the TODO list -- I don't thi=
nk
> it's still relevant item.
>=20
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>=20
> ---
> This is against the current Linus tree.
> Bob, please test it and report what you'll find out...

para_hpt37x: bus clock 33MHz, using 50MHz DPLL.
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
scsi2: pata_hpt37x
scsi3: pata_hpt37x
ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq =
17
ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq =
17


followed by a hard lock

--=20
Bob Ham <rah@bash.sh>

--=-lqK6MhpF1AUkxcaWwwy8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGt1IM7whsMRnFexQRAmV+AKDFEl1CgbBJ/JsWYp/qr4wl0PELRwCfQBdi
fce9n017MAiq1Q2c4/gXkqY=
=9vwD
-----END PGP SIGNATURE-----

--=-lqK6MhpF1AUkxcaWwwy8--

