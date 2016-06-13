From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v4 7/7] unicore32: use the new LED disk activity trigger
Date: Mon, 13 Jun 2016 09:57:53 +0200
Message-ID: <575E6781.7090503@samsung.com>
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-7-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:37208 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbcFMH56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2016 03:57:58 -0400
In-reply-to: <20160610060021.12382-7-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org

Hi Guan,

For consistency reasons this patch should be merged through LED tree,
but I need an ack for this.

Thanks,
Jacek Anaszewski

On 06/10/2016 08:00 AM, Stephan Linz wrote:
> - platform: rename 'ide-disk' to 'disk-activity'
> - defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'
>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>   arch/unicore32/configs/unicore32_defconfig | 2 +-
>   arch/unicore32/kernel/gpio.c               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/unicore32/configs/unicore32_defconfig b/arch/unicore32/configs/unicore32_defconfig
> index 45f47f8..aebd01f 100644
> --- a/arch/unicore32/configs/unicore32_defconfig
> +++ b/arch/unicore32/configs/unicore32_defconfig
> @@ -161,7 +161,7 @@ CONFIG_LEDS_GPIO=y
>   #	LED Triggers
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>
>   #	Real Time Clock
> diff --git a/arch/unicore32/kernel/gpio.c b/arch/unicore32/kernel/gpio.c
> index 49347a0..bf164bb 100644
> --- a/arch/unicore32/kernel/gpio.c
> +++ b/arch/unicore32/kernel/gpio.c
> @@ -27,7 +27,7 @@ static const struct gpio_led puv3_gpio_leds[] = {
>   	{ .name = "cpuhealth", .gpio = GPO_CPU_HEALTH, .active_low = 0,
>   		.default_trigger = "heartbeat",	},
>   	{ .name = "hdd_led", .gpio = GPO_HDD_LED, .active_low = 1,
> -		.default_trigger = "ide-disk", },
> +		.default_trigger = "disk-activity", },
>   };
>
>   static const struct gpio_led_platform_data puv3_gpio_led_data = {
>


-- 
Best regards,
Jacek Anaszewski
