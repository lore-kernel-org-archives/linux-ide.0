From: Martin Braure de Calignon <braurede@free.fr>
Subject: Re: Data corruption when using INIC-1623TA2 controller
Date: Mon, 01 Jul 2013 10:52:22 +0200
Message-ID: <1372668742.17064.23.camel@phoenix>
References: <20130627160606.3447.9939.reportbug@storm.xmen.local>
	 <20130627165114.GK4752@decadent.org.uk> <1372353297.24346.4.camel@phoenix>
	 <20130627173142.GM4752@decadent.org.uk> <1372375714.330.17.camel@phoenix>
	 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
	 <1372427725.23094.17.camel@phoenix>
	 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
	 <20130701061726.GA10717@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hZKE8/W9Q8YGEXMkEODx"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:58840 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868Ab3GAIwp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jul 2013 04:52:45 -0400
In-Reply-To: <20130701061726.GA10717@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, 714295@bugs.debian.org, linux-ide@vger.kernel.org


--=-hZKE8/W9Q8YGEXMkEODx
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun., 2013-06-30 at 23:17 -0700, Tejun Heo wrote:
> Unfortunately, I don't have any idea.  That driver never really
> matured enough.  I couldn't find enough information and no one from
> initio responded, so....

Thank you Tejun and Ben,

that's totally suxx. I'm gonna try to contact them too, but I doubt it's
gonna change anything :(
I was hopping that we could turn on some logging so that we understand,
at least, what is happening (even if we can't solve it), and I could
then have made some tests by modifying code, recompiling module, ...
If the driver could cause data loss, shouldn't it be flagged as
experimental?
In the meantime, I'm probably going to purchase a new SATA card :(

Thanks again guys for your hard work! I really appreciate!

Martin

--=20
Martin Braure de Calignon

--=-hZKE8/W9Q8YGEXMkEODx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlHRQ0cACgkQcHEx8cor215nUgCdGm4WvTlTiVJU3WlELk4ph49m
3/MAoI4Wd9VEkQuNVbN3oVTs9y20/2CG
=9jGf
-----END PGP SIGNATURE-----

--=-hZKE8/W9Q8YGEXMkEODx--

