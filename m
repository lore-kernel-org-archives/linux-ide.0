From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata: ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 11:40:20 -0400
Message-ID: <10124.1305906020@localhost>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost> <BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com> <201105182144.37713.rjw@sisk.pl> <BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
            <BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1305906020_2669P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:59260 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab1ETPlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 11:41:20 -0400
In-Reply-To: Your message of "Wed, 18 May 2011 17:14:56 PDT."
             <BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Michael Leun <lkml20100708@newton.leun.net>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

--==_Exmh_1305906020_2669P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 May 2011 17:14:56 PDT, Jian Peng said:

> > @@ -1353,6 +1332,8 @@
> >
> >
> >   ahci_start_engine(ap);
> >
> > + msleep(5);
> > +
> >   if (online)
> >
> >    *class = ahci_dev_classify(ap);
> >

It may very well be that adding a magic msleep(5) here just Makes It Work, but
I have a gut feeling that it's in the wrong place (for starters, 'online' can't change
during the msleep() unless somebody *else* sets it - in which case the locking
is screwed up as we're not forcing a re-read of the value).  The msleep() probably
needs to be before something else further down in the code (but I have no idea
exactly what).

--==_Exmh_1305906020_2669P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFN1otkcC3lWbTT17ARAkbWAKCcDK9WjpHXKaCoOJFCpWMpU1POgQCfZPkw
A7iqndZ6E+a9fXTQ8HEUA4E=
=1r68
-----END PGP SIGNATURE-----

--==_Exmh_1305906020_2669P--

