From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Date: Mon, 18 Sep 2006 21:49:13 -0700
Message-ID: <20060919044913.GD569@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <20060918034826.GA10116@curie-int.orbis-terrarum.net> <450E13D4.10200@gmail.com> <450F69C3.8060603@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:46495 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1752039AbWISELm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 00:11:42 -0400
Content-Disposition: inline
In-Reply-To: <450F69C3.8060603@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2006 at 11:53:39PM -0400, Jeff Garzik wrote:
> We can't really know which controllers have a non-linear port mapping,=20
> because that is dependent on both the silicon and whether or not the=20
> chip is connected to port X[0-31].  The BIOS knows this, of course :)
I noticed that in my case, when the wrong ioports were probed (base +
port_idx*offset) for port_idx being 2/3 - all of the return values were
zero, instead of the expected values.

You could probably use this to detect cases where PI claims a port is
not present, but it really is.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFD3bJPpIsIjIzwiwRAkG8AKC5T6rNZJXnVf6asL188fPmq8/WxgCfVTZ1
7GRmlAcnffO49QBBdgwTNJk=
=u5n6
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
