From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Promise 20378
Date: Sun, 09 Apr 2006 19:50:18 -0700
Message-ID: <4439C7EA.601@ipom.com>
References: <20050909152134.24qevggbgg480ooo@engin.mail.umich.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0A1E602BE5A3D6EAE62AE110"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:11662 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S1750951AbWDJCud (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Apr 2006 22:50:33 -0400
In-Reply-To: <20050909152134.24qevggbgg480ooo@engin.mail.umich.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mreuther@umich.edu
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A1E602BE5A3D6EAE62AE110
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

mreuther@umich.edu wrote:
> Phil, there is a patch in Jeff Garzik's libata-dev patch queue to support PATA
> on Promise SATA hosts. I haven't tried it out myself, but it may cover your
> case.
> 
> Go to http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/ and grab the
> latest patch for 2.4 or 2.6. If you grab 2.6.13-rc7-libata1.patch.bz2, it
> applies cleanly to 2.6.13.
> 
> Please report back the results!

Finally got around to trying this. It works great! I patched 2.6.15.6
with this patch, and everything seems to be fully functional as far as
the PATA drive on that controller is concerned.

However, a few concerns:

1. The kernel raid autodetection doesn't work here. Though I'm not clear
if it supports going across controllers. I set up a raid-1 array wtih a
drive on my other controller, set the partition type to autodetect, but
a reboot left my array with just the drive not on the promise card.

2. Currently my BIOS's ATA settings are "SATA mode" - I also have "PATA
mode" "SATA+PATA mode". I tried SATA+PATA and I get a bunch of IRQ16
ignored messages, a few tracebacks, and a LOT of slowness. I also get 3
scsiI haven't tried the PATA mode.

Note that my box has 82801EB/ER controller which is currently my primary
contoller as well as the Promise PDC20378 which is what I'm using this
patch for.

Any help would be appreciated.

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Suess


--------------enig0A1E602BE5A3D6EAE62AE110
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEOcfwN5XoxaHnMrsRAla9AKCEHo2eHHKJfiyqfDgEA6w1YB6E5wCffOUx
DeQXr+0NXRwAwqOJ5a+QotI=
=DGkJ
-----END PGP SIGNATURE-----

--------------enig0A1E602BE5A3D6EAE62AE110--
