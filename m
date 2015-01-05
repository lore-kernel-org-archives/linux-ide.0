From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: add ledtrig support
Date: Mon, 5 Jan 2015 11:20:36 -0500
Message-ID: <20150105162036.GN15833@htj.dyndns.org>
References: <20141212173008.GA32396@makrotopia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:44715 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbAEQUk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2015 11:20:40 -0500
Received: by mail-qg0-f52.google.com with SMTP id i50so2444015qgf.11
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2015 08:20:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212173008.GA32396@makrotopia.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-ide@vger.kernel.org, blogic@openwrt.org

Hello, Daniel.

Sorry about the delay.

On Fri, Dec 12, 2014 at 06:30:43PM +0100, Daniel Golle wrote:
> This adds a LED trigger for each ATA port indicating disk activity.
> 
> As this is needed only on specific platforms (NAS SoCs and such),
> these platforms should define ARCH_WANTS_LIBATA_LEDS if there
> are boards with LED(s) intended to indicate ATA disk activity and
> need the OS to take care of that.
> In that way, if not selected, LED trigger support not will be
> included in libata-core and both, codepaths and structures remain
> untouched.
...
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +#define LIBATA_BLINK_DELAY 20 /* ms */
> +static inline void ata_led_act(struct ata_port *ap)
> +{
> +	unsigned long led_delay = LIBATA_BLINK_DELAY;
> +
> +	if (likely(!ap->ledtrig))
> +		return;
> +	led_trigger_blink_oneshot(ap->ledtrig, &led_delay, &led_delay, 0);
> +}

#else

DUMMY FUNCTION

> +#endif

and then,

>  /**
>   *	ata_build_rw_tf - Build ATA taskfile for given read/write request
>   *	@tf: Target ATA taskfile
> @@ -4761,6 +4773,9 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>  			break;
>  		}
>  	}
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +	ata_led_act(ap);
> +#endif

You don't need #if here.

> @@ -5671,6 +5686,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	ap->stats.unhandled_irq = 1;
>  	ap->stats.idle_irq = 1;
>  #endif
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +	ap->ledtrig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
> +#endif

Ditto here.  Please define a function - ata_ledtrig_init() or whatever
- and collect the conditional pieces in a single place.

>  	ata_sff_port_init(ap);
>  
>  	return ap;
> @@ -5692,6 +5710,12 @@ static void ata_host_release(struct device *gendev, void *res)
>  
>  		kfree(ap->pmp_link);
>  		kfree(ap->slave_link);
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +		if (ap->ledtrig) {
> +			led_trigger_unregister(ap->ledtrig);
> +			kfree(ap->ledtrig);
> +		};
> +#endif

Ditto.

> @@ -6138,7 +6162,23 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>  		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
>  		host->ports[i]->local_port_no = i + 1;
>  	}
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +	for (i = 0; i < host->n_ports; i++) {
> +		if (unlikely(!host->ports[i]->ledtrig))
> +			continue;
> +
> +		snprintf(host->ports[i]->ledtrig_name,
> +			sizeof(host->ports[i]->ledtrig_name), "ata%u",
> +			host->ports[i]->print_id);
>  
> +		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
> +
> +		if (led_trigger_register(host->ports[i]->ledtrig)) {
> +			kfree(host->ports[i]->ledtrig);
> +			host->ports[i]->ledtrig = NULL;
> +		}
> +	}
> +#endif

Ditto.  Also, can't the ledtrig allocation happen together with
registration?  It's not like ledtrig is necessary before registration,
right?

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2d18241..aea611c 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -38,6 +38,9 @@
>  #include <linux/acpi.h>
>  #include <linux/cdrom.h>
>  #include <linux/sched.h>
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +#include <linux/leds.h>
> +#endif

leds.h should have CONFIG_ATA_LEDS guards in it, not its users.

>  
>  /*
>   * Define if arch has non-standard setup.  This is a _PCI_ standard
> @@ -862,6 +865,12 @@ struct ata_port {
>  #ifdef CONFIG_ATA_ACPI
>  	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
>  #endif
> +
> +#if IS_ENABLED(CONFIG_ATA_LEDS)
> +	struct led_trigger	*ledtrig;
> +	char			ledtrig_name[8];
> +#endif

What do we use the ledtrig_name[] for?

Thanks.

-- 
tejun
