From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Sun, 6 Jul 2014 12:16:38 +0800
Message-ID: <20140706041638.GA7698@pek-khao-d1.corp.ad.wrs.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703134717.GA16191@htj.dyndns.org>
 <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
 <20140704153022.GA764@mtj.dyndns.org>
 <20140705132134.GA15232@pek-khao-d1.corp.ad.wrs.com>
 <20140705200055.GB3069@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44269 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaGFEQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2014 00:16:47 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so3611298pdj.19
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 21:16:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140705200055.GB3069@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2014 at 04:00:55PM -0400, Tejun Heo wrote:
> If we switch to using a qcflag for marking internal commands, it
> probably would be better to guarantee that EH commands always use tag
> 0.

Do you mean we add a WARN_ON_ONCE() to check the tag in ata_tag_internal()?

> > +	ATA_QCFLAG_INTERNAL	=3D (1 << 19), /* Internal command */
>=20
> Let's make it more explicit - ATA_QCFLAG_EH.

Sure.

>=20
> > +static inline unsigned int ata_tag_internal(struct ata_queued_cmd *qc)
> > +{
> > +	return (qc->flags & ATA_QCFLAG_INTERNAL);
> > +}
>=20
> As we're changing the interface anyway, ata_qc_eh()?

Sounds good, will change.

> So, yeah, I like the proposed changes.  This is a bit too much as a
> fix for fsl tho.  First fix fsl and then update so that we use the
> qcflag in the devel branch?

OK, will do.

Thanks,
Kevin

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTuM2mAAoJEJNY7TDerrFxo0QH/AqmWvKqpCoOpKhd/oCU+VkY
hbs/39fdZTLSWBDaxSpyeXKrZlX+crs3JLIOaOi/a+WTCf1f6FqWIfHIpZc2xfPB
vbckXm7nVTimptMvZW6yd0XLtSoLy+XjKgohyW2HWCO/VX4g3xmXSS6XybruHYTH
KWxYr+4dzZuo3YoYRLueK8IhiiA5eP2QbZ3+bclhhMsZH2I6ng0bGZJT/oMZac6c
C6RMf/bOtkcD5zwmZZMcC/OxooO2yC9LCf9c5OlnydbMRVOe23J4WwAxteDOGeoU
zyoYfXw/qytw9HYajnVhjvDPOp3soSVUpC+lODyiGqyBqkpctFg8CXBRfVLP3tQ=
=B+ve
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
