From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263
 cpu
Date: Wed, 11 Feb 2009 16:59:00 +0300
Message-ID: <4992D9A4.30205@ru.mvista.com>
References: <200902091145.11266.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:6806 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753084AbZBKN7G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 08:59:06 -0500
In-Reply-To: <200902091145.11266.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> index b753cb8..8e46abe 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
>   
[...]
> +void __init at91_add_device_cf(struct at91_cf_data *data)
> +{
> +	unsigned long ebi0_csa, addr_space;
>   
[...]
> +	if (data->flags & AT91_CF_TRUE_IDE) {
> +		/* check if device is present */
> +		if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
> +			printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
> +			return;
> +		}
> +		if (data->rst_pin) {
> +			/* reset the card */
> +			at91_set_gpio_output(data->rst_pin, 0);
> +			/* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
> +			udelay(25);
> +			at91_set_gpio_output(data->rst_pin, 1);
>   

   I'm still not sure why this is needed. Do you think thta power-on 
reset is not enough?

MBR, Sergei


