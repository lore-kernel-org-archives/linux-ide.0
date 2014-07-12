From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Sat, 12 Jul 2014 08:58:54 +0800
Message-ID: <20140712005854.GC314@pek-khao-d1.corp.ad.wrs.com>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
 <2816657.3zG0MhsyLF@amdc1032>
 <7212087.11uXbQ5PLC@amdc1032>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40100 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbaGLA7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 20:59:02 -0400
Received: by mail-pa0-f51.google.com with SMTP id hz1so2294074pad.10
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 17:59:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7212087.11uXbQ5PLC@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 06:33:46PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday, July 11, 2014 06:28:33 PM Bartlomiej Zolnierkiewicz wrote:
> > > +	max_queue =3D ap->scsi_host->can_queue;
> > > +	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);
> >=20
> > Why not handle this properly by just doing what ata_dev_config_ncq() do=
es and
> > using
> >=20
> > 	min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);
>=20
> actually this should be
>=20
> 	min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
>=20
> in this function
>=20
> > for obtaining max_queue?

Actually the ap->scsi_host->can_queue is the max queue supported by the
hardware. It should be a bug if it is greater than ATA_MAX_QUEUE. So we don=
't
need to use min() to get the max queue here. As pointed out by Tejun, it ma=
kes
no sense to do the sanity check for each qc requesting, so I will move the
WARN_ON_ONCE() to ata_host_register().

I have a pending patch to free the command tag reserved by the internal
command. In that patch the above code in ata_dev_config_ncq() will change
to:

  hdepth =3D ap->scsi_host->can_queue;

Thanks,
Kevin

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTwIhOAAoJEJNY7TDerrFx0UkIAK9Mgmjbe/23dnDzoeYfmKoc
s87UY8dMsEZEn059frykLAuDYPreavZIhiTyfvqvSZEYDdpeV/oV4q7fpCYh24gL
g90+cZfRm6vH6jm9bZ9Ni1DfzfhZ/Gc5O5wnejRY9sGZ5F5zlWPC29vHgjZcY2z+
KaOaj6jWyt36BmH67Q1Y3OrB23eVH88uoXOhAvY0NKiYiAubwCPUXbiZwM9sU2jf
UOztBtvu8ZKC3tR3ipGynZj/ftmS5vL0mtb2/LEFXMpNXgYLsgEW0wopxgWZHiiY
MfSHeDV4tx/IHKOVDz9U7OwkSU2bRDtvn/Xm9tKdRYJcI2f45WHt4/suynRL4S4=
=RY/J
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
