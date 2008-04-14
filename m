From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: 2.6.25-rc8-mm1: Intel SATA boot failure
Date: Mon, 14 Apr 2008 02:28:40 +0200
Message-ID: <4802A538.9040107@imap.cc>
References: <20080401213214.8fbb6d6b.akpm@linux-foundation.org>	<47F56363.4090002@imap.cc> <20080403161733.c05dac53.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD0D290390308BF7439E8D25D"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51081 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444AbYDNA2n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 20:28:43 -0400
In-Reply-To: <20080403161733.c05dac53.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0D290390308BF7439E8D25D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Final report, seeing -mm2 is out:

- Netconsole works. (grumblestupidsusefirewallgrumble)

- The hang during boot only happens with kernels compiled with
  CONFIG_CIFS_EXPERIMENTAL=3Dy
  It also doesn't always happen at the same point in the boot sequence.
  I'm suspecting it might be triggered by some network packet.
  Anyway, it's obviously *not* a SATA problem.
  (That was just me jumping to conclusions, because ...)

- That leaves only the messages

  ata1: port is slow to respond, please be patient (Status 0x80)
  ata1: COMRESET failed (errno=3D-16)

  and accompanying delays during boot, for each installed SATA disk.
  I'll try to find the time to retest this with 2.6.25-rc8-mm2.

Thanks,
Tilman

--=20
Tilman Schmidt                                  E-Mail: tilman@imap.cc
Wehrhausweg 66                                  Fax: +49 228 4299019
53227 Bonn, Germany


--------------enigD0D290390308BF7439E8D25D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIAqU4MdB4Whm86/kRAkuQAJ996P0box0gl+95xNfjWurYzUUimQCZAZIk
edjS6UJ0YthQHL1YMZRIO5I=
=gjNn
-----END PGP SIGNATURE-----

--------------enigD0D290390308BF7439E8D25D--
