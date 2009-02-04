From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Wed, 04 Feb 2009 15:18:05 +0300
Message-ID: <4989877D.6020401@ru.mvista.com>
References: <200902031147.41822.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15869 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751311AbZBDMSL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 07:18:11 -0500
In-Reply-To: <200902031147.41822.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   
[...]
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index b753cb8..503651a 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -347,6 +347,103 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  IDE
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
> +
> +/* Proper CS address space will be added */
> +#define AT91_IDE_TASK_FILE	0x00c00000
> +#define AT91_IDE_CTRL_REG	0x00e00000
>   

   Why are you assuming that these offsets are not board specifec I 
wonder? Theyu clearly depend on how the -CSx were wired on the board -- 
it's the same board specific data as your IRQ.

> +void __init at91_add_device_ide(struct at91_ide_data *data)
> +{
>   
[...]
> +	/* assign CS4/5 to SMC with Compact Flash logic support
> +	 * and fix resources addresses */
>   

   It again seems like board specific configuration...

> +	ebi0_csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
> +	switch (chipselect) {
> +	case 4:
> +		at91_set_A_periph(AT91_PIN_PD6, 0);  /* EBI0_NCS4/CFCS0 */
> +		ebi0_csa |= AT91_MATRIX_EBI0_CS4A_SMC_CF1;
> +		addr_space = AT91_CHIPSELECT_4;
> +		break;
> +	case 5:
> +		at91_set_A_periph(AT91_PIN_PD7, 0);  /* EBI0_NCS5/CFCS1 */
> +		ebi0_csa |= AT91_MATRIX_EBI0_CS5A_SMC_CF2;
> +		addr_space = AT91_CHIPSELECT_5;
> +		break;
> +	default:
> +		printk(KERN_ERR "at91_ide: bad chip select %u\n", chipselect);
>   
> +		return;
>   

  Why do you consider it bad? Is there some SMC limitation or what?

MBR, Sergei


