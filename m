From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 03/10] ata: at91: use syscon to configure the smc
Date: Mon, 23 Mar 2015 11:11:35 +0100
Message-ID: <550FE6D7.6000107@atmel.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com> <1426545886-19162-4-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:26018 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbCWKLi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2015 06:11:38 -0400
In-Reply-To: <1426545886-19162-4-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Le 16/03/2015 23:44, Alexandre Belloni a =E9crit :
> Use syscon/regmap to configure the smc. This allows to avoid using
> at91sam9_smc.h and to compile the driver in a multiplatform configura=
tion.
>=20
> The driver will still not probe until the proper DT bindings are adde=
d.

Alexandre, just for the record, can you describe the DT node that will
match this?
Is it one that will be added to
Documentation/devicetree/bindings/mfd/atmel-smc.txt?

=2E..

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> ---
>  drivers/ata/Kconfig     |  1 -
>  drivers/ata/pata_at91.c | 92 ++++++++++++++++++++++++++++++++++++++-=
----------
>  2 files changed, 71 insertions(+), 22 deletions(-)
>=20
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
>  	  This option enables support for IDE devices on the Atmel AT91SAM9=
260 SoC.
> =20
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
> =20
> -#include <mach/at91sam9_smc.h>
>  #include <asm/gpio.h>
> =20
>  #define DRV_NAME		"pata_at91"
> @@ -57,6 +59,15 @@ struct smc_range {
>  	int max;
>  };
> =20
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
> @@ -206,7 +217,6 @@ static void set_smc_timing(struct device *dev, st=
ruct ata_device *adev,
>  {
>  	int ret =3D 0;
>  	int use_iordy;
> -	struct sam9_smc_config smc;
>  	unsigned int t6z;         /* data tristate time in ns */
>  	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
>  	unsigned int setup;       /* SMC Setup width in MCK ticks */
> @@ -244,19 +254,21 @@ static void set_smc_timing(struct device *dev, =
struct ata_device *adev,
> =20
>  	dev_dbg(dev, "Use IORDY=3D%u, TDF Cycles=3D%u\n", use_iordy, tdf_cy=
cles);
> =20
> -	/* SMC Setup Register */
> -	smc.nwe_setup =3D smc.nrd_setup =3D setup;
> -	smc.ncs_write_setup =3D smc.ncs_read_setup =3D 0;
> -	/* SMC Pulse Register */
> -	smc.nwe_pulse =3D smc.nrd_pulse =3D pulse;
> -	smc.ncs_write_pulse =3D smc.ncs_read_pulse =3D cs_pulse;
> -	/* SMC Cycle Register */
> -	smc.write_cycle =3D smc.read_cycle =3D cycle;
> -	/* SMC Mode Register*/
> -	smc.tdf_cycles =3D tdf_cycles;
> -	smc.mode =3D info->mode;
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
> =20
>  static void pata_at91_set_piomode(struct ata_port *ap, struct ata_de=
vice *adev)
> @@ -280,21 +292,21 @@ static unsigned int pata_at91_data_xfer_noirq(s=
truct ata_device *dev,
>  {
>  	struct at91_ide_info *info =3D dev->link->ap->host->private_data;
>  	unsigned int consumed;
> +	unsigned int mode;
>  	unsigned long flags;
> -	struct sam9_smc_config smc;
> =20
>  	local_irq_save(flags);
> -	sam9_smc_read_mode(0, info->cs, &smc);
> +	regmap_fields_read(fields.mode, info->cs, &mode);
> =20
>  	/* set 16bit mode before writing data */
> -	smc.mode =3D (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16;
> -	sam9_smc_write_mode(0, info->cs, &smc);
> +	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
> +			    AT91_SMC_DBW_16);
> =20
>  	consumed =3D ata_sff_data_xfer(dev, buf, buflen, rw);
> =20
>  	/* restore 8bit mode after data is written */
> -	smc.mode =3D (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8;
> -	sam9_smc_write_mode(0, info->cs, &smc);
> +	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
> +			    AT91_SMC_DBW_8);
> =20
>  	local_irq_restore(flags);
>  	return consumed;
> @@ -312,6 +324,36 @@ static struct ata_port_operations pata_at91_port=
_ops =3D {
>  	.cable_detect	=3D ata_cable_40wire,
>  };
> =20
> +static int at91sam9_smc_fields_init(struct device *dev)
> +{
> +	struct reg_field field =3D REG_FIELD(0, 0, 31);
> +
> +	field.id_size =3D 8;
> +	field.id_offset =3D AT91SAM9_SMC_GENERIC_BLK_SZ;
> +
> +	field.reg =3D AT91SAM9_SMC_SETUP(AT91SAM9_SMC_GENERIC);
> +	fields.setup =3D devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.setup))
> +		return PTR_ERR(fields.setup);
> +
> +	field.reg =3D AT91SAM9_SMC_PULSE(AT91SAM9_SMC_GENERIC);
> +	fields.pulse =3D devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.pulse))
> +		return PTR_ERR(fields.pulse);
> +
> +	field.reg =3D AT91SAM9_SMC_CYCLE(AT91SAM9_SMC_GENERIC);
> +	fields.cycle =3D devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.cycle))
> +		return PTR_ERR(fields.cycle);
> +
> +	field.reg =3D AT91SAM9_SMC_MODE(AT91SAM9_SMC_GENERIC);
> +	fields.mode =3D devm_regmap_field_alloc(dev, smc, field);
> +	if (IS_ERR(fields.mode))
> +		return PTR_ERR(fields.mode);
> +
> +	return 0;
> +}
> +
>  static int pata_at91_probe(struct platform_device *pdev)
>  {
>  	struct at91_cf_data *board =3D dev_get_platdata(&pdev->dev);
> @@ -341,6 +383,14 @@ static int pata_at91_probe(struct platform_devic=
e *pdev)
> =20
>  	irq =3D board->irq_pin;
> =20
> +	smc =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "atmel,s=
mc");

=2E.. yes, regarding this string "atmel,smc": what will it match?

Thanks, bye.

> +	if (IS_ERR(smc))
> +		return PTR_ERR(smc);
> +
> +	ret =3D at91sam9_smc_fields_init(dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* init ata host */
> =20
>  	host =3D ata_host_alloc(dev, 1);
>=20


--=20
Nicolas Ferre
