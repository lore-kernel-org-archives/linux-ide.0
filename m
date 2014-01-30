From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Thu, 30 Jan 2014 19:12:28 -0300
Message-ID: <20140130221228.GB1063@localhost>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38938 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752945AbaA3WMV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2014 17:12:21 -0500
Content-Disposition: inline
In-Reply-To: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Thu, Jan 30, 2014 at 09:50:35PM +0100, Andrew Lunn wrote:
> Armada 370 and XP do not have a SATA phy driver.  The generic phy
> layer does not cleanly support optional phys. It is not possible to
> determine from the error code if there is expected to be a phy
> according to DT, but it cannot be found, or no phy is listed in
> DT. All that can be determined is that a phy is expected, but the
> driver has not been loaded yet, in which case -EPROBE_DEFER is
> returned. Thus for 370 and XP the driver failed to probe.  Play safe,
> consider all errors except -EPROBE_DEFER to be none fatal and keep
> going, and in the case of -EPROBE_DEFER exit the probe function with
> that error code.
>=20
> Tested on Kirkwood with a sata phy driver and on 370 without a sata
> phy driver.
>=20
> Reported-by: Jean Pihet <jean.pihet@linaro.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
> ---
>  drivers/ata/sata_mv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index eaa21eddbe70..148ff5a82c8b 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4115,9 +4115,8 @@ static int mv_platform_probe(struct platform_de=
vice *pdev)
>  		if (IS_ERR(hpriv->port_phys[port])) {
>  			rc =3D PTR_ERR(hpriv->port_phys[port]);
>  			hpriv->port_phys[port] =3D NULL;
> -			if ((rc !=3D -EPROBE_DEFER) && (rc !=3D -ENODEV))
> -				dev_warn(&pdev->dev, "error getting phy");
> -			goto err;
> +			if (rc =3D=3D -EPROBE_DEFER)
> +				goto err;

It feels a bit fishy to check for a specific errno.

How about not considering the lack of phy an error in all cases? In
other words, remove the check completely.

Isn't the phy used only for power saving purposes? Or do we want this
for another purpose?

Or as a different solution, can't we check for the compatible-string
and only try to get a phy for orion-sata?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
