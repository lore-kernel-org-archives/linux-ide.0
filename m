From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller driver
Date: Tue, 17 Jun 2014 10:42:36 -0500
Message-ID: <419989CC-5106-4AF7-8911-617B51FD7395@codeaurora.org>
References: <1402676163-31574-1-git-send-email-galak@codeaurora.org> <14174621.WL9ndpHQ2Q@amdc1032>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <14174621.WL9ndpHQ2Q@amdc1032>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-ide@vger.kernel.org


On Jun 17, 2014, at 7:25 AM, Bartlomiej Zolnierkiewicz <b.zolnierkie@sa=
msung.com> wrote:

>=20
> Hi,
>=20
> On Friday, June 13, 2014 11:16:03 AM Kumar Gala wrote:
>> Add support for the Qualcomm AHCI SATA controller that exists on sev=
eral
>> SoC and specifically the IPQ806x family of chips.  The IPQ806x SATA =
support
>> requires the associated IPQ806x SATA PHY Driver to be enabled as wel=
l.
>>=20
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> v2:
>> * Fixed MODULE_LICENSE to be GPL v2
>>=20
>> drivers/ata/Kconfig     | 10 ++++++
>> drivers/ata/Makefile    |  1 +
>> drivers/ata/ahci_qcom.c | 86 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>> 3 files changed, 97 insertions(+)
>> create mode 100644 drivers/ata/ahci_qcom.c
>>=20
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 7671dba..aa88648 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -132,6 +132,16 @@ config AHCI_MVEBU
>>=20
>> 	  If unsure, say N.
>>=20
>> +config AHCI_QCOM
>> +	tristate "Qualcomm AHCI SATA support"
>> +	depends on ARCH_QCOM
>> +	help
>> +	  This option enables support for AHCI SATA controller
>> +	  integrated into Qualcomm ARM SoC chipsets. For more
>> +	  information please refer to http://www.qualcomm.com/chipsets.
>> +
>> +	  If unsure, say N.
>> +
>> config AHCI_SUNXI
>> 	tristate "Allwinner sunxi AHCI SATA support"
>> 	depends on ARCH_SUNXI
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index 5a02aee..15401e9 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_SATA_HIGHBANK)	+=3D sata_highbank.o l=
ibahci.o
>> obj-$(CONFIG_AHCI_DA850)	+=3D ahci_da850.o libahci.o libahci_platfor=
m.o
>> obj-$(CONFIG_AHCI_IMX)		+=3D ahci_imx.o libahci.o libahci_platform.o
>> obj-$(CONFIG_AHCI_MVEBU)	+=3D ahci_mvebu.o libahci.o libahci_platfor=
m.o
>> +obj-$(CONFIG_AHCI_QCOM)		+=3D ahci_qcom.o libahci.o libahci_platfor=
m.o
>> obj-$(CONFIG_AHCI_SUNXI)	+=3D ahci_sunxi.o libahci.o libahci_platfor=
m.o
>> obj-$(CONFIG_AHCI_ST)		+=3D ahci_st.o libahci.o libahci_platform.o
>> obj-$(CONFIG_AHCI_XGENE)	+=3D ahci_xgene.o libahci.o libahci_platfor=
m.o
>> diff --git a/drivers/ata/ahci_qcom.c b/drivers/ata/ahci_qcom.c
>> new file mode 100644
>> index 0000000..bfb7a77
>> --- /dev/null
>> +++ b/drivers/ata/ahci_qcom.c
>> @@ -0,0 +1,86 @@
>> +/*
>> + * Qualcomm ARM SoC AHCI SATA platform driver
>> + *
>> + * based on the AHCI SATA platform driver by Jeff Garzik and Anton =
Vorontsov
>> + *
>> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
nd
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pm.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/libata.h>
>> +#include <linux/ahci_platform.h>
>> +#include "ahci.h"
>> +
>> +static const struct ata_port_info qcom_ahci_port_info =3D {
>> +	.flags		=3D AHCI_FLAG_COMMON,
>> +	.pio_mask	=3D ATA_PIO4,
>> +	.udma_mask	=3D ATA_UDMA6,
>> +	.port_ops	=3D &ahci_platform_ops,
>> +};
>> +
>> +static int qcom_ahci_probe(struct platform_device *pdev)
>> +{
>> +	struct ahci_host_priv *hpriv;
>> +	struct clk *rxoob_clk;
>> +	int rc;
>> +
>> +	hpriv =3D ahci_platform_get_resources(pdev);
>> +	if (IS_ERR(hpriv))
>> +		return PTR_ERR(hpriv);
>> +
>> +	/* Try and set the rxoob clk to 100Mhz */
>> +	rxoob_clk =3D of_clk_get_by_name(pdev->dev.of_node, "rxoob");
>> +	if (IS_ERR(rxoob_clk))
>> +		return PTR_ERR(rxoob_clk);
>> +
>> +	rc =3D clk_set_rate(rxoob_clk, 100000000);
>=20
> Shouldn't the clk_prepare_enable() be called first?

I don=92t believe there is any requirement for clk_prepare_enable to be=
 called first.

>=20
>> +	if (rc)
>> +		return rc;
>=20
> of_clk_get_by_name() gets an extra reference on the clock so clk_put(=
)
> should be called on failure.

will fix.

>=20
>> +	rc =3D ahci_platform_enable_resources(hpriv);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc =3D ahci_platform_init_host(pdev, hpriv, &qcom_ahci_port_info, =
0, 0);
>> +	if (rc)
>> +		goto disable_resources;
>> +
>> +	return 0;
>> +disable_resources:
>> +	ahci_platform_disable_resources(hpriv);
>> +	return rc;
>> +}
>> +
>> +static const struct of_device_id qcom_ahci_of_match[] =3D {
>> +	{ .compatible =3D "qcom,msm-ahci", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_ahci_of_match);
>> +
>> +static struct platform_driver qcom_ahci_driver =3D {
>> +	.probe =3D qcom_ahci_probe,
>> +	.remove =3D ata_platform_remove_one,
>> +	.driver =3D {
>> +		.name =3D "qcom_ahci_qcom",
>> +		.owner =3D THIS_MODULE,
>> +		.of_match_table =3D qcom_ahci_of_match,
>> +	},
>=20
> This driver lacks PM suspend/resume support.  I assume that
> the IPQ806x platform also doesn't support suspend/resume yet
> (if so a comment in the driver code about this would be useful),
> otherwise the driver should be fixed.

Correct, do you want the comment in the commit message or the driver it=
self?

>=20
>> +};
>> +module_platform_driver(qcom_ahci_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm AHCI SATA platform driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("ahci:qcom");
>=20
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
