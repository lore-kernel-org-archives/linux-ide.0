From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v2] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Fri, 06 Feb 2009 15:03:54 +0300
Message-ID: <498C272A.5070101@ru.mvista.com>
References: <200902061214.19789.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:18703 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752721AbZBFMD7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 07:03:59 -0500
In-Reply-To: <200902061214.19789.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   
[...]
> @@ -347,6 +348,111 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  Compact Flash (PCMCIA or IDE)
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
> +    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
>   

   Ugh... what are trying to achieve with this, marginal memory save?

> +static struct resource cf_resources[] = {
> +	[0] = {
> +		.start	= 0,
> +		.end	= 0,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct at91_cf_data cf_data;
> +
> +static struct platform_device at91_cf_device = {
> +	.id 	= -1,
> +	.dev	= {
> +		.platform_data = &cf_data,
> +	},
> +	.resource = cf_resources,
> +	.num_resources = ARRAY_SIZE(cf_resources),
> +};
> +
> +void __init at91_add_device_cf(struct at91_cf_data *data)
> +{
>   
[...]
> +	cf_resources[0].start = addr_space;
> +	cf_resources[0].end = addr_space + SZ_256M - 1;
>   

   In the datasheet the CF mode address space is just 0x1000000, i.e. 16 
MB, not 256. Moreover, address lines above A22 are not connected to CF 
at all.

> +
> +	if (data->det_pin) {
> +		/* check if device is present */
> +		at91_set_gpio_input(data->det_pin, 1);
> +		at91_set_deglitch(data->det_pin, 1);
> +		if (at91_get_gpio_value(data->det_pin) != 0) {
> +			printk(KERN_ERR "AT91: no CF card detected\n");
> +			return;
> +		}
> +	}
>   

   Bart, I'm not sure: don't we support warm-plug now? Or it won't avail 
us with CF?

> +	if (data->rst_pin) {
> +		/* reset the card */
> +		int reset = (data->flags & AT91_CF_TRUE_IDE) ? 0 : 1;
> +
> +		at91_set_gpio_output(data->rst_pin, reset);
> +		udelay(25); /* taken from ATA docs, CFA not specify it ? */
> +		at91_set_gpio_output(data->rst_pin, !reset);
> +	}
>   

   Is there really a need to hard reset CF on every reboot?

> +	if (data->vcc_pin)
> +		/* initially off */
> +		at91_set_gpio_output(data->vcc_pin, 0);
>   

   Why? Moreover, resetting CF without power applied (or cutting off 
power afterwards) just doesn't make sense...

MBR, Sergei


