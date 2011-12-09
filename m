From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/3] ide/at91: use new introduce smc accessor
Date: Fri, 09 Dec 2011 15:06:03 +0400
Message-ID: <4EE1EB9B.4080500@mvista.com>
References: <20111208150348.GD23884@game.jcrosoft.org> <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61425 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab1LILHD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2011 06:07:03 -0500
Received: by bkbzv3 with SMTP id zv3so2706656bkb.19
        for <linux-ide@vger.kernel.org>; Fri, 09 Dec 2011 03:07:01 -0800 (PST)
In-Reply-To: <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Hello.

On 08-12-2011 19:23, Jean-Christophe PLAGNIOL-VILLARD wrote:

    Same comment about the subject.

> this will allow to use the pata_at91 on a single zImage

    s/pata_at91/at91_ide/

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> Cc: linux-ide@vger.kernel.org
> ---
> Hi,

> 	it's depends on other patch for AT91 can we apply via at91

    I'm afraid David won't accept this, as the IDE tree is frozen for anything 
but the fixes.

> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> index 41d4155..407595b 100644
> --- a/drivers/ide/at91_ide.c
> +++ b/drivers/ide/at91_ide.c
> @@ -59,41 +59,50 @@
[...]
>   static void set_smc_timings(const u8 chipselect, const u16 cycle,
>   			    const u16 setup, const u16 pulse,
>   			    const u16 data_float, int use_iordy)
>   {
> -	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
> +	struct sam9_smc_config smc;
> +
> +	smc.mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
>   			     AT91_SMC_BAT_SELECT;
>
>   	/* disable or enable waiting for IORDY signal */
>   	if (use_iordy)
> -		mode |= AT91_SMC_EXNWMODE_READY;
> +		smc.mode |= AT91_SMC_EXNWMODE_READY;
>
> -	/* add data float cycles if needed */
> -	if (data_float)
> -		mode |= AT91_SMC_TDF_(data_float);
> +	/* add data ofloat cycles if needed */
> +	smc.tdf_cycles = data_float;
>
> -	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
> +	/* write SMC Setup Register */
> +	smc.nrd_setup = setup;
> +	smc.nwe_setup = smc.nrd_setup;
> +	smc.ncs_read_setup = 0;
> +	smc.ncs_write_setup = smc.ncs_read_setup;

	smc.nrd_setup = smc.nwe_setup = setup;
	smc.ncs_read_setup = smc.ncs_write_setup = 0;

> +	/* write SMC Pulse Register */
> +	smc.nrd_pulse = pulse;
> +	smc.nwe_pulse = smc.nrd_pulse;
> +	smc.ncs_read_pulse = cycle;
> +	smc.ncs_write_pulse = smc.ncs_read_pulse;

	smc.nrd_pulse = smc.nwe_pulse = pulse;
 > +	smc.ncs_read_pulse = smc.ncs_write_pulse = cycle;

> +	/* write SMC Cycle Register */
> +	smc.read_cycle = cycle;
> +	smc.write_cycle = smc.read_cycle;

	smc.read_cycle = smc.write_cycle = cycle;

WBR, Sergei
