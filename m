From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Sat, 12 Jul 2014 08:27:42 +0800
Message-ID: <20140712002742.GB314@pek-khao-d1.corp.ad.wrs.com>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
 <20140711145105.GC27706@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47343 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaGLA1u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 20:27:50 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so2316454pad.0
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 17:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140711145105.GC27706@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 10:51:05AM -0400, Tejun Heo wrote:
> On Fri, Jul 11, 2014 at 02:10:26PM +0800, Kevin Hao wrote:
> >  static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
> >  {
> >  	struct ata_queued_cmd *qc =3D NULL;
> > -	unsigned int i, tag;
> > +	unsigned int i, tag, max_queue;
> > +
> > +	max_queue =3D ap->scsi_host->can_queue;
> > +	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);
>=20
> Let's move the WARN_ON_ONCE() to ata_host_register().  Also, let's
> please update the function comment explaining why we're allocating
> tags the way we do.

OK, will do.

Thanks,
Kevin

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTwID+AAoJEJNY7TDerrFxSb0H/A0oTi6qYcL9qBSqPL/FvKlX
xoiZy180NpVDohr01Y4Wa0FIef7z2LfJM9hz6fuYiLcWX3z4t286D8PgNNk1FGMl
pyiVjn8kIHms6Q4pHq9qrHU08I0MwaNehz9+mmEMsLNq9iOvrdHVB9u9jBDkH8ck
TELsB1wj9WhPXC/T+ZYwM16j8Pw71nxc2kQt/eBnIzNH5moc56TvHDWEAOelkPNH
k1Zq67PonYJ+LM7GDZ5Fmyt7HYNhydZO5neJlDiZQw6IS7CqJLZMk0hEe7muaeu+
Q2xk530Vw3nDNdYx3xFfHtUuoud9Gkof7Xg9GGwGuvQn1cIdPObxgwSBPjAJwSc=
=pn8+
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
