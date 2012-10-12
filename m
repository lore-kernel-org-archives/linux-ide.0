From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 3/6] DRIVERS: ATA: SATA PHY utility framework
Date: Sat, 13 Oct 2012 00:30:17 +0200
Message-ID: <2368802.eUtXvopXao@flatron>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com> <1349783332-18467-4-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1349783332-18467-4-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi Vasanth, 

On Tuesday 09 of October 2012 17:18:49 Vasanth Ananthan wrote:
> This patch adds SATA PHY utility framework APIs. The framework acts as
> an interface between the SATA device and the PHY device. The SATA PHY
> device registers itself with the framework through the APIs provided
> and the SATA device finds and requests for an appropriate PHY device.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  drivers/ata/Kconfig    |    9 ++++
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_phy.c |   99
> ++++++++++++++++++++++++++++++++++++++++++++++++ drivers/ata/sata_phy.h
> |   44 +++++++++++++++++++++
>  4 files changed, 153 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_phy.c
>  create mode 100644 drivers/ata/sata_phy.h
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 27cecd3..0344b78 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -83,6 +83,15 @@ config SATA_AHCI_PLATFORM
> 
>  	  If unsure, say N.
> 
> +config SATA_EXYNOS
> +	bool "Exynos SATA AHCI support"
> +	depends on I2C_S3C2410
> +	help
> +          This option enables support for Exynos AHCI Serial ATA
> +          controllers.
> +
> +          If unsure, say N.
> +
>  config SATA_FSL
>  	tristate "Freescale 3.0Gbps SATA support"
>  	depends on FSL_SOC
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index a454a13..bf3fd91 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
> +obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o libahci.o


If the framework introduced by this patch is supposed to be generic, maybe 
a new Kconfig entry should be created for it, like CONFIG_SATA_PHY, which 
would be selected by any drivers using it?

> 
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/sata_phy.c b/drivers/ata/sata_phy.c
> new file mode 100644
> index 0000000..dbb4aa3
> --- /dev/null
> +++ b/drivers/ata/sata_phy.c
> @@ -0,0 +1,99 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com
> + *
> + * EXYNOS - SATA utility framework.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as +
> * published by the Free Software Foundation.
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
> +	struct sata_phy *x = NULL;
> +	unsigned long flag;
> +
> +	spin_lock_irqsave(&phy_lock, flag);
> +
> +	list_for_each_entry(x, &phy_list, head) {
> +		if (x->type == type) {
> +			get_device(x->dev);
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&phy_lock, flag);
> +	return x;
> +}
> +EXPORT_SYMBOL(sata_get_phy);
> +
> +int sata_add_phy(struct sata_phy *phy, enum sata_phy_type type)
> +{
> +	unsigned long flag;
> +	unsigned int ret = -EINVAL;
> +	struct sata_phy *x;

If you need to handle the situation when phy is NULL here, then why not 
to:

	if (!phy)
		return -EINVAL;

and then make the code below unconditional?

> +
> +	spin_lock_irqsave(&phy_lock, flag);
> +
> +	if (phy) {
> +
> +		list_for_each_entry(x, &phy_list, head) {
> +			if (x->type == type) {
> +				dev_err(phy->dev, "transceiver type already 
exists\n");
> +				goto out;
> +			}
> +		}
> +		phy->type = type;
> +		list_add_tail(&phy->head, &phy_list);
> +		ret = 0;
> +	}
> +
> + out:
> +	spin_unlock_irqrestore(&phy_lock, flag);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sata_add_phy);
> +
> +void sata_remove_phy(struct sata_phy *phy)
> +{
> +	unsigned long flag;
> +	struct sata_phy *x;

Same here.

Best regards,
Tomasz Figa
