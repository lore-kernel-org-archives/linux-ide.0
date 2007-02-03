From: Florian Echtler <floe@butterbrot.org>
Subject: Problems (and confusions) with Intel ICH7 SATA controller
Date: Sat, 03 Feb 2007 21:59:33 +0100
Message-ID: <1170536373.7892.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bxkV75FnPXOeE4xMy6Ky"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from charlie109.server4you.de ([85.25.2.70]:47350 "EHLO
	butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbXBCVTY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Feb 2007 16:19:24 -0500
Received: from [192.168.1.130] (unknown [88.217.47.221])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTP id 9ED4D7BC76
	for <linux-ide@vger.kernel.org>; Sat,  3 Feb 2007 21:57:51 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-bxkV75FnPXOeE4xMy6Ky
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I hope this is the right place to ask.. :-)

I have an Acer Aspire 5550 laptop with Core Solo processor and the Intel
ICH7 Chipset. Most of the hardware works fine, with the exception of
suspend-to-ram.=20

I have a strong suspicion that the SATA controller is to blame for that,
as I have tried every possible combination of s2ram parameters and still
the display stays black upon resume, only the hard disk LED lights up
and stays that way.

I have seen suggestions to try the ahci driver instead of the ata_piix
driver, however, as far as I understand this would need switching the
controller mode in BIOS. The BIOS is, unfortunately, utterly crippled
and gives almost no options to change anything beyond the system clock.

Is this a known problem with ICH7? Can anybody give me some additional
hints?

Thanks in advance,
Yours, Florian



P.S. I would have tried a serial console, however, this is a so-called
legacy free laptop and I currently don't really know how to get one. I'm
planning to try a USB-Serial-Converter next.

--=-bxkV75FnPXOeE4xMy6Ky
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFxPe17CzyshGvatgRAttxAJ920Dzntxbj3mvCckdC6b/MazorywCeOKLC
GncLakFsEIn+nTF+cIC2MkY=
=cQek
-----END PGP SIGNATURE-----

--=-bxkV75FnPXOeE4xMy6Ky--

