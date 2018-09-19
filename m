From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
Date: Wed, 19 Sep 2018 15:01:04 +0200
Message-ID: <20180919130104.GD26940@lunn.ch>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Prayoga <aditya@kobol.io>
Cc: linux-ide@vger.kernel.org, linux-leds@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Daniel Golle <daniel@makrotopia.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Sep 19, 2018 at 11:45:29AM +0800, Aditya Prayoga wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> This adds a LED trigger for each ATA port indicating disk activity.
> 
> As this is needed only on specific platforms (NAS SoCs and such),
> these platforms should define ARCH_WANTS_LIBATA_LEDS if there
> are boards with LED(s) intended to indicate ATA disk activity and
> need the OS to take care of that.
> In that way, if not selected, LED trigger support not will be
> included in libata-core and both, codepaths and structures remain
> untouched.
> 
> I'm currently deploying this for the oxnas target in OpenWrt
> https://dev.openwrt.org/changeset/43675/
> 
> v2: rebased to kernel/git/tj/libata.git
>     plus small corrections and comments added
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> URL: https://patchwork.ozlabs.org/patch/420733/
> [Aditya Prayoga:
> * Port forward
> * Change ATA_LEDS default to no
> * Reduce performance impact by moving ata_led_act() call from
>     ata_qc_new() to ata_qc_complete()]
> Signed-off-by: Aditya Prayoga <aditya@kobol.io>
> 
> ---
> 
> If there is anything fundamentally wrong with that approach, I'd be
> glad for some advise on how to do it better.
> I conciously choose an #ifdev approach to make sure performance will
> not be affected for non-users of that code.

Hi Aditya

I remember something like this being discussed a long time ago, and it
was rejected because of the overheads. So it is good you have some
performance numbers. I will let others decide if the approach is
acceptable.

>  /**
> + *	ata_led_act - Trigger port activity LED
> + *	@ap: indicating port
> + *
> + *	Blinks any LEDs registered to the trigger.
> + *	Commonly used with leds-gpio on NAS systems with disk activity
> + *	indicator LEDs.
> + *
> + *	LOCKING:
> + *	None.
> + */
> +static inline void ata_led_act(struct ata_port *ap)

inline should not be used in C code, just header files. A function
this small the compiler is likely to inline anyway.

> +{
> +#ifdef CONFIG_ATA_LEDS

It is better to use if (IS_ENABLED(CONFIG_ATA_LEDS) {}.  That gets
turned into if(0) {}, so the code still gets compiled to find any
errors, but then optimised out. This is important if the code is going
to be disabled by default.

> +#define LIBATA_BLINK_DELAY 20 /* ms */
> +	unsigned long led_delay = LIBATA_BLINK_DELAY;
> +
> +	if (unlikely(!ap->ledtrig))
> +		return;
> +
> +	led_trigger_blink_oneshot(ap->ledtrig, &led_delay, &led_delay, 0);
> +#endif /* CONFIG_ATA_LEDS */
> +}
> +
> +/**
>   *	ata_qc_new_init - Request an available ATA command, and initialize it
>   *	@dev: Device from whom we request an available command structure
>   *	@tag: tag
> @@ -5249,6 +5273,10 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  	/* Trigger the LED (if available) */
>  	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
>  
> +#ifdef CONFIG_ATA_LEDS
> +	ata_led_act(ap);
> +#endif

No need for this #ifdef'ery.

> +
>  	/* XXX: New EH and old EH use different mechanisms to
>  	 * synchronize EH with regular execution path.
>  	 *
> @@ -6028,6 +6056,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	ap->stats.unhandled_irq = 1;
>  	ap->stats.idle_irq = 1;
>  #endif
> +#ifdef CONFIG_ATA_LEDS
> +	ap->ledtrig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);

Maybe use devm_kzalloc() and devm_led_trigger_register()?

      Andrew
