From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: Move plat/regs-ata.h to
 drivers/ata
Date: Tue, 31 Dec 2013 15:32:58 +0900
Message-ID: <001101cf05f2$25901da0$70b058e0$%han@samsung.com>
References: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57932 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab3LaGdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Dec 2013 01:33:00 -0500
In-reply-to: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, patches@linaro.org, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, December 31, 2013 2:29 PM, Sachin Kamat wrote:
> 
> plat/regs-ata.h is used only by Samsung PATA driver.
> Move this file to the drivers folder to remove platform
> dependency required for multiplatform support.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/ata/pata_samsung_cf.c                      |    2 +-
>  .../regs-ata.h => drivers/ata/pata_samsung_cf.h    |    9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/regs-ata.h => drivers/ata/pata_samsung_cf.h (91%)
> 
> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> index 898e544a7ae8..e04d70b7ce76 100644
> --- a/drivers/ata/pata_samsung_cf.c
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -24,7 +24,7 @@
>  #include <linux/slab.h>
> 
>  #include <linux/platform_data/ata-samsung_cf.h>
> -#include <plat/regs-ata.h>
> +#include "pata_samsung_cf.h"
> 
>  #define DRV_NAME "pata_samsung_cf"
>  #define DRV_VERSION "0.1"
> diff --git a/arch/arm/plat-samsung/include/plat/regs-ata.h b/drivers/ata/pata_samsung_cf.h
> similarity index 91%
> rename from arch/arm/plat-samsung/include/plat/regs-ata.h
> rename to drivers/ata/pata_samsung_cf.h
> index f5df92fdae26..eeefe2e0cdc6 100644
> --- a/arch/arm/plat-samsung/include/plat/regs-ata.h
> +++ b/drivers/ata/pata_samsung_cf.h
> @@ -1,5 +1,4 @@
> -/* linux/arch/arm/plat-samsung/include/plat/regs-ata.h
> - *
> +/*
>   * Copyright (c) 2010 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com
>   *
> @@ -10,8 +9,8 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#ifndef __ASM_PLAT_REGS_ATA_H
> -#define __ASM_PLAT_REGS_ATA_H __FILE__
> +#ifndef __PATA_SAMSUNG_CF_H
> +#define __PATA_SAMSUNG_CF_H
> 
>  #define S3C_CFATA_REG(x)	(x)
> 
> @@ -53,4 +52,4 @@
>  #define S3C_ATA_CFG_SWAP	0x40
>  #define S3C_ATA_CFG_IORDYEN	0x02
> 
> -#endif /* __ASM_PLAT_REGS_ATA_H */
> +#endif /* __PATA_SAMSUNG_CF_H */
> --
> 1.7.9.5
> 
> --

