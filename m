From: Igor Serebryany <igor47@moomers.org>
Subject: Re: disappearing block devices using EFI Partitioning
Date: Wed, 14 Oct 2009 19:47:36 -0500
Message-ID: <20091015004736.GP25852@moomers.org>
References: <20091014112418.GJ25852@moomers.org> <20091014151055.GA28792@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xeli5fugN0prYRGq"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moomers.org ([64.251.27.79]:42071 "EHLO moomers.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762211AbZJOAre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2009 20:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20091014151055.GA28792@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--xeli5fugN0prYRGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2009 at 11:10:55AM -0400, Jim Paris wrote:
> Does the partition still show up in /proc/partitions?  If so this may
> be a udev bug.=20
Right you are! The partition remains in /proc/partitions and getting
udev to freshen up brings back the missing devices. The udev version in
the latest Buildroot is too old for bug reports but now I have a
workaround - thanks!

--Igor

--xeli5fugN0prYRGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFK1nEoVyVcp2k8D/kRAmsPAJwLBf/gyKfZAPeKga6p4FHAy4dnIQCffXWL
JWnSEUUnQk5vLLudaiGqrVM=
=6KW7
-----END PGP SIGNATURE-----

--xeli5fugN0prYRGq--
