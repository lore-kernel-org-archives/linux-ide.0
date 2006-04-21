From: Reinhard =?iso-8859-1?q?Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: sata_via and SATA DVD drive (PX-712SA)
Date: Fri, 21 Apr 2006 23:20:26 +0200
Message-ID: <200604212320.30854.r.brandstaedter@gmx.at>
References: <200604202020.22010.r.brandstaedter@gmx.at> <444888AE.8000706@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1912496.UAJZAtcoLs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.noc.eunet-ag.at ([193.154.160.91]:33934 "EHLO
	smtp3.noc.eunet-ag.at") by vger.kernel.org with ESMTP
	id S932482AbWDUVUo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Apr 2006 17:20:44 -0400
Received: from melchior.redchili.dyndns.org (redchili.dyndns.org [193.154.186.156])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP id 6D63034C8F
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 23:20:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 02D913DD3
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 23:22:58 +0200 (CEST)
Received: from melchior.redchili.dyndns.org ([127.0.0.1])
 by localhost (melchior.redchili.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30669-10 for <linux-ide@vger.kernel.org>;
 Fri, 21 Apr 2006 23:22:49 +0200 (CEST)
Received: from [192.168.1.89] (unknown [192.168.1.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 2E68D3DC9
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 23:22:49 +0200 (CEST)
In-Reply-To: <444888AE.8000706@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart1912496.UAJZAtcoLs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 21 April 2006 09:24, Albert Lee wrote:
> From the dmesg, PX-712SA looks like a PATA drive bridged to SATA.
> Could you try the atapi_dmadir=3D1 module parameter and check if it helps?
> (For older kernels, please #define ATAPI_ENABLE_DMADIR
> in include/linux/libata.h and recompile the kernel.)

Indeed the PX-712SA is a bridged PATA drive. In the POST message it's even=
=20
reported as PX-712A (the ATAPI model).
I've tried to pass libata.atapi_dmadir=3D1 to the kernel but looking at dme=
sg=20
nothing changed (using kernel 2.6.16). I even changed libata.h and defined=
=20
ATAPI_ENABLE_DMADIR - same result.

What else could I try?

Reinhard

--nextPart1912496.UAJZAtcoLs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBESUyekeAWQwM7gdsRAk67AJ42dOHu+rtAIiRJUtBEx+4GiwaR+ACfdscS
7tj8NaDyjKMV1vyIGfojdW0=
=sNeL
-----END PGP SIGNATURE-----

--nextPart1912496.UAJZAtcoLs--
