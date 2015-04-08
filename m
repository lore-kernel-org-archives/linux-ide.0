From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/9] ata: at91: use syscon to configure the smc
Date: Wed, 08 Apr 2015 13:04:19 +0200
Message-ID: <2936706.hVbBP0ExQQ@amdc1032>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427138955-3617-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44128 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbDHLEg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 07:04:36 -0400
In-reply-to: <1427138955-3617-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>


Hi,

On Monday, March 23, 2015 08:29:07 PM Alexandre Belloni wrote:
> Use syscon/regmap to configure the smc. This allows to avoid using
> at91sam9_smc.h and to compile the driver in a multiplatform configuration.
> 
> The driver will still not probe until the proper DT bindings are added. That
> binding will include an atmel,smc property that is a phandle to the SMC the CF
> controller is connected to.

If the driver is currently working fine in !ARCH_MULTIPLATFORM
configuration then this patch will make it non-functional until
atmel,smc property is added to DT.  To prevent this and preserve
bisectability the patchset should first add atmel,smc property
and then convert pata_at91 driver to use it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/ata/Kconfig     |  1 -
>  drivers/ata/pata_at91.c | 92 ++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 71 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5f601553b9b0..a3a13605a9c4 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -835,7 +835,6 @@ config PATA_AT32
>  config PATA_AT91
>  	tristate "PATA support for AT91SAM9260"
>  	depends on ARM && SOC_AT91SAM9
> -	depends on !ARCH_MULTIPLATFORM
>  	help
>  	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.
>  
> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> index 9e85937d36a9..ace0a4de3449 100644
> --- a/drivers/ata/pata_at91.c
> +++ b/drivers/ata/pata_at91.c
> @@ -24,11 +24,13 @@
>  #include <linux/ata.h>
>  #include <linux/clk.h>
>  #include <linux/libata.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/atmel-smc.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/platform_data/atmel.h>
> +#include <linux/regmap.h>
>  
> -#include <mach/at91sam9_smc.h>
>  #include <asm/gpio.h>
>  
>  #define DRV_NAME		"pata_at91"
> @@ -57,6 +59,15 @@ struct smc_range {
>  	int max;
>  };
>  
> +struct regmap *smc;
> +
> +struct at91sam9_smc_generic_fields {
> +	struct regmap_field *setup;
> +	struct regmap_field *pulse;
> +	struct regmap_field *cycle;
> +	struct regmap_field *mode;
> +} fields;
> +
>  /**
>   * adjust_smc_value - adjust value for one of SMC registers.
>   * @value: adjusted value
> @@ -206,7 +217,6 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
>  {
>  	int ret = 0;
>  	int use_iordy;
> -	struct sam9_smc_config smc;
>  	unsigned int t6z;         /* data tristate time in ns */
>  	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
>  	unsigned int setup;       /* SMC Setup width in MCK ticks */
> @@ -244,19 +254,21 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
>  
>  	dev_dbg(dev, "Use IORDY=%u, TDF Cycles=%u\n", use_iordy, tdf_cycles);
>  
> -	/* SMC Setup Register */
> -	smc.nwe_setup = smc.nrd_setup = setup;
> -	smc.ncs_write_setup = smc.ncs_read_setup = 0;
> -	/* SMC Pulse Register */
> -	smc.nwe_pulse = smc.nrd_pulse = pulse;
> -	smc.ncs_write_pulse = smc.ncs_read_pulse = cs_pulse;
> -	/* SMC Cycle Register */
> -	smc.write_cycle = smc.read_cycle = cycle;
> -	/* SMC Mode Register*/
> -	smc.tdf_cycles = tdf_cycles;
> -	smc.mode = info->mode;
> -
> -	sam9_smc_configure(0, info->cs, &smc);
> +	regmap_fields_write(fields.setup, info->cs,
> +			    AT91SAM9_SMC_NRDSETUP(setup) |
> +			    AT91SAM9_SMC_NWESETUP(setup) |
> +			    AT91SAM9_SMC_NCS_NRDSETUP(0) |
> +			    AT91SAM9_SMC_NCS_WRSETUP(0));
> +	regmap_fields_write(fields.pulse, info->cs,
> +			    AT91SAM9_SMC_NRDPULSE(pulse) |
> +			    AT91SAM9_SMC_NWEPULSE(pulse) |
> +			    AT91SAM9_SMC_NCS_NRDPULSE(cs_pulse) |
> +			    AT91SAM9_SMC_NCS_WRPULSE(cs_pulse));
> +	regmap_fields_write(fields.cycle, info->cs,
> +			    AT91SAM9_SMC_NRDCYCLE(cycle) |
> +			    AT91SAM9_SMC_NWECYCLE(cycle));
> +	regmap_fields_write(fields.mode, info->cs, info->mode |
> +			    AT91_SMC_TDF_(tdf_cycles));
>  }
>  
>  static void pata_at91_set_piomode(struct ata_port *ap, struct ata_device *adev)
> @@ -280,21 +292,21 @@ static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
>  {
>  	struct at91_ide_info *info = dev->link->ap->host->private_data;
>  	unsigned int consumed;
> +	unsigned int mode;
>  	unsigned long flags;
> -	struct sam9_smc_config smc;
>  
>  	local_irq_save(flags);
> -	sam9_smc_read_mode(0, info->cs, &smc);
> +	regmap_fields_read(fields.mode, info->cs, &mode);
>  
>  	/* set 16bit mode before writing data */
> -	smc.mode = (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16;
> -	sam9_smc_write_mode(0, info->cs, &smc);
> +	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
> +			    AT91_SMC_DBW_16);
>  
>  	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
>  
>  	/* restore 8bit mode after data is written */
> -	smc.mode = (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8;
> -	sam9_smc_write_mode(0, info->cs, &smc);
> +	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
> +			    AT91_SMC_DBW_8);
>  
>  	local_irq_restore(flags);
>  	return consumed;
> @@ -312,6 +324,36 @@ static struct ata_port_operations pata_at91_port_ops = {
>  	.cable_detect	= ata_cable_40wire,
>  };
>  
> +static int at91sam9_smc_fields_init(struct device *dev)
> +{
> +	struct reg_field field = REG_FIELD(0, 0, 31);
> +
> +	field.id_size = 8;
> +	field.id_offset = AT91SAM9_SMC_GENERIC_BLK_SZ;
> +
> +	field.reg = AT91SAM9_SMC_SETUP(AT91SAM9_SMC_GENERIC);
> +	fields.setup = devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.setup))
> +		return PTR_ERR(fields.setup);
> +
> +	field.reg = AT91SAM9_SMC_PULSE(AT91SAM9_SMC_GENERIC);
> +	fields.pulse = devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.pulse))
> +		return PTR_ERR(fields.pulse);
> +
> +	field.reg = AT91SAM9_SMC_CYCLE(AT91SAM9_SMC_GENERIC);
> +	fields.cycle = devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.cycle))
> +		return PTR_ERR(fields.cycle);
> +
> +	field.reg = AT91SAM9_SMC_MODE(AT91SAM9_SMC_GENERIC);
> +	fields.mode = devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.mode))
> +		return PTR_ERR(fields.mode);
> +
> +	return 0;
> +}
> +
>  static int pata_at91_probe(struct platform_device *pdev)
>  {
>  	struct at91_cf_data *board = dev_get_platdata(&pdev->dev);
> @@ -341,6 +383,14 @@ static int pata_at91_probe(struct platform_device *pdev)
>  
>  	irq = board->irq_pin;
>  
> +	smc = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "atmel,smc");
> +	if (IS_ERR(smc))
> +		return PTR_ERR(smc);
> +
> +	ret = at91sam9_smc_fields_init(dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* init ata host */
>  
>  	host = ata_host_alloc(dev, 1);

