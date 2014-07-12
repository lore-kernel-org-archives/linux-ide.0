From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Sat, 12 Jul 2014 08:26:26 +0800
Message-ID: <20140712002626.GA314@pek-khao-d1.corp.ad.wrs.com>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
 <53BFD10D.3080005@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:53494 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbaGLA0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 20:26:34 -0400
Received: by mail-pd0-f169.google.com with SMTP id ft15so2195215pdb.14
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 17:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53BFD10D.3080005@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 03:57:01PM +0400, Sergei Shtylyov wrote:
> >-	for (i =3D 0; i < ATA_MAX_QUEUE; i++) {
> >-		tag =3D (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
> >+	for (i =3D 0, tag =3D ap->last_tag + 1; i < max_queue; i++, tag++) {
> >+		tag =3D tag < max_queue ? tag : 0;
>=20
>    Assigning 'tag' back to 'tag' is quite stupid, don't you think? Why no=
t:
>=20
> 		if (tag >=3D max_queue)
> 			tag =3D 0;

Since I am an idiot, it is very possible for me to write stupid code.
But I don't believe this is one. I don't think the above code is more reada=
ble.

Thanks,
Kevin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTwICyAAoJEJNY7TDerrFxKt4H/1HMSiJJCnBTsWBVTYqm/PiP
WTI5QRCq1Qy+ZbUV/bPm36rTrRkcTz4Nz/ATFp8pXbgoQ3DFr5PXuMIn2FGt4hg7
MYmrv6MHUM5ce4su+zjWlhYm6uVs+7KITrL/IxTULUInb4xNUnVbMyVmi8EKHVKJ
/UwRzf+3cwvcc0j5CsHV3dB06SEmWQAwwqlu5gpiDvAwiQOIc2m/2SByIWjznyX0
mGNghb0ksh304r4R1Mk8vjvaHh0OOY/Y8udGGjRa+Guzbd8DgIPDU3VWJRP5ZElL
HYONtiDv6X6wWd79MmY+a7AGu3KTbyP9UIhdplZ0N7Q/0HZchx3qbctRvuBNbK8=
=1kI3
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
