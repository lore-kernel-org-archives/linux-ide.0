From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 09 Apr 2007 09:01:10 -0700
Message-ID: <461A6346.8070501@ipom.com>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig43BE94CC20E4995A2AA3270A"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:37603 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966070AbXDIQB0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 12:01:26 -0400
In-Reply-To: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig43BE94CC20E4995A2AA3270A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mikael Pettersson wrote:
> I've seen reports of issues like these with second-generation
> Promise SATA chips and SATAII (3Gbps) drives, but this is the
> first time I've seen any issues with a first-generation chip.
>=20
> 1. Please try 2.6.21-rc6 plus the following two patches:
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-s=
eparate-sata-pata-ops-2.6.21-rc6
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-e=
rror_intr-2.6.21-rc6
>=20
>    This probably won't eliminate the errors, but should improve
>    the level of detail in the error messages.

I'll do this tonight and send updated logs, thanks.

> 2. Try with a better power supply and verify that cooling is OK.
>    Also verify that the SATA data and power cables are firmly attached.=


My power supply is well over-sized for my machine (Antec 480W), so that
shouldn't be a problem. I double checked all my SATA data and power cable=
s.
I also tried switching from SATA-power to PATA-power cables (my drives
support both) to see if that made a difference (it didn't). I've reseated=
 my
cables, switched cable order, etc. to see if I had a bad cable, but no
evidence I do.

>    We've seen several reports of mysterious issues that eventually
>    were traced to insufficient power supplies or poorly seated
>    PCI cards (but in your case the chip is integrated on the mobo).

Understandable. I saw several reports like that on the list, and hence tr=
ied
the above.

Thanks for your time, I'll get you updated logs tonight.

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming



--------------enig43BE94CC20E4995A2AA3270A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGGmNQN5XoxaHnMrsRAnSmAKCdovf4iqwfGIgZU07xvAu72ueYWACfQkO1
2VV5ElgxCccmszpuDmmqYBI=
=vlLz
-----END PGP SIGNATURE-----

--------------enig43BE94CC20E4995A2AA3270A--
