From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Sat, 1 Feb 2014 11:44:58 -0300
Message-ID: <20140201144457.GA20358@localhost>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46787 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932991AbaBAOor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Feb 2014 09:44:47 -0500
Content-Disposition: inline
In-Reply-To: <1391264157-2112-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: tj@kernel.org, kishon@ti.com, linux-ide@vger.kernel.org

On Sat, Feb 01, 2014 at 03:15:57PM +0100, Andrew Lunn wrote:
> Make use of devm_phy_optional() in order to fix probe failures on
> Armada 370, XP and others, when there is no phy driver available.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/ata/sata_mv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index eaa21eddbe70..26021cf077a8 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4111,12 +4111,14 @@ static int mv_platform_probe(struct platform_=
device *pdev)
>  			clk_prepare_enable(hpriv->port_clks[port]);
> =20
>  		sprintf(port_number, "port%d", port);
> -		hpriv->port_phys[port] =3D devm_phy_get(&pdev->dev, port_number);
> +		hpriv->port_phys[port] =3D devm_phy_optional_get(&pdev->dev,
> +							       port_number);
>  		if (IS_ERR(hpriv->port_phys[port])) {
>  			rc =3D PTR_ERR(hpriv->port_phys[port]);
>  			hpriv->port_phys[port] =3D NULL;
> -			if ((rc !=3D -EPROBE_DEFER) && (rc !=3D -ENODEV))
> -				dev_warn(&pdev->dev, "error getting phy");
> +			if (rc !=3D -EPROBE_DEFER)
> +				dev_warn(&pdev->dev, "error getting phy %d",
> +					rc);
>  			goto err;

IMHO, this new series look much better. However, I still think the abov=
e code
is highly confusing (took me some time to see why you don't print the w=
arning
on PROBE_DEFER, but do the goto in all cases).

Would it be too much to ask to add some comments to it? Your previous
explanation about why we need to fail on EPROBE_DEFER, to allow the phy
driver to load, was great. Adding some of that here would be nice.

I'll test this next week.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
