From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] ata: ahci_sunxi: add support for R40
 SATA controller
Date: Tue, 10 Oct 2017 12:03:57 +0200
Message-ID: <20171010100357.vjcq7qdve3mnqxh3@flea.home>
References: <20171008043541.48564-1-icenowy@aosc.io>
 <20171008043541.48564-2-icenowy@aosc.io>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n4udapaxwlhvmdlp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBY6V6LHAKGQEWMXDR2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20171008043541.48564-2-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--n4udapaxwlhvmdlp
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Sun, Oct 08, 2017 at 04:35:41AM +0000, Icenowy Zheng wrote:
> Allwinner R40 SoC has an AHCI SATA controller like the one in A10/A20,
> but with a reset control and two dedicated VDD pins for this controller
> (one 1.2v and one 2.5v).
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/ata/ahci_sunxi.c | 118 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index b26437430163..a650fd6508be 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include "ahci.h"
>  
>  #define DRV_NAME "ahci-sunxi"
> @@ -58,6 +59,19 @@ MODULE_PARM_DESC(enable_pmp,
>  #define AHCI_P0PHYCR	0x0178
>  #define AHCI_P0PHYSR	0x017c
>  
> +struct ahci_sunxi_quirks {
> +	bool has_reset;
> +	bool has_vdd1v2;
> +	bool has_vdd2v5;
> +};
> +
> +struct ahci_sunxi_data {
> +	const struct ahci_sunxi_quirks *quirks;
> +	struct reset_control *reset;
> +	struct regulator *vdd1v2;
> +	struct regulator *vdd2v5;
> +};
> +
>  static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
>  {
>  	u32 reg_val;
> @@ -179,17 +193,69 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
> +	struct ahci_sunxi_data *data;
>  	int rc;
>  
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->quirks = of_device_get_match_data(dev);
> +	if (!data->quirks)
> +		return -EINVAL;
> +
> +	if (data->quirks->has_reset) {
> +		data->reset = devm_reset_control_get(dev, NULL);
> +		if (IS_ERR(data->reset)) {
> +			dev_err(dev, "Failed to get reset\n");
> +			return PTR_ERR(data->reset);
> +		}
> +	}
> +
> +	if (data->quirks->has_vdd1v2) {
> +		data->vdd1v2 = devm_regulator_get(dev, "vdd1v2");
> +		if (IS_ERR(data->vdd1v2)) {
> +			dev_err(dev, "Failed to get 1.2v VDD regulator\n");
> +			return PTR_ERR(data->vdd1v2);
> +		}
> +	}
> +
> +	if (data->quirks->has_vdd2v5) {
> +		data->vdd2v5 = devm_regulator_get(dev, "vdd2v5");
> +		if (IS_ERR(data->vdd2v5)) {
> +			dev_err(dev, "Failed to get 2.5v VDD regulator\n");
> +			return PTR_ERR(data->vdd2v5);
> +		}
> +	}
> +
>  	hpriv = ahci_platform_get_resources(pdev);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> +	hpriv->plat_data = data;
>  	hpriv->start_engine = ahci_sunxi_start_engine;
>  
> +	if (data->quirks->has_vdd1v2) {
> +		rc = regulator_enable(data->vdd1v2);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (data->quirks->has_vdd2v5) {
> +		rc = regulator_enable(data->vdd2v5);
> +		if (rc)
> +			goto disable_vdd1v2;
> +	}
> +
> +	if (data->quirks->has_reset) {
> +		rc = reset_control_deassert(data->reset);
> +		if (rc)
> +			goto disable_vdd2v5;
> +	}
> +

This should all be dealt with the AHCI platform layer, just like the
clocks, and well some regulators already.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--n4udapaxwlhvmdlp--
