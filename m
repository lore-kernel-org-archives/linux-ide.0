From: Prakash Punnoor <prakashp@arcor.de>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 22:28:21 +0100
Message-ID: <421CF575.20801@arcor.de>
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEAAB9FD077E1A47AEE6106E5"
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45281 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261600AbVBWV2K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 16:28:10 -0500
In-Reply-To: <200502232345.23666.adobriyan@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAAB9FD077E1A47AEE6106E5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alexey Dobriyan schrieb:
> On Wednesday 23 February 2005 21:57, Jeff Garzik wrote:

>>+		addr = sg_dma_address(sg);
>>+		*(u64 *)prd = cpu_to_le64(addr);
>
>
> *(__le64 *) prd
>
>
>>+		prd += sizeof(u64);
>
>
>>+		len = sg_dma_len(sg);
>>+		*(u32 *)prd = cpu_to_le32(len);
>
>
> *(__le32 *) prd

If I am not totally mistaken this is not gcc4 friendly code. (lvalue thing...)
Wouldn't it be better to prevent double patching?

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigEAAB9FD077E1A47AEE6106E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCHPV5xU2n/+9+t5gRAjvPAJ40AfCWd+7UnbK+oYcs2qckx9QE7wCgnalY
j5kSv468tlbc/a6fgF7FaTw=
=DPhM
-----END PGP SIGNATURE-----

--------------enigEAAB9FD077E1A47AEE6106E5--
