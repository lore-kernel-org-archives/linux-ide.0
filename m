From: Phil Dibowitz <phil@ipom.com>
Subject: libata1.patch
Date: Sat, 22 Apr 2006 22:38:41 -0700
Message-ID: <444B12E1.1080806@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD7A789E72A93C2228D812292"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:52697 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S1751158AbWDWFip (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Apr 2006 01:38:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7A789E72A93C2228D812292
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff / et al,

My general email to the list still didn't get a response, I figured I'd
try a different subject line and CC'ing Jeff directly.

I tried 2.6.15.6-libata1.patch and was able to succesfully use a PATA
drive from my Promise 20378 card! Thanks for the hard work. It works
great for the most part.

One big question/problem I had:

  The kernel raid autodetection doesn't work here. Though I'm not clear
  if it supports going across controllers. I set up a raid-1 array wtih
  a drive on my other controller, set the partition type to autodetect,
  but a reboot left my array with just the drive not on the promise
  card. Should this work? Am I missing something?

Also - is there an effort to get this merged into mainline?

Note that my box has a 82801EB/ER controller which is currently my
primarycontoller as well as the Promise PDC20378 which is what I'm using
this patch for.

As a side note: Currently my BIOS's ATA settings are "SATA mode" - I
also have "PATA mode" "SATA+PATA mode". I tried SATA+PATA and I get a
bunch of IRQ16 ignored messages, a few tracebacks, and a LOT of
slowness. I also get 3 scsi controller devices. I haven't tried the PATA
mode.

Thanks.
--=20
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Suess



--------------enigD7A789E72A93C2228D812292
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESxLhN5XoxaHnMrsRArKMAJ4/HaDLPJJmeomWvAWNwxtcAg0k8gCglJse
04DPvUAqMJyEmTBljhi1qY4=
=/m6f
-----END PGP SIGNATURE-----

--------------enigD7A789E72A93C2228D812292--
