From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 0/3] hotplug polling, respin
Date: Wed, 25 Apr 2007 00:58:37 -0700
Message-ID: <20070425075837.GH7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <462EFE59.2090501@gmail.com> <20070425073037.GF7846@curie-int.orbis-terrarum.net> <462F04BD.3040706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:59004 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161838AbXDYH6N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:58:13 -0400
Content-Disposition: inline
In-Reply-To: <462F04BD.3040706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2007 at 04:35:25PM +0900, Tejun Heo wrote:
> > I'm not sure I follow you here. The only bit of 'userspace' interface I
> > see in this series is hotplug_polling_interval. What other userspace
> > bits are in question?
> What got NACKed is the lack of per-port interface.  More specifically,
> stretching the usage of module parameter too far.
One thing I'd be concerned with in implementing that as a sysfs
attribute right now, is that it's probably going to change location once
the ata_link abstraction comes in.

I'll think about it more tomorrow, when I move on to the ata_link
portion of these patches.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLwotPpIsIjIzwiwRAq6uAJ43gYJP+SytAihKwEOwmn7Urlk8QACffJhE
IW0/yuayeT6UhAsKg53ExfU=
=kYxa
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
