From: Reinhard =?iso-8859-1?q?Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: sata_via and SATA DVD drive (PX-712SA)
Date: Sat, 29 Apr 2006 12:50:56 +0200
Message-ID: <200604291250.59275.r.brandstaedter@gmx.at>
References: <200604202020.22010.r.brandstaedter@gmx.at> <200604212320.30854.r.brandstaedter@gmx.at> <444C9EED.3000306@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7264559.UjloWlYBTv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:34732 "EHLO
	smtp1.noc.eunet-ag.at") by vger.kernel.org with ESMTP
	id S1750944AbWEAJR5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 May 2006 05:17:57 -0400
Received: from melchior.redchili.dyndns.org (redchili.dyndns.org [193.154.186.156])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP id 85F3334D2D
	for <linux-ide@vger.kernel.org>; Mon,  1 May 2006 11:17:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 1C96E3E15
	for <linux-ide@vger.kernel.org>; Mon,  1 May 2006 11:20:19 +0200 (CEST)
Received: from melchior.redchili.dyndns.org ([127.0.0.1])
 by localhost (melchior.redchili.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03536-08-3 for <linux-ide@vger.kernel.org>;
 Mon,  1 May 2006 11:20:09 +0200 (CEST)
Received: from [192.168.1.89] (unknown [192.168.1.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 487FF3DA2
	for <linux-ide@vger.kernel.org>; Mon,  1 May 2006 11:20:09 +0200 (CEST)
In-Reply-To: <444C9EED.3000306@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com

--nextPart7264559.UjloWlYBTv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 April 2006 11:48, Albert Lee wrote:

> Maybe updating the firmware of PX-712SA can help?
> Otherwise, please try the attached patch to blacklist
> PX-712SX DMA for sata_via.

Interesting. After applying this patch on the FIRST boot of the patched ker=
nle=20
I saw a CONSIDER_BLIST_36 (or similar - didn't get a dmesg output to file)=
=20
when scanning for the drive. On the following boots of the kernel I get=20
nothing but the same behavior as with the unpatched kernel.

Reinhard



--nextPart7264559.UjloWlYBTv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEU0UTkeAWQwM7gdsRAhe6AJ9AlkH+XrTCTPsnWRn59Plg7VXwZQCeN2+r
W3xI/iuTPH2CV0k/GJP9fBM=
=LtgU
-----END PGP SIGNATURE-----

--nextPart7264559.UjloWlYBTv--
