From: Yuvaraj Cd <yuvaraj.lkml@gmail.com>
Subject: Re: [PATCH 2/3] Phy: Exynos: Add Exynos5250 sata phy driver
Date: Mon, 7 Oct 2013 19:35:04 +0530
Message-ID: <CA+NduCAwnqz4_YNoVnpfV3O6fn=2QTdv4zgEdYRv4qjMRvWeag@mail.gmail.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
	<1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
	<524AC56C.1060501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:62903 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab3JGOFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Oct 2013 10:05:07 -0400
In-Reply-To: <524AC56C.1060501@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-ide@vger.kernel.org, ks.giri@samsung.com, Vasanth Ananthan <vasanth.a@samsung.com>, Rob Herring <rob.herring@calxeda.com>, aditya.ps@samsung.com, grant.likely@linaro.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, s.nawrocki@samsung.com, tj@kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 1, 2013 at 6:21 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On Tuesday 01 October 2013 12:03 PM, Yuvaraj Kumar C D wrote:
>> This patch adds the sata phy driver for Exynos5250.Exynos5250 sata
>> phy comprises of CMU and TRSV blocks which are of I2C register Map.
>> So this patch also adds a i2c client driver, which is used configure
>> the CMU and TRSV block of exynos5250 SATA PHY.
>
> Why not make the Exynos5250 sata phy as a i2c client driver instead?
>>
>> This patch incorporates the generic phy framework to deal with sata
>> phy.
>>
>> This patch depends on the below patch
>>       [1].drivers: phy: add generic PHY framework
>>               by Kishon Vijay Abraham I<kishon@ti.com>
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> Signed-off-by: Girish K S <ks.giri@samsung.com>
>> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
>> ---
>>  drivers/phy/Kconfig                      |    6 +
>>  drivers/phy/Makefile                     |    1 +
>>  drivers/phy/exynos/Kconfig               |    5 +
>>  drivers/phy/exynos/Makefile              |    5 +
>>  drivers/phy/exynos/exynos5250_phy_i2c.c  |   53 +++++++
>>  drivers/phy/exynos/sata_phy_exynos5250.c |  248 ++++++++++++++++++++++++++++++
>>  drivers/phy/exynos/sata_phy_exynos5250.h |   33 ++++
>>  7 files changed, 351 insertions(+)
>>  create mode 100644 drivers/phy/exynos/Kconfig
>>  create mode 100644 drivers/phy/exynos/Makefile
>>  create mode 100644 drivers/phy/exynos/exynos5250_phy_i2c.c
>>  create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.c
>>  create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.h
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 5f85909..ab3d1c6 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -11,3 +11,9 @@ menuconfig GENERIC_PHY
>>         devices present in the kernel. This layer will have the generic
>>         API by which phy drivers can create PHY using the phy framework and
>>         phy users can obtain reference to the PHY.
>> +
>> +if GENERIC_PHY
>
> NAK. Just select GENERIC_PHY from your driver Kconfig.
>> +
>> +source "drivers/phy/exynos/Kconfig"
>> +
>> +endif
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index 9e9560f..e0223d7 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -3,3 +3,4 @@
>>  #
>>
>>  obj-$(CONFIG_GENERIC_PHY)    += phy-core.o
>> +obj-$(CONFIG_PHY_SAMSUNG_SATA)       += exynos/
>
> simply have phy-exynos5250 in drivers/phy.
ok.
>> diff --git a/drivers/phy/exynos/Kconfig b/drivers/phy/exynos/Kconfig
>> new file mode 100644
>> index 0000000..fa125fb
>> --- /dev/null
>> +++ b/drivers/phy/exynos/Kconfig
>> @@ -0,0 +1,5 @@
>> +config PHY_SAMSUNG_SATA
>> +     tristate "Samsung Sata SerDes/PHY driver"
>> +     help
>> +       Support for Samsung sata SerDes/Phy found on Samsung
>> +       SoCs.
>> diff --git a/drivers/phy/exynos/Makefile b/drivers/phy/exynos/Makefile
>> new file mode 100644
>> index 0000000..50dc7eb
>> --- /dev/null
>> +++ b/drivers/phy/exynos/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for the exynos phy drivers.
>> +#
>> +ccflags-y := -Idrivers/phy/exynos
>> +obj-$(CONFIG_PHY_SAMSUNG_SATA)       += sata_phy_exynos5250.o exynos5250_phy_i2c.o
>> diff --git a/drivers/phy/exynos/exynos5250_phy_i2c.c b/drivers/phy/exynos/exynos5250_phy_i2c.c
>> new file mode 100644
>> index 0000000..9c75d3b
>> --- /dev/null
>> +++ b/drivers/phy/exynos/exynos5250_phy_i2c.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Copyright (C) 2013 Samsung Electronics Co.Ltd
>> + * Author:
>> + *   Yuvaraj C D <yuvaraj.cd@samsung.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include "sata_phy_exynos5250.h"
>> +
>> +static int exynos_sata_i2c_probe(struct i2c_client *client,
>> +             const struct i2c_device_id *i2c_id)
>> +{
>> +     sataphy_attach_i2c_client(client);
>> +
>> +     dev_info(&client->adapter->dev,
>> +             "attached %s into i2c adapter successfully\n",
>> +             client->name);
>> +
>> +     return 0;
>> +}
>> +
>> +static int exynos_sata_i2c_remove(struct i2c_client *client)
>> +{
>> +     dev_info(&client->adapter->dev,
>> +             "detached %s from i2c adapter successfully\n",
>> +             client->name);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct i2c_device_id phy_i2c_device_match[] = {
>> +     { "sata-phy-i2c", 0 },
>> +};
>> +MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
>> +
>> +struct i2c_driver sataphy_i2c_driver = {
>> +     .probe    = exynos_sata_i2c_probe,
>> +     .id_table = phy_i2c_device_match,
>> +     .remove         = exynos_sata_i2c_remove,
>> +     .driver   = {
>> +             .name = "sata-phy-i2c",
>> +             .owner = THIS_MODULE,
>> +             .of_match_table = (void *)phy_i2c_device_match,
>> +             },
>> +};
>
> As I just mentioned above, we can merge this driver with the below one.
True, Initially it was merged.But already existing drivers of which
are of similar to this kind were done in this way.
Please refer  /drivers/gpu/drm//exynos/exynos_hdmiphy.c

>> diff --git a/drivers/phy/exynos/sata_phy_exynos5250.c b/drivers/phy/exynos/sata_phy_exynos5250.c
>> new file mode 100644
>> index 0000000..726c10e
>> --- /dev/null
>> +++ b/drivers/phy/exynos/sata_phy_exynos5250.c
>> @@ -0,0 +1,248 @@
>> +/*
>> + * Samsung SATA SerDes(PHY) driver
>> + *
>> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>> + * Authors: Girish K S <ks.giri@samsung.com>
>> + *         Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/i2c.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/clk.h>
>> +#include "sata_phy_exynos5250.h"
>> +
>> +static struct i2c_client *phy_i2c_client;
>> +
>> +struct exynos_sata_phy {
>> +     struct phy *phy;
>> +     struct clk *phyclk;
>> +     void __iomem *regs;
>> +     void __iomem *pmureg;
>> +};
>> +
>> +static bool wait_for_reg_status(void __iomem *base, u32 reg, u32 checkbit,
>> +                             u32 status)
>> +{
>> +     unsigned long timeout = jiffies + usecs_to_jiffies(1000);
>> +     while (time_before(jiffies, timeout)) {
>> +             if ((readl(base + reg) & checkbit) == status)
>> +                     return true;
>> +     }
>> +     return false;
>> +}
>> +
>> +void sataphy_attach_i2c_client(struct i2c_client *sata_phy)
>> +{
>> +     if (sata_phy)
>> +             phy_i2c_client = sata_phy;
>> +}
>> +
>> +static int __set_phy_state(struct exynos_sata_phy *state, unsigned int on)
>> +{
>> +     u32 reg;
>> +
>> +     reg = readl(state->pmureg);
>> +     if (on)
>> +             reg |= EXYNOS_SATA_PHY_EN;
>> +     else
>> +             reg &= ~EXYNOS_SATA_PHY_EN;
>> +     writel(reg, state->pmureg);
>> +
>> +     return 0;
>> +}
>> +
>> +static int exynos_sata_phy_power_on(struct phy *phy)
>> +{
>> +     struct exynos_sata_phy *state = phy_get_drvdata(phy);
>> +
>> +     return __set_phy_state(state, 1);
>> +}
>> +
>> +static int exynos_sata_phy_power_off(struct phy *phy)
>> +{
>> +     struct exynos_sata_phy *state = phy_get_drvdata(phy);
>> +
>> +     return __set_phy_state(state, 0);
>> +}
>> +
>> +static int exynos_sataphy_parse_dt(struct device *dev,
>> +                             struct exynos_sata_phy *sata)
>> +{
>> +     struct device_node *np = dev->of_node;
>> +     struct device_node *sataphy_pmu;
>> +
>> +     sataphy_pmu = of_get_child_by_name(np, "sataphy-pmu");
>> +     if (!sataphy_pmu) {
>> +             dev_err(dev, "No PMU interface for sata-phy\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     sata->pmureg = of_iomap(sataphy_pmu, 0);
>> +     if (!sata->pmureg) {
>> +             dev_err(dev, "Can't get sata-phy pmu control register\n");
>> +             of_node_put(sataphy_pmu);
>> +             return -ENXIO;
>> +     }
>> +
>> +     of_node_put(sataphy_pmu);
>> +     return 0;
>> +}
>> +
>> +static int exynos_sata_phy_init(struct phy *phy)
>> +{
>> +     u32 val;
>> +     int ret = 0;
>> +     u8 buf[] = { 0x3A, 0x0B };
>> +     struct exynos_sata_phy *sata_phy = phy_get_drvdata(phy);
>> +
>> +     if (!phy_i2c_client)
>> +             return -EPROBE_DEFER;
>> +
>> +     writel(EXYNOS_SATA_PHY_EN, sata_phy->pmureg);
>> +
>> +     val = 0;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val |= 0xFF;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val |= LINK_RESET;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val |= RESET_CMN_RST_N;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
>> +     val &= ~PHCTRLM_REF_RATE;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
>> +
>> +     /* High speed enable for Gen3 */
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
>> +     val |= PHCTRLM_HIGH_SPEED;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_PHSATA_CTRLM);
>> +
>> +     val |= CTRL0_P0_PHY_CALIBRATED_SEL | CTRL0_P0_PHY_CALIBRATED;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_CTRL0);
>> +
>> +     writel(0x2, sata_phy->regs + EXYNOS5_SATA_MODE0);
>> +
>> +     ret = i2c_master_send(phy_i2c_client, buf, sizeof(buf));
>> +     if (ret < 0)
>> +             return -ENXIO;
>> +
>> +     /* release cmu reset */
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val &= ~RESET_CMN_RST_N;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +
>> +     val = readl(sata_phy->regs + EXYNOS5_SATA_RESET);
>> +     val |= RESET_CMN_RST_N;
>> +     writel(val, sata_phy->regs + EXYNOS5_SATA_RESET);
>> +
>> +     return (wait_for_reg_status(sata_phy->regs, EXYNOS5_SATA_PHSATA_STATM,
>> +             PHSTATM_PLL_LOCKED, 1)) ? 0 : -EINVAL;
>> +
>> +}
>> +
>> +static struct phy_ops exynos_sata_phy_ops = {
>> +     .init           = exynos_sata_phy_init,
>> +     .power_on       = exynos_sata_phy_power_on,
>> +     .power_off      = exynos_sata_phy_power_off,
>> +     .owner          = THIS_MODULE,
>> +};
>> +
>> +static int exynos_sata_phy_probe(struct platform_device *pdev)
>> +{
>> +     struct exynos_sata_phy *sata;
>> +     struct device *dev = &pdev->dev;
>> +     struct resource *res;
>> +     struct phy_provider *phy_provider;
>> +     char label[9];
>> +     int ret = 0;
>> +
>> +     sata = devm_kzalloc(dev, sizeof(*sata), GFP_KERNEL);
>> +     if (!sata)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +     sata->regs = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(sata->regs))
>> +             return PTR_ERR(sata->regs);
>> +
>> +     dev_set_drvdata(dev, sata);
>> +
>> +     if (i2c_add_driver(&sataphy_i2c_driver)) {
>> +             dev_err(dev, "failed to register sataphy i2c driver\n");
>> +             return -ENOENT;
>> +     }
>> +
>> +     sata->phyclk = devm_clk_get(dev, "sata_phyctrl");
>> +     if (IS_ERR(sata->phyclk)) {
>> +             dev_err(dev, "failed to get clk for PHY\n");
>> +             return PTR_ERR(sata->phyclk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(sata->phyclk);
>> +     if (ret < 0) {
>> +             dev_err(dev, "failed to enable source clk\n");
>> +             return ret;
>> +     }
>> +
>> +     if (dev->of_node) {
>> +             ret = exynos_sataphy_parse_dt(dev, sata);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     phy_provider = devm_of_phy_provider_register(dev,
>> +                                     of_phy_simple_xlate);
>> +     if (IS_ERR(phy_provider))
>> +             return PTR_ERR(phy_provider);
>> +
>> +     snprintf(label, sizeof(label), "%s.%d", "sata-phy", pdev->id);
>> +
>> +     sata->phy = devm_phy_create(dev, pdev->id, &exynos_sata_phy_ops, label);
>
> Alright. You are using a older version of PHY framework. I'll wait for you to
> adapt to the latest version of PHY framework [1] before reviewing any further.
Sure,I will adapt to the latest version of PHY framework and post soon.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
>
> Thanks
> Kishon
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
