From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sun, 15 Apr 2007 23:55:31 -0700
Message-ID: <46231DE3.8070404@ipom.com>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se> <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E8F37724C26A3A1C399C372"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:49334 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbXDPGzf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 02:55:35 -0400
In-Reply-To: <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E8F37724C26A3A1C399C372
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Given that the last one was a hardware issue, I bought a new controller.
Despite my bad luck, given my price-range promise still seemed to be the =
one
with the most good reports, so I went with that. I was going to go with a=

sil, but I couldn't find one..

Anyway, things are MUCH better now... but about once a week, I get:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x00001000)
ata2.00: cmd c8/00:80:9a:71:d0/00:00:00:00:00/ea tag 0 cdb 0x0 data 65536=
 in
         res 40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x24 (host bus err=
or)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
rt
DPO or FUA


It's the same port_status and Emask/SAct/SErr/action each time... only th=
e
cmd/res and data change (obviously those would change)...

Can anyone tell me what that means?

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming



--------------enig9E8F37724C26A3A1C399C372
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIx3jN5XoxaHnMrsRAvUFAJ4hmutqc/7HmKidlhijUqCNkuvYQACgoPhF
B0QHSSD9n7xqeSDMmdOimys=
=mxyr
-----END PGP SIGNATURE-----

--------------enig9E8F37724C26A3A1C399C372--
