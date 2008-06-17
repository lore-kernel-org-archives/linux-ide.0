From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] ide-pmac: add ->init_dev method (take 2)
Date: Tue, 17 Jun 2008 10:45:46 +1000
Message-ID: <20080617104546.3b4535c9.sfr@canb.auug.org.au>
References: <200806162124.48029.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Jun_2008_10_45_46_+1000_mEKqAjB4sr8s1P3S"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:47233 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbYFQAp6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 20:45:58 -0400
In-Reply-To: <200806162124.48029.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

--Signature=_Tue__17_Jun_2008_10_45_46_+1000_mEKqAjB4sr8s1P3S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Mon, 16 Jun 2008 21:24:47 +0200 Bartlomiej Zolnierkiewicz <bzolnier@gmai=
l.com> wrote:
>
> +static void pmac_ide_init_dev(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif =3D drive->hwif;
> +	pmac_ide_hwif_t *pmif =3D
> +		(pmac_ide_hwif_t *)dev_get_drvdata(hwif->gendev.parent);
> +
> +	if (pmif->mediabay) {
> +#ifdef CONFIG_PMAC_MEDIABAY
> +		if (check_media_bay(np->parent, MB_CD) =3D=3D -ENODEV)
                                    ^^
"np" doesn't exist here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__17_Jun_2008_10_45_46_+1000_mEKqAjB4sr8s1P3S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhXCToACgkQTgG2atn1QN/l+wCfSiOoVrIZSyAWkFDJmFUOT2oV
VgwAn0SPKJimmSieWWvfornqd2sVq5SK
=77XE
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Jun_2008_10_45_46_+1000_mEKqAjB4sr8s1P3S--
