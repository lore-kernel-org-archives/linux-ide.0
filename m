From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/3] pata/at91: use new introduce smc accessor
Date: Fri, 09 Dec 2011 14:59:49 +0400
Message-ID: <4EE1EA25.3010002@mvista.com>
References: <20111208150348.GD23884@game.jcrosoft.org> <1323357784-17555-2-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38039 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab1LILAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2011 06:00:48 -0500
Received: by bkbzv3 with SMTP id zv3so2699950bkb.19
        for <linux-ide@vger.kernel.org>; Fri, 09 Dec 2011 03:00:47 -0800 (PST)
In-Reply-To: <1323357784-17555-2-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Hello.

On 08-12-2011 19:23, Jean-Christophe PLAGNIOL-VILLARD wrote:

    Your subject doesn't parse. Maybe you meant "use newly introduced smc 
accessor"?

> this will allow to use the pata_at91 on a single zImage

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> Cc: linux-ide@vger.kernel.org
> ---
> Hi,

> 	it's depends on other patch for AT91 can we apply via at91

> Best Regards,
> J.
>   drivers/ata/pata_at91.c |   43 +++++++++++++++++++++----------------------
>   1 files changed, 21 insertions(+), 22 deletions(-)

> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> index 5249e6d..c8d1154 100644
> --- a/drivers/ata/pata_at91.c
> +++ b/drivers/ata/pata_at91.c
> @@ -207,11 +207,11 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
>   {
>   	int ret = 0;
>   	int use_iordy;
> +	struct sam9_smc_config smc;
>   	unsigned int t6z;         /* data tristate time in ns */
>   	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
>   	unsigned int setup;       /* SMC Setup width in MCK ticks */
>   	unsigned int pulse;       /* CFIOR and CFIOW pulse width in MCK ticks */
> -	unsigned int cs_setup = 0;/* CS4 or CS5 setup width in MCK ticks */
>   	unsigned int cs_pulse;    /* CS4 or CS5 pulse width in MCK ticks*/
>   	unsigned int tdf_cycles;  /* SMC TDF MCK ticks */
>   	unsigned long mck_hz;     /* MCK frequency in Hz */
> @@ -244,26 +244,25 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
>   	}
>
>   	dev_dbg(dev, "Use IORDY=%u, TDF Cycles=%u\n", use_iordy, tdf_cycles);
> -	info->mode |= AT91_SMC_TDF_(tdf_cycles);
>
>   	/* write SMC Setup Register */
> -	at91_sys_write(AT91_SMC_SETUP(info->cs),
> -			AT91_SMC_NWESETUP_(setup) |
> -			AT91_SMC_NRDSETUP_(setup) |
> -			AT91_SMC_NCS_WRSETUP_(cs_setup) |
> -			AT91_SMC_NCS_RDSETUP_(cs_setup));
> +	smc.nrd_setup = setup;
> +	smc.nwe_setup = smc.nrd_setup;
> +	smc.ncs_read_setup = 0;
> +	smc.ncs_write_setup = smc.ncs_read_setup;

    Why not:

	smc.nrd_setup = smc.nwe_setup = setup;
	smc.ncs_read_setup = smc.ncs_write_setup = 0;

>   	/* write SMC Pulse Register */
> -	at91_sys_write(AT91_SMC_PULSE(info->cs),
> -			AT91_SMC_NWEPULSE_(pulse) |
> -			AT91_SMC_NRDPULSE_(pulse) |
> -			AT91_SMC_NCS_WRPULSE_(cs_pulse) |
> -			AT91_SMC_NCS_RDPULSE_(cs_pulse));
> +	smc.nrd_pulse = pulse;
> +	smc.nwe_pulse = smc.nrd_pulse;
> +	smc.ncs_read_pulse =cs_pulse;

    Add space after =, please.

> +	smc.ncs_write_pulse = smc.ncs_read_pulse;

    Why not:

	smc.nrd_pulse = smc.nwe_pulse = pulse;
	smc.ncs_read_pulse = smc.ncs_write_pulse = cs_pulse;

>   	/* write SMC Cycle Register */
> -	at91_sys_write(AT91_SMC_CYCLE(info->cs),
> -			AT91_SMC_NWECYCLE_(cycle) |
> -			AT91_SMC_NRDCYCLE_(cycle));
> +	smc.read_cycle = cycle;
> +	smc.write_cycle = smc.read_cycle;

    Why not:

	smc.read_cycle = smc.write_cycle = cycle;

WBR, Sergei
