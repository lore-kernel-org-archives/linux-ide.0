From: Reinhard =?iso-8859-1?q?Brandst=E4dter?=
	<r.brandstaedter@eunet.at>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Thu, 10 Aug 2006 08:46:57 +0200
Message-ID: <200608100847.00837.r.brandstaedter@eunet.at>
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <4469C024.3030506@gmail.com> <4469CC22.1010500@tw.ibm.com>
Reply-To: r.brandstaedter@gmx.at
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1283708.zeDCyhDU1V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:51140 "EHLO
	smtp1.noc.eunet-ag.at") by vger.kernel.org with ESMTP
	id S1161097AbWHJGrE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 02:47:04 -0400
Received: from melchior.redchili.dyndns.org (redchili.dyndns.org [193.154.186.156])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP id 5786C34394
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 08:47:02 +0200 (CEST)
Received: from [192.168.1.20] (unknown [192.168.1.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id EF1532E7EE
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 08:41:33 +0200 (CEST)
In-Reply-To: <4469CC22.1010500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart1283708.zeDCyhDU1V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 16 May 2006 14:57, Albert Lee wrote:

> Reinhard has a Plextor PX-712SA + svia.
> Maybe he can also help to check whether the patch fixes the problem on his
> box.

What I finally ended up with was solving the problem on the hardware side:

The Plextor PX-712SA is a normal ATA device wich a IDE:SATA adapter plugged=
 in=20
at the back. I openend the DVDR Device (2 srews at the back) repoved the=20
adapter (1 screw) and then u get the normal IDE Interface (with master/slav=
e=20
jumpers, audio interface and normal ower plug). You can use this device on =
an=20
normal IDE interface then. Works perfect for me, maybe the 716SA Drive is=20
similar
This was the only solution that fixed the problem for me, any submitted ker=
nel=20
patches didn't work.


Reinhard

=2D-=20
Dipl.-Ing. Reinhard Brandstaedter
Wiener Str. 28                  phone: 0043 650 2419541
4020 Linz                       icq:   73059068
Austria                         skype: redchili78




--nextPart1283708.zeDCyhDU1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBE2tZkkeAWQwM7gdsRAp6RAJwLAgYBzo37xhCQFHSxSxiMd+RZsQCaAxxR
Pnnxlqy4RGJ0UeCZKV/ZI2w=
=Fcsq
-----END PGP SIGNATURE-----

--nextPart1283708.zeDCyhDU1V--
