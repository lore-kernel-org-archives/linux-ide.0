From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Promise 20378
Date: Sun, 04 Sep 2005 00:54:06 -0700
Message-ID: <431AA81E.8000205@ipom.com>
References: <42C7B584.401@ipom.com> <42C9F50B.4000508@pobox.com> <42E2AAE0.2090501@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC04B2855EFB77BFBDAA5985B"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from carbon.nocdirect.com ([69.73.156.63]:19598 "EHLO
	carbon.nocdirect.com") by vger.kernel.org with ESMTP
	id S1751239AbVIDHyP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Sep 2005 03:54:15 -0400
In-Reply-To: <42E2AAE0.2090501@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC04B2855EFB77BFBDAA5985B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I never did get a response to this - is this the known status (if so,
that's fine I have a work around, but if I'm doing something stupid, i'd
also like to know so I can start using this)...

Thanks.

Phil Dibowitz wrote:
> I finally got a chance to test this.
> 
> So, the sata_promise driver seems to support the Promise 20378
> controller, but it doesn't see PATA drives (the controller supports both
> SATA and PATA drives).
> 
> I plugged a single PATA drive in - then in the promise BIOS I configured
> a single "array" on the drive, and booted. This sata_promise sees the
> PATA and SATA controller, but doesn't see the drives:
> 
> Jul 23 13:31:47 rider kernel: ata1: SATA max UDMA/133 cmd 0xF89E4200 ctl
> 0xF89E4238 bmdma 0x0 irq 23
> Jul 23 13:31:47 rider kernel: ata2: SATA max UDMA/133 cmd 0xF89E4280 ctl
> 0xF89E42B8 bmdma 0x0 irq 23
> Jul 23 13:31:47 rider kernel: ata1: no device found (phy stat 00000000)
> Jul 23 13:31:47 rider kernel: scsi0 : sata_promise
> Jul 23 13:31:47 rider kernel: ata2: no device found (phy stat 00000000)
> Jul 23 13:31:47 rider kernel: scsi1 : sata_promise
> 
> It sees no drives there period. Further, while it the device has 2 SATA
> chains, it only has 1 PATA, but as you can see, it seems to see 2.
> 
> Any ideas?
> 
> (PS. I'm not on the list, so please CC me).
> 
> Thanks,


-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759


--------------enigC04B2855EFB77BFBDAA5985B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDGqgeN5XoxaHnMrsRAnjgAJ4jbZ9vKrBxuld15FaGKCOcHiC7zwCgkVUR
89HZI+qRqXoM1Y2n2QOLtvU=
=/hsq
-----END PGP SIGNATURE-----

--------------enigC04B2855EFB77BFBDAA5985B--
