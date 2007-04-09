From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sun, 08 Apr 2007 23:13:54 -0700
Message-ID: <4619D9A2.4090602@ipom.com>
References: <46182C10.7010703@ipom.com> <4618C766.5080903@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E85DF964ABF06D4B40559F6"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:35183 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbXDIGOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 02:14:11 -0400
In-Reply-To: <4618C766.5080903@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E85DF964ABF06D4B40559F6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ansgar Knappheide wrote:
> I got similar errors since kernel 2.6.20-xx and the LBA48/EH fix betwee=
n
> 2.6.21-rc5-git10 and 2.6.21-rc5-git13 seems to fix it. I'm no developer=
,
> but you should perhaps try kernel 2.6.21-rc5-git13 or later.

I tried 2.6.21-rc6-git1 as I figure it was likely to be a bit more stable=

(closer to a 'stable' release), but I'm still getting these messages.

Any other thoughts?

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming



--------------enig0E85DF964ABF06D4B40559F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGGdmmN5XoxaHnMrsRAkivAJ9faibOgUAVsX9UZ5hZTnHvnSNnigCfd/O1
eEDfNkT5OHPIE6E1YETcgqg=
=I1Ju
-----END PGP SIGNATURE-----

--------------enig0E85DF964ABF06D4B40559F6--
