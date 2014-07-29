From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v12 4/8] ata: libahci: allow to use multiple PHYs
Date: Tue, 29 Jul 2014 09:43:45 +0200
Message-ID: <53D750B1.8090205@redhat.com>
References: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaG2HoW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2014 03:44:22 -0400
In-Reply-To: <1406618447-25499-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 07/29/2014 09:20 AM, Antoine T=C3=A9nart wrote:
> The current implementation of the libahci does not allow to use multi=
ple
> PHYs. This patch adds the support of multiple PHYs by the libahci whi=
le
> keeping the old bindings valid for device tree compatibility.
>=20
> This introduce a new way of defining SATA ports in the device tree, w=
ith
> one port per sub-node. This as the advantage of allowing a per port
> configuration. Because some ports may be accessible but disabled in t=
he
> device tree, the port_map mask is computed automatically when using
> this.
>=20
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> ---
>=20
> Updated with the latest comment from Hans.

Looks 100% good now.

Regards,

Hans

>=20
>  drivers/ata/ahci.h             |   7 +-
>  drivers/ata/libahci_platform.c | 189 +++++++++++++++++++++++++++++++=
+---------
>  2 files changed, 157 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index cb8d58926851..47de53284ad7 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -332,7 +332,12 @@ struct ahci_host_priv {
>  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>  	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
>  	struct regulator	*target_pwr;	/* Optional */
> -	struct phy		*phy;		/* If platform uses phy */
> +	/*
> +	 * If platform uses PHYs. There is a 1:1 relation between the port =
number and
> +	 * the PHY position in this array.
> +	 */
> +	struct phy		**phys;
> +	unsigned		nports;		/* Number of ports */
>  	void			*plat_data;	/* Other platform data */
>  	/*
>  	 * Optional ahci_start_engine override, if not set this gets set to=
 the
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_pla=
tform.c
> index db9b90d876dd..98e4f953bc8c 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -39,6 +39,67 @@ static struct scsi_host_template ahci_platform_sht=
 =3D {
>  };
> =20
>  /**
> + * ahci_platform_enable_phys - Enable PHYs
> + * @hpriv: host private area to store config values
> + *
> + * This function enables all the PHYs found in hpriv->phys, if any.
> + * If a PHY fails to be enabled, it disables all the PHYs already
> + * enabled in reverse order and returns an error.
> + *
> + * RETURNS:
> + * 0 on success otherwise a negative error code
> + */
> +int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
> +{
> +	int rc, i;
> +
> +	for (i =3D 0; i < hpriv->nports; i++) {
> +		if (!hpriv->phys[i])
> +			continue;
> +
> +		rc =3D phy_init(hpriv->phys[i]);
> +		if (rc)
> +			goto disable_phys;
> +
> +		rc =3D phy_power_on(hpriv->phys[i]);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_phys:
> +	while (--i >=3D 0) {
> +		phy_power_off(hpriv->phys[i]);
> +		phy_exit(hpriv->phys[i]);
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
> +
> +/**
> + * ahci_platform_disable_phys - Enable PHYs
> + * @hpriv: host private area to store config values
> + *
> + * This function disables all PHYs found in hpriv->phys.
> + */
> +void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < hpriv->nports; i++) {
> +		if (!hpriv->phys[i])
> +			continue;
> +
> +		phy_power_off(hpriv->phys[i]);
> +		phy_exit(hpriv->phys[i]);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
> +
> +/**
>   * ahci_platform_enable_clks - Enable platform clocks
>   * @hpriv: host private area to store config values
>   *
> @@ -92,7 +153,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>   * following order:
>   * 1) Regulator
>   * 2) Clocks (through ahci_platform_enable_clks)
> - * 3) Phy
> + * 3) Phys
>   *
>   * If resource enabling fails at any point the previous enabled reso=
urces
>   * are disabled in reverse order.
> @@ -114,17 +175,9 @@ int ahci_platform_enable_resources(struct ahci_h=
ost_priv *hpriv)
>  	if (rc)
>  		goto disable_regulator;
> =20
> -	if (hpriv->phy) {
> -		rc =3D phy_init(hpriv->phy);
> -		if (rc)
> -			goto disable_clks;
> -
> -		rc =3D phy_power_on(hpriv->phy);
> -		if (rc) {
> -			phy_exit(hpriv->phy);
> -			goto disable_clks;
> -		}
> -	}
> +	rc =3D ahci_platform_enable_phys(hpriv);
> +	if (rc)
> +		goto disable_clks;
> =20
>  	return 0;
> =20
> @@ -144,16 +197,13 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resource=
s);
>   *
>   * This function disables all ahci_platform managed resources in the
>   * following order:
> - * 1) Phy
> + * 1) Phys
>   * 2) Clocks (through ahci_platform_disable_clks)
>   * 3) Regulator
>   */
>  void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>  {
> -	if (hpriv->phy) {
> -		phy_power_off(hpriv->phy);
> -		phy_exit(hpriv->phy);
> -	}
> +	ahci_platform_disable_phys(hpriv);
> =20
>  	ahci_platform_disable_clks(hpriv);
> =20
> @@ -187,7 +237,7 @@ static void ahci_platform_put_resources(struct de=
vice *dev, void *res)
>   * 2) regulator for controlling the targets power (optional)
>   * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree =
node,
>   *    or for non devicetree enabled platforms a single clock
> - *	4) phy (optional)
> + *	4) phys (optional)
>   *
>   * RETURNS:
>   * The allocated ahci_host_priv on success, otherwise an ERR_PTR val=
ue
> @@ -197,7 +247,9 @@ struct ahci_host_priv *ahci_platform_get_resource=
s(struct platform_device *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct ahci_host_priv *hpriv;
>  	struct clk *clk;
> -	int i, rc =3D -ENOMEM;
> +	struct device_node *child;
> +	int i, enabled_ports =3D 0, rc =3D -ENOMEM;
> +	u32 mask_port_map =3D 0;
> =20
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
>  		return ERR_PTR(-ENOMEM);
> @@ -246,28 +298,89 @@ struct ahci_host_priv *ahci_platform_get_resour=
ces(struct platform_device *pdev)
>  		hpriv->clks[i] =3D clk;
>  	}
> =20
> -	hpriv->phy =3D devm_phy_get(dev, "sata-phy");
> -	if (IS_ERR(hpriv->phy)) {
> -		rc =3D PTR_ERR(hpriv->phy);
> -		switch (rc) {
> -		case -ENOSYS:
> -			/* No PHY support. Check if PHY is required. */
> -			if (of_find_property(dev->of_node, "phys", NULL)) {
> -				dev_err(dev, "couldn't get sata-phy: ENOSYS\n");
> +	hpriv->nports =3D of_get_child_count(dev->of_node);
> +
> +	if (hpriv->nports) {
> +		hpriv->phys =3D devm_kzalloc(dev,
> +					   hpriv->nports * sizeof(*hpriv->phys),
> +					   GFP_KERNEL);
> +		if (!hpriv->phys) {
> +			rc =3D -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		for_each_child_of_node(dev->of_node, child) {
> +			u32 port;
> +
> +			if (!of_device_is_available(child))
> +				continue;
> +
> +			if (of_property_read_u32(child, "reg", &port)) {
> +				rc =3D -EINVAL;
>  				goto err_out;
>  			}
> -		case -ENODEV:
> -			/* continue normally */
> -			hpriv->phy =3D NULL;
> -			break;
> =20
> -		case -EPROBE_DEFER:
> -			goto err_out;
> +			if (port >=3D hpriv->nports) {
> +				dev_warn(dev, "invalid port number %d\n", port);
> +				continue;
> +			}
> +
> +			mask_port_map |=3D BIT(port);
> +
> +			hpriv->phys[port] =3D devm_of_phy_get(dev, child, NULL);
> +			if (IS_ERR(hpriv->phys[port])) {
> +				rc =3D PTR_ERR(hpriv->phys[port]);
> +				dev_err(dev,
> +					"couldn't get PHY in node %s: %d\n",
> +					child->name, rc);
> +				goto err_out;
> +			}
> =20
> -		default:
> -			dev_err(dev, "couldn't get sata-phy\n");
> +			enabled_ports++;
> +		}
> +		if (!enabled_ports) {
> +			dev_warn(dev, "No port enabled\n");
> +			rc =3D -ENODEV;
>  			goto err_out;
>  		}
> +
> +		if (!hpriv->mask_port_map)
> +			hpriv->mask_port_map =3D mask_port_map;
> +	} else {
> +		/*
> +		 * If no sub-node was found, keep this for device tree
> +		 * compatibility
> +		 */
> +		struct phy *phy =3D devm_phy_get(dev, "sata-phy");
> +		if (!IS_ERR(phy)) {
> +			hpriv->phys =3D devm_kzalloc(dev, sizeof(*hpriv->phys),
> +						   GFP_KERNEL);
> +			if (!hpriv->phys) {
> +				rc =3D -ENOMEM;
> +				goto err_out;
> +			}
> +
> +			hpriv->phys[0] =3D phy;
> +			hpriv->nports =3D 1;
> +		} else {
> +			rc =3D PTR_ERR(phy);
> +			switch (rc) {
> +				case -ENOSYS:
> +					/* No PHY support. Check if PHY is required. */
> +					if (of_find_property(dev->of_node, "phys", NULL)) {
> +						dev_err(dev, "couldn't get sata-phy: ENOSYS\n");
> +						goto err_out;
> +					}
> +				case -ENODEV:
> +					/* continue normally */
> +					hpriv->phys =3D NULL;
> +					break;
> +
> +				default:
> +					goto err_out;
> +
> +			}
> +		}
>  	}
> =20
>  	pm_runtime_enable(dev);
> @@ -291,7 +404,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
>   * @host_flags: ahci host flags used in ahci_host_priv
>   *
>   * This function does all the usual steps needed to bring up an
> - * ahci-platform host, note any necessary resources (ie clks, phy, e=
tc.)
> + * ahci-platform host, note any necessary resources (ie clks, phys, =
etc.)
>   * must be initialized / enabled before calling this.
>   *
>   * RETURNS:
> @@ -395,7 +508,7 @@ static void ahci_host_stop(struct ata_host *host)
>   * @dev: device pointer for the host
>   *
>   * This function does all the usual steps needed to suspend an
> - * ahci-platform host, note any necessary resources (ie clks, phy, e=
tc.)
> + * ahci-platform host, note any necessary resources (ie clks, phys, =
etc.)
>   * must be disabled after calling this.
>   *
>   * RETURNS:
> @@ -432,7 +545,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
>   * @dev: device pointer for the host
>   *
>   * This function does all the usual steps needed to resume an ahci-p=
latform
> - * host, note any necessary resources (ie clks, phy, etc.)  must be
> + * host, note any necessary resources (ie clks, phys, etc.)  must be
>   * initialized / enabled before calling this.
>   *
>   * RETURNS:
>=20
