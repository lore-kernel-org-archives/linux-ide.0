From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 16 Apr 2007 00:47:22 -0700
Message-ID: <46232A0A.3040106@ipom.com>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>    <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>    <46231DE3.8070404@ipom.com> <63362.194.237.142.10.1176706927.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB70402399E7891992991FA13"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:49469 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409AbXDPHsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 03:48:05 -0400
In-Reply-To: <63362.194.237.142.10.1176706927.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB70402399E7891992991FA13
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tomi Orava wrote:
> Hi,
>=20
>> Given that the last one was a hardware issue, I bought a new controlle=
r.
>> Despite my bad luck, given my price-range promise still seemed to be t=
he
>> one
>> with the most good reports, so I went with that. I was going to go wit=
h a
>> sil, but I couldn't find one..
>=20
> Unfortunately, I don't have a solution/fix for you, but out of curiosit=
y,
> what hard-disks you have problems with ? Also what is the exact model
> of your SATA-controller ?

Whoops, forgot that bit. Sorry!

02:0c.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA =
300
TX4) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 17
        I/O ports at d480 [size=3D128]
        I/O ports at d000 [size=3D256]
        Memory at feafd000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at fea80000 (32-bit, non-prefetchable) [size=3D128K]
        Expansion ROM at 50020000 [disabled] [size=3D32K]
        Capabilities: [60] Power Management version 2

My disks are WD WD1600JS 160GB drives (2 of them in linux software RAID 1=
).

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming



--------------enigB70402399E7891992991FA13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIyovN5XoxaHnMrsRAnOaAJ92ejTaNGhOk1mN9H6j8NcITOzrUwCeM0uy
2QaLJ1Bntm3md3jcUpgY6xs=
=OUKe
-----END PGP SIGNATURE-----

--------------enigB70402399E7891992991FA13--
