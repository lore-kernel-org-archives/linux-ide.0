From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
Date: Tue, 04 Mar 2014 13:04:11 +0100
Message-ID: <24474993.UYuAZ7PBV1@amdc1032>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-9-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDMLN5HOIYIM3AWXTACRUBHFICYYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-reply-to: <1393084424-31099-9-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Saturday, February 22, 2014 04:53:37 PM Hans de Goede wrote:
> This avoids the ugliness of creating a nested platform device from probe.
>=20
> While moving it around anyways, move the mk6q phy init code from probe
> to imx_sata_enable, as the phy needs to be re-initialized on resume too,
> otherwise the drive won't be recognized after resume.
>=20
> Tested on a wandboard i.mx6 quad.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |   9 +-
>  drivers/ata/ahci_imx.c                             | 331 ++++++++-------=
------
>  2 files changed, 134 insertions(+), 206 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Do=
cumentation/devicetree/bindings/ata/ahci-platform.txt
> index 499bfed..d86e854 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -5,8 +5,9 @@ Each SATA controller should have its own node.
> =20
>  Required properties:
>  - compatible        : compatible list, one of "snps,spear-ahci",
> -                      "snps,exynos5440-ahci", "ibm,476gtr-ahci", or
> -                      "allwinner,sun4i-a10-ahci"
> +                      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
> +                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci" or
> +                      "fsl,imx6q-ahci"
>  - interrupts        : <interrupt mapping for SATA IRQ>
>  - reg               : <registers mapping>
> =20
> @@ -15,6 +16,10 @@ Optional properties:
>  - clocks            : a list of phandle + clock specifier pairs
>  - target-supply     : regulator for SATA target power
> =20
> +"fsl,imx53-ahci", "fsl,imx6q-ahci" required properties:
> +- clocks            : must contain the sata, sata_ref and ahb clocks
> +- clock-names       : must contain "ahb" for the ahb clock
> +
>  Examples:
>          sata@ffe08000 {
>  		compatible =3D "snps,spear-ahci";
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index dd4d6f7..3cb5d69 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c

[...]

> +static void ahci_imx_host_stop(struct ata_host *host)
> +{
> +	struct ahci_host_priv *hpriv =3D host->private_data;
> =20
> -	ret =3D platform_device_add_resources(ahci_pdev, res, 2);
> -	if (ret)
> -		goto err_out;
> +	imx_sata_disable(hpriv);
> +}
> =20
> -	ret =3D platform_device_add_data(ahci_pdev, pdata, sizeof(*pdata));
> -	if (ret)
> -		goto err_out;
> +static int imx_ahci_suspend(struct device *dev)
> +{
> +	struct ata_host *host =3D dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv =3D host->private_data;
> +	int ret;
> =20
> -	ret =3D platform_device_add(ahci_pdev);
> -	if (ret) {
> -err_out:
> -		platform_device_put(ahci_pdev);
> +	ret =3D ahci_platform_suspend_host(dev);
> +	if (ret)
>  		return ret;
> -	}
> +
> +	imx_sata_disable(hpriv);
> =20
>  	return 0;
>  }
> =20
> -static int imx_ahci_remove(struct platform_device *pdev)
> +static int imx_ahci_resume(struct device *dev)
>  {
> -	struct imx_ahci_priv *imxpriv =3D platform_get_drvdata(pdev);
> -	struct platform_device *ahci_pdev =3D imxpriv->ahci_pdev;
> +	struct ata_host *host =3D dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv =3D host->private_data;
> +	int ret;
> =20
> -	platform_device_unregister(ahci_pdev);
> -	return 0;
> +	ret =3D imx_sata_enable(hpriv);
> +	if (ret)
> +		return ret;
> +
> +	return ahci_platform_resume_host(dev);
>  }

The code above introduces two new warnings for CONFIG_PM_SLEEP=3Dn:

drivers/ata/ahci_imx.c:284:12: warning: =E2=80=98imx_ahci_suspend=E2=80=99 =
defined but not used [-Wunused-function]
drivers/ata/ahci_imx.c:299:12: warning: =E2=80=98imx_ahci_resume=E2=80=99 d=
efined but not used [-Wunused-function]

[ There needs to be CONFIG_PM_SLEEP ifdef around imh_ahci_suspend()
  and imx_ahci_resume(). ]

All the rest looks good.

> +static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_res=
ume);
> +
>  static struct platform_driver imx_ahci_driver =3D {
>  	.probe =3D imx_ahci_probe,
> -	.remove =3D imx_ahci_remove,
> +	.remove =3D ata_platform_remove_one,
>  	.driver =3D {
>  		.name =3D "ahci-imx",
>  		.owner =3D THIS_MODULE,
>  		.of_match_table =3D imx_ahci_of_match,
> +		.pm =3D &ahci_imx_pm_ops,
>  	},
>  };
>  module_platform_driver(imx_ahci_driver);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
