From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/3] Phy: Exynos: Add Exynos5250 sata phy driver
Date: Tue, 19 Nov 2013 15:22:47 +0530
Message-ID: <528B34EF.3030108@ti.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>	<1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>	<524AC56C.1060501@ti.com>	<CA+NduCAwnqz4_YNoVnpfV3O6fn=2QTdv4zgEdYRv4qjMRvWeag@mail.gmail.com>	<52846442.2020307@ti.com> <CAKuRcOK8XDKGsY3w2fwnrqtyH2HN0LjrqE6AoE0dSkaVOy5ozA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42789 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab3KSJxY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Nov 2013 04:53:24 -0500
In-Reply-To: <CAKuRcOK8XDKGsY3w2fwnrqtyH2HN0LjrqE6AoE0dSkaVOy5ozA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Cc: Yuvaraj Cd <yuvaraj.lkml@gmail.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-ide@vger.kernel.org, "ks.giri@samsung.com" <ks.giri@samsung.com>, Vasanth Ananthan <vasanth.a@samsung.com>, Rob Herring <rob.herring@calxeda.com>, aditya.ps@samsung.com, Grant Likely <grant.likely@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, s.nawrocki@samsung.com, tj@kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 15 November 2013 11:17 AM, Yuvaraj Kumar wrote:
> On Thu, Nov 14, 2013 at 11:18 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi,
>>
>> On Monday 07 October 2013 07:35 PM, Yuvaraj Cd wrote:
>>> On Tue, Oct 1, 2013 at 6:21 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>> On Tuesday 01 October 2013 12:03 PM, Yuvaraj Kumar C D wrote:
>>>>> This patch adds the sata phy driver for Exynos5250.Exynos5250 sata
>>>>> phy comprises of CMU and TRSV blocks which are of I2C register Map.
>>>>> So this patch also adds a i2c client driver, which is used configure
>>>>> the CMU and TRSV block of exynos5250 SATA PHY.
>>>>
>>>> Why not make the Exynos5250 sata phy as a i2c client driver instead?
>>>>>
>>>>> This patch incorporates the generic phy framework to deal with sata
>>>>> phy.
>>>>>
>>>>> This patch depends on the below patch
>>>>>       [1].drivers: phy: add generic PHY framework
>>>>>               by Kishon Vijay Abraham I<kishon@ti.com>
>>>>>
>>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>>>> Signed-off-by: Girish K S <ks.giri@samsung.com>
>>>>> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
>>>>> ---
>>>>>  drivers/phy/Kconfig                      |    6 +
>>>>>  drivers/phy/Makefile                     |    1 +
>>>>>  drivers/phy/exynos/Kconfig               |    5 +
>>>>>  drivers/phy/exynos/Makefile              |    5 +
>>>>>  drivers/phy/exynos/exynos5250_phy_i2c.c  |   53 +++++++
>>>>>  drivers/phy/exynos/sata_phy_exynos5250.c |  248 ++++++++++++++++++++++++++++++
>>>>>  drivers/phy/exynos/sata_phy_exynos5250.h |   33 ++++
>>>>>  7 files changed, 351 insertions(+)
>>>>>  create mode 100644 drivers/phy/exynos/Kconfig
>>>>>  create mode 100644 drivers/phy/exynos/Makefile
>>>>>  create mode 100644 drivers/phy/exynos/exynos5250_phy_i2c.c
>>>>>  create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.c
>>>>>  create mode 100644 drivers/phy/exynos/sata_phy_exynos5250.h
>>>>>
>>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>>> index 5f85909..ab3d1c6 100644
>>>>> --- a/drivers/phy/Kconfig
>>>>> +++ b/drivers/phy/Kconfig
>>>>> @@ -11,3 +11,9 @@ menuconfig GENERIC_PHY
>>>>>         devices present in the kernel. This layer will have the generic
>>>>>         API by which phy drivers can create PHY using the phy framework and
>>>>>         phy users can obtain reference to the PHY.
>>>>> +
>>>>> +if GENERIC_PHY
>>>>
>>>> NAK. Just select GENERIC_PHY from your driver Kconfig.
>>>>> +
>>>>> +source "drivers/phy/exynos/Kconfig"
>>>>> +
>>>>> +endif
>>>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>>>> index 9e9560f..e0223d7 100644
>>>>> --- a/drivers/phy/Makefile
>>>>> +++ b/drivers/phy/Makefile
>>>>> @@ -3,3 +3,4 @@
>>>>>  #
>>>>>
>>>>>  obj-$(CONFIG_GENERIC_PHY)    += phy-core.o
>>>>> +obj-$(CONFIG_PHY_SAMSUNG_SATA)       += exynos/
>>>>
>>>> simply have phy-exynos5250 in drivers/phy.
>>> ok.
>>>>> diff --git a/drivers/phy/exynos/Kconfig b/drivers/phy/exynos/Kconfig
>>>>> new file mode 100644
>>>>> index 0000000..fa125fb
>>>>> --- /dev/null
>>>>> +++ b/drivers/phy/exynos/Kconfig
>>>>> @@ -0,0 +1,5 @@
>>>>> +config PHY_SAMSUNG_SATA
>>>>> +     tristate "Samsung Sata SerDes/PHY driver"
>>>>> +     help
>>>>> +       Support for Samsung sata SerDes/Phy found on Samsung
>>>>> +       SoCs.
>>>>> diff --git a/drivers/phy/exynos/Makefile b/drivers/phy/exynos/Makefile
>>>>> new file mode 100644
>>>>> index 0000000..50dc7eb
>>>>> --- /dev/null
>>>>> +++ b/drivers/phy/exynos/Makefile
>>>>> @@ -0,0 +1,5 @@
>>>>> +#
>>>>> +# Makefile for the exynos phy drivers.
>>>>> +#
>>>>> +ccflags-y := -Idrivers/phy/exynos
>>>>> +obj-$(CONFIG_PHY_SAMSUNG_SATA)       += sata_phy_exynos5250.o exynos5250_phy_i2c.o
>>>>> diff --git a/drivers/phy/exynos/exynos5250_phy_i2c.c b/drivers/phy/exynos/exynos5250_phy_i2c.c
>>>>> new file mode 100644
>>>>> index 0000000..9c75d3b
>>>>> --- /dev/null
>>>>> +++ b/drivers/phy/exynos/exynos5250_phy_i2c.c
>>>>> @@ -0,0 +1,53 @@
>>>>> +/*
>>>>> + * Copyright (C) 2013 Samsung Electronics Co.Ltd
>>>>> + * Author:
>>>>> + *   Yuvaraj C D <yuvaraj.cd@samsung.com>
>>>>> + *
>>>>> + * This program is free software; you can redistribute  it and/or modify it
>>>>> + * under  the terms of  the GNU General  Public License as published by the
>>>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>>>> + * option) any later version.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/i2c.h>
>>>>> +#include <linux/module.h>
>>>>> +#include "sata_phy_exynos5250.h"
>>>>> +
>>>>> +static int exynos_sata_i2c_probe(struct i2c_client *client,
>>>>> +             const struct i2c_device_id *i2c_id)
>>>>> +{
>>>>> +     sataphy_attach_i2c_client(client);
>>>>> +
>>>>> +     dev_info(&client->adapter->dev,
>>>>> +             "attached %s into i2c adapter successfully\n",
>>>>> +             client->name);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int exynos_sata_i2c_remove(struct i2c_client *client)
>>>>> +{
>>>>> +     dev_info(&client->adapter->dev,
>>>>> +             "detached %s from i2c adapter successfully\n",
>>>>> +             client->name);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct i2c_device_id phy_i2c_device_match[] = {
>>>>> +     { "sata-phy-i2c", 0 },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
>>>>> +
>>>>> +struct i2c_driver sataphy_i2c_driver = {
>>>>> +     .probe    = exynos_sata_i2c_probe,
>>>>> +     .id_table = phy_i2c_device_match,
>>>>> +     .remove         = exynos_sata_i2c_remove,
>>>>> +     .driver   = {
>>>>> +             .name = "sata-phy-i2c",
>>>>> +             .owner = THIS_MODULE,
>>>>> +             .of_match_table = (void *)phy_i2c_device_match,
>>>>> +             },
>>>>> +};
>>>>
>>>> As I just mentioned above, we can merge this driver with the below one.
>>> True, Initially it was merged.But already existing drivers of which
>>> are of similar to this kind were done in this way.
>>> Please refer  /drivers/gpu/drm//exynos/exynos_hdmiphy.c
>>
>> Can you point to any discussions where it was decided to go with this approach?
> Sorry,what I meant is exynos_hdmiphy.c is already exist in the
> mainline with this approach.
> 
> Initially it was merged on my local patches(Not upstreamed).But after
> referring to the
> exynos_hdmiphy.c driver and with lot of internal discussions ,it was
> decided to go with

I don't have any idea about the internal discussions whatever you had. IMO
Exynos5250 sata phy driver should be modelled as an i2c client driver if you
don't have a good reason to do otherwise.

Thanks
Kishon

> the already existing approach.
> 
>>
>> Thanks
>> Kishon

