From: Saswat Praharaj <saswat@gmail.com>
Subject: Re: read vs write
Date: Mon, 25 Jul 2005 17:10:22 +0530
Message-ID: <d15adc960507250440510efd58@mail.gmail.com>
References: <d15adc960507250314ec47755@mail.gmail.com>
	 <42E4BFC1.7070905@stesmi.com>
Reply-To: Saswat Praharaj <saswat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:19597 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbVGYLkW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 07:40:22 -0400
Received: by wproxy.gmail.com with SMTP id 37so946565wra
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2005 04:40:22 -0700 (PDT)
In-Reply-To: <42E4BFC1.7070905@stesmi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-ide@vger.kernel.org

yups I meant MBps ..thanks for correcting me .

However, I dont agree with your ford/road example.

I just checked the product specification of STA340016A (seagate) .=20

Here is what they claim :=20

[  This manual describes the functional, mechanical and interface speci=
fi-
cations for the ST380021A, ST360021A, ST340016A and ST320011A.
These drives provide the following key features:
=B7 7,200-RPM spindle speed and 2-Mbyte buffer combine for superior
  desktop performance
=B7 High instantaneous (burst) data-transfer rates (up to 100 Mbytes pe=
r
  second) using Ultra DMA mode 5 ]

I have found average seek time is little faster (around 1ms) for read
than write.
Still that doesn't justify the write speed of 15-20 MBps and 55-60
MBps for read.

Can anyone help me understading how/why write is different than read.

Thanks and Regards,
Saswat

On 7/25/05, Stefan Smietanowski <stesmi@stesmi.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Saswat.
>=20
> > Moreover, I am wondering if I could achieve the 100Mbps read speed =
as
> > claimed by different vendors.For me , It should ideally be 100 Mbps=
 as
> > I am using a 80 conductor cable and UDMA 5.Why then I am getting 58
> > Mbps max . .
>=20
> If you mean Mbps then you are already above it. 100Mbps =3D 12.5MB/s
> give or take and both speeds are above that.
> I guess you probably mean 100MB/s though and that is only what
> the cable can take.
>=20
> If you take a T-ford onto the highway - can you go 130Km/h in it?
>=20
> No, the road is rated at 130Km/s but the car can't go that fast.
>=20
> Same here, the standard says you can transfer 100MB/s over the cable
> but the disk isn't fast enough to be able to transfer that fast.
>=20
> // Stefan
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (MingW32)
>=20
> iD8DBQFC5L/BBrn2kJu9P78RAkXKAJ4vc/xQ0Z8mA1ddo79+wC6NCFe5VACgl+j+
> ceP+as8dx0uZs2W6xaYiMVc=3D
> =3DOf1/
> -----END PGP SIGNATURE-----
>
