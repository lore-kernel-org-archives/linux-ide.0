From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v3 1/7] leds: convert IDE trigger to common disk trigger
Date: Mon, 20 Jun 2016 10:36:00 +0200
Message-ID: <5767AAF0.7080608@samsung.com>
References: <20160608223000.433-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20160608223000.433-1-linz@li-pro.net>
Sender: linux-leds-owner@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>, Richard Purdie <rpurdie@rpsys.net>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Stephan,

On 06/09/2016 12:29 AM, Stephan Linz wrote:
> This patch converts the IDE specific LED trigger to a generic disk
> activity LED trigger. The libata core is now a trigger source just
> like before the IDE disk driver. It's merely a replacement of the
> string ide by disk.
>
> The patch is taken from http://dev.gentoo.org/~josejx/ata.patch and i=
s
> widely used by any ibook/powerbook owners with great satisfaction.
> Likewise, it is very often used successfully on different ARM platfor=
ms.
>
> The original patch was split into different parts to clarify platform
> independent and dependent changes.
>
> Cc: Joseph Jezak <josejx@gentoo.org>
> Cc: Nico Macrionitis <acrux@cruxppc.org>
> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
> Changes in v3:
>    - Port to kernel 4.x
>    - Split into platform independent and dependent parts.
>
> v2: https://patchwork.ozlabs.org/patch/117485/
> v1: http://dev.gentoo.org/~josejx/ata.patch
> ---
>   drivers/ata/libata-core.c                            |  4 ++++
>   drivers/ide/ide-disk.c                               |  2 +-
>   drivers/leds/leds-hp6xx.c                            |  2 +-
>   drivers/leds/trigger/Kconfig                         |  8 ++++----
>   drivers/leds/trigger/Makefile                        |  2 +-
>   .../trigger/{ledtrig-ide-disk.c =3D> ledtrig-disk.c}   | 20 +++++++=
+++----------
>   include/linux/leds.h                                 |  6 +++---
>   7 files changed, 24 insertions(+), 20 deletions(-)
>   rename drivers/leds/trigger/{ledtrig-ide-disk.c =3D> ledtrig-disk.c=
} (50%)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6be7770..2eca572 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -69,6 +69,7 @@
>   #include <asm/unaligned.h>
>   #include <linux/cdrom.h>
>   #include <linux/ratelimit.h>
> +#include <linux/leds.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/platform_device.h>
>
> @@ -5072,6 +5073,9 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>   {
>   	struct ata_port *ap =3D qc->ap;
>
> +	/* Trigger the LED (if available) */
> +	ledtrig_disk_activity();
> +
>   	/* XXX: New EH and old EH use different mechanisms to
>   	 * synchronize EH with regular execution path.
>   	 *
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index 05dbcce..5ceb176 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -186,7 +186,7 @@ static ide_startstop_t ide_do_rw_disk(ide_drive_t=
 *drive, struct request *rq,
>   	BUG_ON(drive->dev_flags & IDE_DFLAG_BLOCKED);
>   	BUG_ON(rq->cmd_type !=3D REQ_TYPE_FS);
>
> -	ledtrig_ide_activity();
> +	ledtrig_disk_activity();
>
>   	pr_debug("%s: %sing: block=3D%llu, sectors=3D%u\n",
>   		 drive->name, rq_data_dir(rq) =3D=3D READ ? "read" : "writ",
> diff --git a/drivers/leds/leds-hp6xx.c b/drivers/leds/leds-hp6xx.c
> index a6b8db0..137969f 100644
> --- a/drivers/leds/leds-hp6xx.c
> +++ b/drivers/leds/leds-hp6xx.c
> @@ -50,7 +50,7 @@ static struct led_classdev hp6xx_red_led =3D {
>
>   static struct led_classdev hp6xx_green_led =3D {
>   	.name			=3D "hp6xx:green",
> -	.default_trigger	=3D "ide-disk",
> +	.default_trigger	=3D "disk-activity",
>   	.brightness_set		=3D hp6xxled_green_set,
>   	.flags			=3D LED_CORE_SUSPENDRESUME,
>   };
> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kcon=
fig
> index 9893d91..3f9ddb9 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -33,12 +33,12 @@ config LEDS_TRIGGER_ONESHOT
>
>   	  If unsure, say Y.
>
> -config LEDS_TRIGGER_IDE_DISK
> -	bool "LED IDE Disk Trigger"
> -	depends on IDE_GD_ATA
> +config LEDS_TRIGGER_DISK
> +	bool "LED Disk Trigger"
> +	depends on IDE_GD_ATA || ATA
>   	depends on LEDS_TRIGGERS
>   	help
> -	  This allows LEDs to be controlled by IDE disk activity.
> +	  This allows LEDs to be controlled by disk activity.
>   	  If unsure, say Y.
>
>   config LEDS_TRIGGER_MTD
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Mak=
efile
> index 8cc64a4..a72c43c 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -1,6 +1,6 @@
>   obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+=3D ledtrig-timer.o
>   obj-$(CONFIG_LEDS_TRIGGER_ONESHOT)	+=3D ledtrig-oneshot.o
> -obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)	+=3D ledtrig-ide-disk.o
> +obj-$(CONFIG_LEDS_TRIGGER_DISK)		+=3D ledtrig-disk.o
>   obj-$(CONFIG_LEDS_TRIGGER_MTD)		+=3D ledtrig-mtd.o
>   obj-$(CONFIG_LEDS_TRIGGER_HEARTBEAT)	+=3D ledtrig-heartbeat.o
>   obj-$(CONFIG_LEDS_TRIGGER_BACKLIGHT)	+=3D ledtrig-backlight.o
> diff --git a/drivers/leds/trigger/ledtrig-ide-disk.c b/drivers/leds/t=
rigger/ledtrig-disk.c
> similarity index 50%
> rename from drivers/leds/trigger/ledtrig-ide-disk.c
> rename to drivers/leds/trigger/ledtrig-disk.c
> index 15123d3..7a1fe44 100644
> --- a/drivers/leds/trigger/ledtrig-ide-disk.c
> +++ b/drivers/leds/trigger/ledtrig-disk.c
> @@ -1,5 +1,5 @@
>   /*
> - * LED IDE-Disk Activity Trigger
> + * LED Disk Activity Trigger
>    *
>    * Copyright 2006 Openedhand Ltd.
>    *
> @@ -17,20 +17,20 @@
>
>   #define BLINK_DELAY 30
>
> -DEFINE_LED_TRIGGER(ledtrig_ide);
> +DEFINE_LED_TRIGGER(ledtrig_disk);
>
> -void ledtrig_ide_activity(void)
> +void ledtrig_disk_activity(void)
>   {
> -	unsigned long ide_blink_delay =3D BLINK_DELAY;
> +	unsigned long disk_blink_delay =3D BLINK_DELAY;
>
> -	led_trigger_blink_oneshot(ledtrig_ide,
> -				  &ide_blink_delay, &ide_blink_delay, 0);
> +	led_trigger_blink_oneshot(ledtrig_disk,
> +				  &disk_blink_delay, &disk_blink_delay, 0);
>   }
> -EXPORT_SYMBOL(ledtrig_ide_activity);
> +EXPORT_SYMBOL(ledtrig_disk_activity);
>
> -static int __init ledtrig_ide_init(void)
> +static int __init ledtrig_disk_init(void)
>   {
> -	led_trigger_register_simple("ide-disk", &ledtrig_ide);
> +	led_trigger_register_simple("disk-activity", &ledtrig_disk);
>   	return 0;
>   }
> -device_initcall(ledtrig_ide_init);
> +device_initcall(ledtrig_disk_init);
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index d2b1306..28a3ef5 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -324,10 +324,10 @@ static inline void *led_get_trigger_data(struct=
 led_classdev *led_cdev)
>   #endif /* CONFIG_LEDS_TRIGGERS */
>
>   /* Trigger specific functions */
> -#ifdef CONFIG_LEDS_TRIGGER_IDE_DISK
> -extern void ledtrig_ide_activity(void);
> +#ifdef CONFIG_LEDS_TRIGGER_DISK
> +extern void ledtrig_disk_activity(void);
>   #else
> -static inline void ledtrig_ide_activity(void) {}
> +static inline void ledtrig_disk_activity(void) {}
>   #endif
>
>   #ifdef CONFIG_LEDS_TRIGGER_MTD
>

Applied the patchset to the for-next branch of linux-leds.git.

Thanks,
Jacek Anaszewski
