From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Promise 20378
Date: Sat, 23 Jul 2005 13:38:56 -0700
Message-ID: <42E2AAE0.2090501@ipom.com>
References: <42C7B584.401@ipom.com> <42C9F50B.4000508@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enigED76D0472C5ADE40AD6240B1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx3.usc.edu ([128.125.137.8]:35728 "EHLO msg-mx3.usc.edu")
	by vger.kernel.org with ESMTP id S261590AbVGWUjI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jul 2005 16:39:08 -0400
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx3.usc.edu (Sun Java System Messaging Server 6.2-2.07 (built May 25
 2005)) with ESMTPSA id <0IK300GT3LD2JXE0@msg-mx3.usc.edu> for
 linux-ide@vger.kernel.org; Sat, 23 Jul 2005 13:39:08 -0700 (PDT)
In-reply-to: <42C9F50B.4000508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED76D0472C5ADE40AD6240B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I finally got a chance to test this.

So, the sata_promise driver seems to support the Promise 20378
controller, but it doesn't see PATA drives (the controller supports both
SATA and PATA drives).

I plugged a single PATA drive in - then in the promise BIOS I configured
a single "array" on the drive, and booted. This sata_promise sees the
PATA and SATA controller, but doesn't see the drives:

Jul 23 13:31:47 rider kernel: ata1: SATA max UDMA/133 cmd 0xF89E4200 ctl
0xF89E4238 bmdma 0x0 irq 23
Jul 23 13:31:47 rider kernel: ata2: SATA max UDMA/133 cmd 0xF89E4280 ctl
0xF89E42B8 bmdma 0x0 irq 23
Jul 23 13:31:47 rider kernel: ata1: no device found (phy stat 00000000)
Jul 23 13:31:47 rider kernel: scsi0 : sata_promise
Jul 23 13:31:47 rider kernel: ata2: no device found (phy stat 00000000)
Jul 23 13:31:47 rider kernel: scsi1 : sata_promise

It sees no drives there period. Further, while it the device has 2 SATA
chains, it only has 1 PATA, but as you can see, it seems to see 2.

Any ideas?

(PS. I'm not on the list, so please CC me).

Thanks,
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759


--------------enigED76D0472C5ADE40AD6240B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4qrmN5XoxaHnMrsRArQIAKCGaYtWGDzzShJaw037nXGHh+n4CQCfeScm
Wdii8ckpuy+Sa1N9spEuje4=
=iwA/
-----END PGP SIGNATURE-----

--------------enigED76D0472C5ADE40AD6240B1--
