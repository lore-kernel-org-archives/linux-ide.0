From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v4] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Sun, 01 Mar 2009 22:11:59 +0300
Message-ID: <49AADDFF.7030804@ru.mvista.com>
References: <200902181107.27095.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53659 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbZCATMJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Mar 2009 14:12:09 -0500
In-Reply-To: <200902181107.27095.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index b753cb8..f048043 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -347,6 +347,111 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  Compact Flash (PCMCIA or IDE)
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
> +    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
> +
> +static struct at91_cf_data cf0_data;
> +
> +static struct resource cf0_resources[] = {
> +	[0] = {
> +		.start	= AT91_CHIPSELECT_4,
> +		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
> +		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
> +	}
> +};
> +
> +static struct platform_device cf0_device = {
> +	.id		= 0,
> +	.dev		= {
> +				.platform_data	= &cf0_data,
> +	},
> +	.resource	= cf0_resources,
> +	.num_resources	= ARRAY_SIZE(cf0_resources),
> +};
> +
> +static struct at91_cf_data cf1_data;
> +
> +static struct resource cf1_resources[] = {
> +	[0] = {
> +		.start	= AT91_CHIPSELECT_5,
> +		.end	= AT91_CHIPSELECT_5 + SZ_256M - 1,
> +		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
> +	}
> +};
> +
> +static struct platform_device cf1_device = {
> +	.id		= 1,
> +	.dev		= {
> +				.platform_data	= &cf1_data,
> +	},
> +	.resource	= cf1_resources,
> +	.num_resources	= ARRAY_SIZE(cf1_resources),
> +};
> +
> +void __init at91_add_device_cf(struct at91_cf_data *data)
> +{
> +	unsigned long ebi0_csa;
> +	struct platform_device *pdev;
> +
> +	if (!data)
> +		return;
> +
> +	/*
> +	 * assign CS4 or CS5 to SMC with Compact Flash logic support,
> +	 * we assume SMC timings are configured by board code,
> +	 * except True IDE where timings are controlled by driver
> +	 */
> +	ebi0_csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
> +	switch (data->chipselect) {
> +	case 4:
> +		at91_set_A_periph(AT91_PIN_PD6, 0);  /* EBI0_NCS4/CFCS0 */
> +		ebi0_csa |= AT91_MATRIX_EBI0_CS4A_SMC_CF1;
> +		cf0_data = *data;
> +		pdev = &cf0_device;
> +		break;
> +	case 5:
> +		at91_set_A_periph(AT91_PIN_PD7, 0);  /* EBI0_NCS5/CFCS1 */
> +		ebi0_csa |= AT91_MATRIX_EBI0_CS5A_SMC_CF2;
> +		cf1_data = *data;
> +		pdev = &cf1_device;
> +		break;
> +	default:
> +		printk(KERN_ERR "AT91 CF: bad chip-select requested (%u)\n",
> +		       data->chipselect);
> +		return;
> +	}
> +	at91_sys_write(AT91_MATRIX_EBI0CSA, ebi0_csa);
> +
> +	if (data->det_pin) {
> +		at91_set_gpio_input(data->det_pin, 1);
> +		at91_set_deglitch(data->det_pin, 1);
> +	}
> +
> +	if (data->irq_pin) {
> +		at91_set_gpio_input(data->irq_pin, 1);
> +		at91_set_deglitch(data->irq_pin, 1);
> +	}
> +
> +	if (data->vcc_pin)
> +		/* initially off */
> +		at91_set_gpio_output(data->vcc_pin, 0);
> +
> +	/* enable EBI controlled pins */
> +	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
> +	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
> +	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
> +	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
> +
> +	pdev->name = (data->flags & AT91_CF_TRUE_IDE) ? "at91_ide" : "at91_cf";
>   

  Could as well just passed the name to this function...

MBR, Sergei


