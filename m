From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Fri, 4 Jul 2014 14:50:02 +0800
Message-ID: <20140704065002.GB15828@pek-khao-d1.corp.ad.wrs.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703135058.GB16191@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54429 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaGDGuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2014 02:50:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so1494333pdb.21
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 23:50:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140703135058.GB16191@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 09:50:58AM -0400, Tejun Heo wrote:
> On Thu, Jul 03, 2014 at 08:09:41PM +0800, Kevin Hao wrote:
> > The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> > ("libata/ahci: accommodate tag ordered controllers"). The reason is
> > that the ata controller on this SoC only implement a queue depth of
> > 16. When issuing the commands in tag order, all the commands in tag
> > 16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
>=20
> Shouldn't the function at least trigger WARN_ON_ONCE() if it's forcing
> the tag to be 0 when it shouldn't be?  Silently mapping things to zero
> doesn't look like a particularly good idea.

Indeed. I will add a WARN_ON_ONCE() in the fsl sata driver.

Thanks,
Kevin

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTtk6aAAoJEJNY7TDerrFxznsIAJ94c/OPxUep5M0XC3TaCqPg
0bfI8d7U/ixdArv2U6GxNrycAJWGiOeLse2xp/Wyali/xRyZ245YNAGOQpdq0cDT
YKUQeMcKKZJEHHmue+ICAox3GXR72gRSpeMAgB06qASkQ22JNpBgFkbFOC9Aiv0S
mtyWPyMWWeBfgruT+n+lTF6Th/nqDIy/+C6ug4W8mjdQsMYa/ItNa3orkHAGzYad
/Tlwf9OR3+DdhgyIVQ6hJJ1bS3Q6FeAfEQzI7yGpWdhWHT/73a8zX+fhdGjdS+aB
5/1d7waoC4P8hTPNKL1f32PJsMzlRK+1BY4bUwHZZtSkvGLivQES3AAD9ao6vYI=
=wPF2
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
