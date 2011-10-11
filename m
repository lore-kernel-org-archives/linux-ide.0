From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] mv_sas: OCZ RevoDrive3 & zDrive R4 support
Date: Tue, 11 Oct 2011 20:50:12 +0000
Message-ID: <robbat2-20111011T204841-021218330Z@orbis-terrarum.net>
References: <1318032026-21913-1-git-send-email-robbat2@gentoo.org>
 <1318132024-12426-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60272 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab1JKUuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Oct 2011 16:50:13 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 234D61B400B
	for <linux-ide@vger.kernel.org>; Tue, 11 Oct 2011 20:50:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1318132024-12426-1-git-send-email-robbat2@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: "Robin H. Johnson" <robbat2@gentoo.org>


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2011 at 08:47:04PM -0700, Robin H. Johnson wrote:
> From: "Robin H. Johnson" <robbat2@gentoo.org>
>=20
> In the OCZ RevoDrive3/zDrive R4 series, the "OCZ SuperScale Storage
> Controller" with "Virtualized Controller Architecture 2.0" really seems
> to be a Marvell 88SE9485 part, with OCZ firmware/BIOS.
>=20
> Developed and tested on OCZ RevoDrive3 120GB [PCI 1b85:1021]

Is there anything blocking getting this ack'd or applied to the SCSI
tree? I've seen no comments from the lists.

I've also posted it on the OCZ Forums, and gotten some users confirming
it works there.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk6UrAQACgkQPpIsIjIzwix19gCgiMjfeMhb/pnFU48ngTB5qmJR
Ct8AnRKtO1+qHKTPZJJYKaIbwXGOlfqM
=Gmfs
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
