From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it821x: (partially) fix DMA in RAID mode
Date: Mon, 11 Jun 2007 11:37:26 +0200
Message-ID: <200706111137.26343.bzolnier@gmail.com>
References: <200706101843.20947.bzolnier@gmail.com> <466CD502.6010201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2845 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbXFKJ0L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 05:26:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1428031ugf
        for <linux-ide@vger.kernel.org>; Mon, 11 Jun 2007 02:26:09 -0700 (PDT)
In-Reply-To: <466CD502.6010201@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>

On Monday 11 June 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Code intended to check DMA status was checking DMA command register=
=2E
> >=20
> > Moreover firmware seems to "forget" to set DMA capable bit for the
> > slave device (at least in RAID mode but without ITE RAID volumes) s=
o
> > check device ID for DMA capable bit when deciding whether to use DM=
A
> > and remove DMA status check completely.
> >=20
> > Thanks to Pavol =A9imo for the bugreport and testing the initial fi=
x.
> >=20
> > This change unfortunately still doesn't fix DMA in RAID mode (which
> > works fine with IDE it821x) but Alan is working on the missing piec=
es
> > (pata_it821x vs libata EH issues).
> >=20
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Cc: Tejun Heo <htejun@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >=20
> >  drivers/ata/pata_it821x.c |   11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> Patch is OK but it's mangled by your mailer:
>=20
> @@ -79,7 +80,7 @@
> =3D20
> =3D20
>   #define DRV_NAME "pata_it821x"
> =3D2D#define DRV_VERSION "0.3.6"
> +#define DRV_VERSION "0.3.7"
> =3D20
>   struct it821x_dev
>   {
> @@ -460,14 +461,8 @@ static unsigned int it821x_passthru_qc_i
> =3D20
>=20
> =3D2D     int dma_enabled =3D3D 0;
>          int i;
> =3D20
>=20
> etc.

Ah, non-ASCII char confused the mailer... resend.  Sorry for that.
