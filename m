From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 1/5] libata: pata_samsung: Add Samsung PATA controller
 driver
Date: Wed, 09 Jun 2010 13:31:23 -0400
Message-ID: <4C0FCFEB.6030603@pobox.com>
References: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com> <1275988020-29000-2-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1275988020-29000-2-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

On 06/08/2010 05:06 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan<a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   drivers/ata/Kconfig           |    9 +
>   drivers/ata/Makefile          |    1 +
>   drivers/ata/pata_samsung_cf.c |  608 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 618 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/pata_samsung_cf.c

Looks OK to me, minor nits only...



> +#define DRV_NAME "pata_samsung"

this should be "pata_samsung_cf"


> +static void pata_s3c_hwinit(struct s3c_ide_info *info,
> +				struct s3c_ide_platdata *pdata)
> +{
> +	switch (info->cpu_type) {
> +	case TYPE_S3C64XX:
> +		/* Configure as big endian */
> +		pata_s3c_cfg_mode(info->sfr_addr);
> +		pata_s3c_set_endian(info->ide_addr, 1);
> +		pata_s3c_enable(info->ide_addr, 1);
> +		mdelay(100);
> +
> +		/* Remove IRQ Status */
> +		writel(0x1f, info->ide_addr + S3C_ATA_IRQ);
> +		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
> +	break;
> +
> +	case TYPE_S5PC100:
> +		pata_s3c_cfg_mode(info->sfr_addr);
> +
> +	case TYPE_S5PV210:
> +		/* Configure as little endian */
> +		pata_s3c_set_endian(info->ide_addr, 0);
> +		pata_s3c_enable(info->ide_addr, 1);
> +		mdelay(100);
> +
> +		/* Remove IRQ Status */
> +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ);
> +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ_MSK);
> +	break;
> +
> +	default:
> +		BUG();

Use of msleep() is preferred, in cases where you can sleep (such as this)
