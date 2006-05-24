From: Phil Dibowitz <phil@ipom.com>
Subject: Re: pdc20575 and driver 1.04
Date: Wed, 24 May 2006 01:06:05 -0700
Message-ID: <447413ED.6090403@ipom.com>
References: <44718312.9090900@ipom.com> <4471F099.4060109@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8AB755F74DDE8166CB637EA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:59539 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S932655AbWEXIGH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 04:06:07 -0400
In-Reply-To: <4471F099.4060109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8AB755F74DDE8166CB637EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Just simply that 2.6.17-rc4-git2-libata1 patch didn't include "other
> stuff", unlike the other patches.

BTW - Jeff, for what it's worth, I've found the PATA-on-SATA support to
work quite well, except for the one raid-autodetect problem I posted a
few times - the PATA support itself seems very solid.

I've hit the disks fairly hard and things seem good.

--=20
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Seuss



--------------enigA8AB755F74DDE8166CB637EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdBPtN5XoxaHnMrsRAp7EAJ0Tyf/UP/HEU7sG8NsB/By1gqR0BgCeKA+e
BUGL216ZvTX2YtwGlalUXso=
=HtlH
-----END PGP SIGNATURE-----

--------------enigA8AB755F74DDE8166CB637EA--
