From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Promise 20378
Date: Sun, 16 Apr 2006 14:32:19 -0700
Message-ID: <4442B7E3.4000502@ipom.com>
References: <20050909152134.24qevggbgg480ooo@engin.mail.umich.edu> <4439C7EA.601@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8D95F9DC21D105224E7309B0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:59057 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S1750807AbWDPVc2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Apr 2006 17:32:28 -0400
Received: from [10.1.1.2] (cpe-24-24-245-191.socal.res.rr.com [24.24.245.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uberhacker.sage-inc.com (Postfix) with ESMTP id 3A3561BBEA
	for <linux-ide@vger.kernel.org>; Sun, 16 Apr 2006 16:32:31 -0500 (CDT)
In-Reply-To: <4439C7EA.601@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D95F9DC21D105224E7309B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I never saw a response to my email below. Any thoughts on this? Thanks.

Phil Dibowitz wrote:
> mreuther@umich.edu wrote:
> 
>>Phil, there is a patch in Jeff Garzik's libata-dev patch queue to support PATA
>>on Promise SATA hosts. I haven't tried it out myself, but it may cover your
>>case.
>>
>>Go to http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/ and grab the
>>latest patch for 2.4 or 2.6. If you grab 2.6.13-rc7-libata1.patch.bz2, it
>>applies cleanly to 2.6.13.
>>
>>Please report back the results!
> 
> 
> Finally got around to trying this. It works great! I patched 2.6.15.6
> with this patch, and everything seems to be fully functional as far as
> the PATA drive on that controller is concerned.
> 
> However, a few concerns:
> 
> 1. The kernel raid autodetection doesn't work here. Though I'm not clear
> if it supports going across controllers. I set up a raid-1 array wtih a
> drive on my other controller, set the partition type to autodetect, but
> a reboot left my array with just the drive not on the promise card.
> 
> 2. Currently my BIOS's ATA settings are "SATA mode" - I also have "PATA
> mode" "SATA+PATA mode". I tried SATA+PATA and I get a bunch of IRQ16
> ignored messages, a few tracebacks, and a LOT of slowness. I also get 3
> scsiI haven't tried the PATA mode.
> 
> Note that my box has 82801EB/ER controller which is currently my primary
> contoller as well as the Promise PDC20378 which is what I'm using this
> patch for.
> 
> Any help would be appreciated.
> 


-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Suess


--------------enig8D95F9DC21D105224E7309B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEQrfjN5XoxaHnMrsRAqVIAJ4yICSZyKuGOCzj+3CcWZE/jG+RxQCfe2Z9
vKZbK+IhXj/lZ69mCDEccZc=
=UAMO
-----END PGP SIGNATURE-----

--------------enig8D95F9DC21D105224E7309B0--
