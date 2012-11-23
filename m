From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH v2 3/6] DRIVERS: ATA: SATA PHY utility framework
Date: Fri, 23 Nov 2012 14:20:55 +0530
Message-ID: <CAK1UHizJSK_RCNRYSOCQnFx-ZNjA+Z3OTYGgR0cnTqdfbaeW9g@mail.gmail.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
	<1351612897-14923-4-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50475 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757911Ab2KWIu4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2012 03:50:56 -0500
In-Reply-To: <1351612897-14923-4-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>, kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-i2c@vger.kernel.org

Hi,

Missed to include Ben, for I2C patch, including him and copying others.

Thanks,
Vasanth.

On Tue, Oct 30, 2012 at 9:31 PM, Vasanth Ananthan
<vasanthananthan@gmail.com> wrote:
> This patch adds SATA PHY utility framework APIs. The framework acts as an
> interface between the SATA device and the PHY device. The SATA PHY device
> registers itself with the framework through the APIs provided and the SATA
> device finds and requests for an appropriate PHY device.
>
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  drivers/ata/Kconfig    |   10 +++++
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_phy.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/sata_phy.h |   44 ++++++++++++++++++++
>  4 files changed, 159 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_phy.c
>  create mode 100644 drivers/ata/sata_phy.h
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e08d322..e3a2972 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -83,6 +83,16 @@ config SATA_AHCI_PLATFORM
>
>           If unsure, say N.
>
> +config SATA_PHY
> +       bool "SATA PHY Framework"
> +       default n
> +       help
> +         This option enables the SATA PHY utility framework APIs.
> +         The framework acts as an interface between the SATA device
> +         and the PHY device. The SATA PHY device registers itself
> +         with the framework through the APIs provided and the SATA
> +         device finds and requests for an appropriate PHY device.
> +
>  config SATA_FSL
>         tristate "Freescale 3.0Gbps SATA support"
>         depends on FSL_SOC
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 9329daf..3d219a9 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)   += sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)       += sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)         += sata_dwc_460ex.o
>  obj-$(CONFIG_SATA_HIGHBANK)    += sata_highbank.o libahci.o
> +obj-$(CONFIG_SATA_PHY)         += sata_phy.o
>
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)         += pdc_adma.o
> diff --git a/drivers/ata/sata_phy.c b/drivers/ata/sata_phy.c
> new file mode 100644
> index 0000000..e5631a9
> --- /dev/null
> +++ b/drivers/ata/sata_phy.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com
> + *
> + * EXYNOS - SATA utility framework.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include "sata_phy.h"
> +
> +static LIST_HEAD(phy_list);
> +static DEFINE_SPINLOCK(phy_lock);
> +
> +struct sata_phy *sata_get_phy(enum sata_phy_type type)
> +{
> +       struct sata_phy *x = NULL;
> +       unsigned long flag;
> +
> +       if (list_empty(&phy_list))
> +               return x;
> +
> +       spin_lock_irqsave(&phy_lock, flag);
> +
> +       list_for_each_entry(x, &phy_list, head) {
> +               if (x->type == type) {
> +                       get_device(x->dev);
> +                       break;
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&phy_lock, flag);
> +       return x;
> +}
> +EXPORT_SYMBOL(sata_get_phy);
> +
> +int sata_add_phy(struct sata_phy *phy, enum sata_phy_type type)
> +{
> +       unsigned long flag;
> +       unsigned int ret = -EINVAL;
> +       struct sata_phy *x;
> +
> +       spin_lock_irqsave(&phy_lock, flag);
> +
> +       if (!phy)
> +               return ret;
> +
> +       list_for_each_entry(x, &phy_list, head) {
> +               if (x->type == type) {
> +                       dev_err(phy->dev, "transceiver type already exists\n");
> +                       goto out;
> +               }
> +       }
> +       phy->type = type;
> +       list_add_tail(&phy->head, &phy_list);
> +       ret = 0;
> +
> + out:
> +       spin_unlock_irqrestore(&phy_lock, flag);
> +       return ret;
> +}
> +EXPORT_SYMBOL(sata_add_phy);
> +
> +void sata_remove_phy(struct sata_phy *phy)
> +{
> +       unsigned long flag;
> +       struct sata_phy *x;
> +
> +       spin_lock_irqsave(&phy_lock, flag);
> +
> +       if (!phy)
> +               return;
> +
> +       list_for_each_entry(x, &phy_list, head) {
> +               if (x->type == phy->type)
> +                       list_del(&phy->head);
> +       }
> +
> +       spin_unlock_irqrestore(&phy_lock, flag);
> +}
> +EXPORT_SYMBOL(sata_remove_phy);
> +
> +void sata_put_phy(struct sata_phy *phy)
> +{
> +       unsigned long flag;
> +
> +       spin_lock_irqsave(&phy_lock, flag);
> +
> +       if (!phy)
> +               return;
> +
> +       put_device(phy->dev);
> +       spin_unlock_irqrestore(&phy_lock, flag);
> +
> +}
> +EXPORT_SYMBOL(sata_put_phy);
> diff --git a/drivers/ata/sata_phy.h b/drivers/ata/sata_phy.h
> new file mode 100644
> index 0000000..dc38683
> --- /dev/null
> +++ b/drivers/ata/sata_phy.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com
> + *
> + * EXYNOS - SATA utility framework definitions.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +enum sata_phy_type {
> +       SATA_PHY_GENERATION1,
> +       SATA_PHY_GENERATION2,
> +       SATA_PHY_GENERATION3,
> +};
> +
> +struct sata_phy {
> +       int (*init) (struct sata_phy *);
> +       int (*shutdown) (struct sata_phy *);
> +       struct device *dev;
> +       void *priv_data;
> +       enum sata_phy_type type;
> +       struct list_head head;
> +};
> +
> +static inline int sata_init_phy(struct sata_phy *x)
> +{
> +       if (x && x->init)
> +               return x->init(x);
> +
> +       return -EINVAL;
> +}
> +
> +static inline void sata_shutdown_phy(struct sata_phy *x)
> +{
> +       if (x && x->shutdown)
> +               x->shutdown(x);
> +}
> +
> +struct sata_phy *sata_get_phy(enum sata_phy_type);
> +int sata_add_phy(struct sata_phy *, enum sata_phy_type);
> +void sata_remove_phy(struct sata_phy *);
> +void sata_put_phy(struct sata_phy *);
> --
> 1.7.4.1
>



-- 
Regards,

Vasanth K A
