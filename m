From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v10 1/8] phy: add a driver for the Berlin SATA PHY
Date: Fri, 18 Jul 2014 18:24:22 +0530
Message-ID: <53C918FE.8040303@gmail.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com> <1405686607-8126-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64211 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbaGRMzw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 08:55:52 -0400
In-Reply-To: <1405686607-8126-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/18/2014 06:00 PM, Antoine T=C3=A9nart wrote:
> The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
>
> The mode selection can let us think this PHY can be configured to fit
> other purposes. But there are reasons to think the SATA mode will be
> the only one usable: the PHY registers are only accessible indirectly
> through two registers in the SATA range, the PHY seems to be integrat=
ed
> and no information tells us the contrary. For these reasons, make the
> driver a SATA PHY driver.
>
(...)

> +
> +static const struct of_device_id phy_berlin_sata_of_match[] =3D {
> +	{ .compatible =3D "marvell,berlin2q-sata-phy" },
> +	{ },
> +};
> +
> +static struct platform_driver phy_berlin_sata_driver =3D {
> +	.probe	=3D phy_berlin_sata_probe,
> +	.driver	=3D {
> +		.name		=3D "phy-berlin-sata",
> +		.owner		=3D THIS_MODULE,

owner filed automatically update with module_platform_driver().

see:http://lxr.free-electrons.com/source/include/linux/platform_device.=
h#L190
 =20

--=20
Regards,
Varka Bhadram.

