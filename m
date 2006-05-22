From: Phil Dibowitz <phil@ipom.com>
Subject: Re: pdc20575 and driver 1.04
Date: Mon, 22 May 2006 02:23:30 -0700
Message-ID: <44718312.9090900@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC73E66144FF5188ECBFDE293"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:27874 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S1750714AbWEVJXy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 05:23:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: viet@mandriva.com, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC73E66144FF5188ECBFDE293
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

jgarzik@pobox.com wrote:
> viet@mandriva.com wrote:
> > Hi Jeff,
> >
> > We've briefly met at Deauville while you were working with mandriva
> > I hope everything is fine with you - I myself have just been laid
> off, just about \
> > six years after joining mandrake ...
> > Anyway, back to business.
> > I have a Promise sataII TX2+ cards, with a pdc 20575.
> >
> > I have just tried stock 2.6.17-rc4 and applied
> > 2.6.17-rc4-git2-libata1.patch.bz2
> > I am only detecting the two sata lines.
> > the motherboard is smp, and has pdc20265 onboard. there are 4 drives
> attached to \
> > the TX2+ (two sata, two pata)
> > If I am not mistaken, driver version 1.04 is the latest one you have =
> ?
>
> Promise PATA-on-SATA-cards support lives in
> libata-dev.git#promise-sata-pata, until someone cleans it up.
>
> This is not found in 2.6.17-rc4 nor 2.6.17-rc4-git2-libata1.  It is
> found in Andrew Morton's -mm tree, though.

It's not in 2.6.17-rc4-git2-libata1?

Did you remove that support from the libata patches at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/ ?

2.6.15-libata1.patch added Promise PATA-on-SATA for my PC20378 (see my
email from earlier today)...

In fact, back on 09/09/05, Matt (Reuther?) pointed me to your patches
(and CC'd the list) for exactly that reason:
http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D112629381132249&w=3D2

I'm confused...
--=20
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Seuss



--------------enigC73E66144FF5188ECBFDE293
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcYMSN5XoxaHnMrsRAm1xAKCcLl3k30cdHcXMdZBPlm0xRllKpwCffo8x
819HMTP5TfjDHNhvjf+9gUY=
=2uWf
-----END PGP SIGNATURE-----

--------------enigC73E66144FF5188ECBFDE293--
