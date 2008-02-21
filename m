From: Malte =?UTF-8?B?U2NocsO2ZGVy?= <maltesch@gmx.de>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot
 (resend)
Date: Thu, 21 Feb 2008 17:27:57 +0100
Message-ID: <20080221172757.44882428@highlander.home.lan>
References: <20080214184700.0bd3837d@highlander.home.lan>
	<47B4D02E.9030101@gmail.com>
	<20080215191215.430ee2e0@highlander.home.lan>
	<47BCE71F.2000309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sCmcgy7SG1pqlw5grO02jJ_";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34907 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762579AbYBUQ2F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 11:28:05 -0500
In-Reply-To: <47BCE71F.2000309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--Sig_/sCmcgy7SG1pqlw5grO02jJ_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Feb 2008 11:51:11 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Malte Schr=C3=B6der wrote:
> >> Does irqpoll kernel parameter help?
> > =20
> > No, problem stays.
>=20
> Can you capture full boot log w/ irqpoll specified?  If you have root
> filesystem connected to ahci, you'll probably have to use serial or
> netconsole.  Also, please post full boot log from 2.6.23.11.
>=20
> Thanks.
>=20

I "solved" the problem by updating the BIOS. It now works perfectly. I
thought I had mailed that .. maybe I forgot.

--=20
---------------------------------------
Malte Schr=C3=B6der
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--Sig_/sCmcgy7SG1pqlw5grO02jJ_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHvaaS4q3E2oMjYtURAu8cAKDcjTKIG9lh1FTnVN+Gd1EC51l7fgCg2+Su
UtlwT0aSbtE8SVF4Fj9JmLA=
=mmtA
-----END PGP SIGNATURE-----

--Sig_/sCmcgy7SG1pqlw5grO02jJ_--
