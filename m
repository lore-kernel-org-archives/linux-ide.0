From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 3/6] ide: small ide_register_port() cleanup
Date: Sun, 18 Jan 2009 02:23:18 +0100
Message-ID: <jeocy58l15.fsf@sykes.suse.de>
References: <200811122216.06257.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:38322 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685AbZARBXU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jan 2009 20:23:20 -0500
In-Reply-To: <200811122216.06257.bzolnier@gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Wed, 12 Nov 2008 22:16:06 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-probe.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> Index: b/drivers/ide/ide-probe.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -640,14 +640,9 @@ static int ide_register_port(ide_hwif_t=20
>  	/* register with global device tree */
>  	dev_set_name(&hwif->gendev, hwif->name);
>  	hwif->gendev.driver_data =3D hwif;
> -	if (hwif->gendev.parent =3D=3D NULL) {
> -		if (hwif->dev)
> -			hwif->gendev.parent =3D hwif->dev;
> -		else
> -			/* Would like to do =3D &device_legacy */
> -			hwif->gendev.parent =3D NULL;
> -	}
> +	hwif->gendev.parent =3D hwif->dev;

This breaks ide-pmac.  It overwrites the parent that
pmac_ide_macio_attach has set.

Signed-off-by: Andreas Schwab <schwab@suse.de>

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 312127e..0db1ed9 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -649,7 +649,8 @@ static int ide_register_port(ide_hwif_t *hwif)
 	/* register with global device tree */
 	dev_set_name(&hwif->gendev, hwif->name);
 	hwif->gendev.driver_data =3D hwif;
-	hwif->gendev.parent =3D hwif->dev;
+	if (hwif->gendev.parent =3D=3D NULL)
+		hwif->gendev.parent =3D hwif->dev;
 	hwif->gendev.release =3D hwif_release_dev;
=20
 	ret =3D device_register(&hwif->gendev);

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
