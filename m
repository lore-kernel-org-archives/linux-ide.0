From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: crash w/ bonnie++ on XFS on LVM VG w/5 PMP devices
Date: Wed, 17 Jan 2007 01:44:55 -0800
Message-ID: <20070117094455.GI23219@curie-int.orbis-terrarum.net>
References: <Pine.LNX.4.58.0701161933540.17363@mailx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 101.245.131.213.static.inetbone.net ([213.131.245.101]:49899
	"EHLO localhost" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932247AbXAQKNK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 05:13:10 -0500
Received: from curie.orbis-terrarum.net (unknown [24.81.201.182])
	by localhost (Postfix) with ESMTP id 583BED47DF7
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 10:44:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0701161933540.17363@mailx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-ide@vger.kernel.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2007 at 07:51:27PM +0000, Brad Fitzpatrick wrote:
> But it doesn't seem to have PMP in it.  I see the "pmp" head has it, but
> is there anything that's merged with upstream any more recently than
> 2006-10?
I produced a new version of the PMP patches against 2.6.20-rc2 a number
of weeks ago, and they should still apply reasonably well (they are in
my local GIT tree, and work). Here is a link to my original posting:

http://permalink.gmane.org/gmane.linux.ide/14714

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFrfAXPpIsIjIzwiwRAooPAJ9zRIgF6RJsF1kuSuS5gqV8wILOvgCfU3NK
RrONJZg/ibyNWKeCZRrSLKA=
=GcIm
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
