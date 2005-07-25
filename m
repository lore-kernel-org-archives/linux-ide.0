From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: read vs write
Date: Mon, 25 Jul 2005 14:36:22 +0200
Message-ID: <42E4DCC6.7010302@stesmi.com>
References: <d15adc960507250314ec47755@mail.gmail.com>	 <42E4BFC1.7070905@stesmi.com> <d15adc960507250440510efd58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep01.bredband.com ([195.54.107.70]:53904 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261152AbVGYMaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 08:30:11 -0400
In-Reply-To: <d15adc960507250440510efd58@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saswat Praharaj <saswat@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Saswat Praharaj wrote:
> yups I meant MBps ..thanks for correcting me .
>=20
> However, I dont agree with your ford/road example.
>=20
> I just checked the product specification of STA340016A (seagate) .=20
>=20
> Here is what they claim :=20
>=20
> [  This manual describes the functional, mechanical and interface spe=
cifi-
> cations for the ST380021A, ST360021A, ST340016A and ST320011A.
> These drives provide the following key features:
> =B7 7,200-RPM spindle speed and 2-Mbyte buffer combine for superior
>   desktop performance
> =B7 High instantaneous (burst) data-transfer rates (up to 100 Mbytes =
per
>   second) using Ultra DMA mode 5 ]

Yes, burst is transfer speed not speed from the platter.

The drive has a cache (2MB). From that cache you can transfer
at 100MB/s, not from the platter sadly enough. Even those 10kRPM
drives don't do 100.

So road =3D=3D cable =3D=3D from cache in a sense (assuming the cache c=
an
do 100MB/s).
T-Ford =3D platter.

I wish it was different but it's not.

I mean, a SATAII-300 - do you honestly believe you can read and write
att 300MB/s to that drive? To/From Cache : maybe. Platter : No way.

But if you read the same data 10 times in a row (size=3D1MB let's say)
then yes, you should be seeing 100MB/s or somewhere close depending on
where your controller is, how saturated the bus is, etc.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC5NzGBrn2kJu9P78RAikFAJ0Tg073q3hsBb6bG9ucwOqYLaxBuQCfQWqk
gYjK8WJ/at4uNJhks+uh3RA=3D
=3DcNWZ
-----END PGP SIGNATURE-----
