From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Thu, 10 Aug 2006 15:37:18 +0800
Message-ID: <44DAE22E.3050909@tw.ibm.com>
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <4469C024.3030506@gmail.com> <4469CC22.1010500@tw.ibm.com> <200608100847.00837.r.brandstaedter@eunet.at>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:51595 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751446AbWHJHh0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 03:37:26 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7A7bOqo009614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 03:37:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k7A7bNLI071492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:37:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7A7bNo5006625
	for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:37:23 -0600
In-Reply-To: <200608100847.00837.r.brandstaedter@eunet.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r.brandstaedter@gmx.at
Cc: linux-ide@vger.kernel.org

Reinhard Brandst=E4dter wrote:
> On Tuesday 16 May 2006 14:57, Albert Lee wrote:
>=20
>=20
>>Reinhard has a Plextor PX-712SA + svia.
>>Maybe he can also help to check whether the patch fixes the problem o=
n his
>>box.
>=20
>=20
> What I finally ended up with was solving the problem on the hardware =
side:
>=20
> The Plextor PX-712SA is a normal ATA device wich a IDE:SATA adapter p=
lugged in=20
> at the back. I openend the DVDR Device (2 srews at the back) repoved =
the=20
> adapter (1 screw) and then u get the normal IDE Interface (with maste=
r/slave=20
> jumpers, audio interface and normal ower plug). You can use this devi=
ce on an=20
> normal IDE interface then. Works perfect for me, maybe the 716SA Driv=
e is=20
> similar
> This was the only solution that fixed the problem for me, any submitt=
ed kernel=20
> patches didn't work.
>=20

I'm curious what's the PATA-to-SATA bridge chip used on the Plextor PX-=
712SA.
(Maybe it is not compatible with the VIA chip.)
Could you please check the IC on the IDE-SATA adapter?

--
albert


