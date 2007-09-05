From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 5 Sep 2007 14:30:06 -0700
Message-ID: <20070905213006.GH22695@curie-int.orbis-terrarum.net>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz> <46DC030E.9070704@gmail.com> <46DCB709.902@vc.cvut.cz> <46DE9C20.9030007@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:39061 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755689AbXIEVaB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:30:01 -0400
Content-Disposition: inline
In-Reply-To: <46DE9C20.9030007@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Richard Scobie <richard@sauce.co.nz>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 05:08:00AM -0700, Petr Vandrovec wrote:
> > 3124-2 (norco 4618):
> > NCQ:
> > 1TB alone:   82.30, 82.43
> > 1TB+1TB:     68.36+68.25
> > noNCQ:
> > 1TB alone:   82.39, 82.29
> > 1TB+1TB:     70.33+70.32, 69.47+70.01
> > Unfortunately that enclosure has only two slots used.  I'll try to not=
=20
> > forget bring two more disks tomorrow to get it fully populated.
>  In case you are still follwing this thread, 3124-2 with 4 1TB drives=20
>  delivers 58.5MBps for each drive with NCQ enabled, and 60MBps with NCQ=
=20
>  disabled - total 235-240MBps read speed.  I would like to see 320MBps, b=
ut=20
>  apparently today is not my lucky day...
Just to confirm, how were you testing the multiple drive combination?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFG3x/ePpIsIjIzwiwRAvz6AJ44EqvI6CMRwU2ZyVrosLqr3Pw91QCeMI4a
QKxOoiNUeroUYumDmeFuWok=
=0ypZ
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
