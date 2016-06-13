From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v4 6/7] parisc: use the new LED disk activity trigger
Date: Mon, 13 Jun 2016 09:56:02 +0200
Message-ID: <575E6712.8030403@samsung.com>
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-6-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:34238 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbcFMH4I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2016 03:56:08 -0400
In-reply-to: <20160610060021.12382-6-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>
Cc: Stephan Linz <linz@li-pro.net>, linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

For consistency reasons this patch should be merged through LED tree,
but I need an ack for this. Hedge, James?

Thanks,
Jacek Anaszewski


On 06/10/2016 08:00 AM, Stephan Linz wrote:
> - platform: rename 'ide-disk' to 'disk-activity'
>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>   arch/parisc/configs/generic-32bit_defconfig | 2 +-
>   arch/parisc/configs/generic-64bit_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
> index 5b04d70..8688ba7 100644
> --- a/arch/parisc/configs/generic-32bit_defconfig
> +++ b/arch/parisc/configs/generic-32bit_defconfig
> @@ -214,7 +214,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>   CONFIG_DMADEVICES=y
> diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
> index e945c08..7e07926 100644
> --- a/arch/parisc/configs/generic-64bit_defconfig
> +++ b/arch/parisc/configs/generic-64bit_defconfig
> @@ -231,7 +231,7 @@ CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
>   CONFIG_LEDS_TRIGGER_ONESHOT=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=m
>   CONFIG_LEDS_TRIGGER_BACKLIGHT=m
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
>


-- 
Best regards,
Jacek Anaszewski
