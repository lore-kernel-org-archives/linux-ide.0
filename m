From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_it821x: sync with IDE it821x driver
Date: Sat, 09 Jun 2007 14:58:20 +0900
Message-ID: <466A417C.5090901@gmail.com>
References: <200706090223.20933.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:9857 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbXFIF7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 01:59:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1333624wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 22:59:27 -0700 (PDT)
In-Reply-To: <200706090223.20933.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
> * (partially) fix DMA in RAID mode
>=20
>   Code intended to check DMA status was checking DMA command register=
=2E
>   Moreover firmware seems to "forget" to set DMA capable bit for the
>   slave device (at least in RAID mode but without ITE RAID volumes) s=
o
>   check device ID for DMA capable bit when deciding whether to use DM=
A
>   and remove DMA status check completely.
>=20
>   Thanks to Pavol =A9imo for the bugreport and testing the initial fi=
x.

Ah... This is the mysterious mwdma configuration in smart mode, right?
Thanks for fixing this.

>   This change unfortunately still doesn't fix DMA in RAID mode (which
>   works fine with IDE it821x) but Alan is working on the missing piec=
es
>   (pata_it821x vs libata EH issues).

This is the lbal/nsect SRST problem, right?

> @@ -258,8 +259,14 @@ static void it821x_passthru_set_piomode(
>  	static const u8 pio_want[]    =3D { ATA_66, ATA_66, ATA_66, ATA_66,=
 ATA_ANY };
> =20
>  	struct it821x_dev *itdev =3D ap->private_data;
> +	struct ata_device *pair =3D ata_dev_pair(adev);
>  	int unit =3D adev->devno;
> -	int mode_wanted =3D adev->pio_mode - XFER_PIO_0;
> +	int mode_wanted =3D adev->pio_mode;
> +
> +	if (pair && adev->pio_mode > pair->pio_mode)
> +		mode_wanted =3D pair->pio_mode;
> +
> +	mode_wanted -=3D XFER_PIO_0;

I think this is better done by mode_filter callback which is guaranteed
to be called before any actual mode configuration is performed and in
device order (master then slave).

Thanks.

--=20
tejun
