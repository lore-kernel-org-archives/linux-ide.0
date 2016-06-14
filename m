From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Subject: Re: [PATCH v4 7/7] unicore32: use the new LED disk activity trigger
Date: Tue, 14 Jun 2016 10:11:27 +0800 (CST)
Message-ID: <50304.117.114.135.40.1465870287.squirrel@mprc.pku.edu.cn>
References: <20160610060021.12382-1-linz@li-pro.net>
    <20160610060021.12382-7-linz@li-pro.net>
    <575E6781.7090503@samsung.com>
Reply-To: gxt@mprc.pku.edu.cn
Mime-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575E6781.7090503@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Stephan Linz <linz@li-pro.net>, linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Hi Guan,
>
> For consistency reasons this patch should be merged through LED tree,
> but I need an ack for this.
>
> Thanks,
> Jacek Anaszewski

For uc32 code,
Acked-by: GUAN Xuetao <gxt@mprc.pku.edu.cn>

Thanks Jacek

>
> On 06/10/2016 08:00 AM, Stephan Linz wrote:
>> - platform: rename 'ide-disk' to 'disk-activity'
>> - defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'
>>
>> Signed-off-by: Stephan Linz <linz@li-pro.net>
>> ---
>>   arch/unicore32/configs/unicore32_defconfig | 2 +-
>>   arch/unicore32/kernel/gpio.c               | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/unicore32/configs/unicore32_defconfig
>> b/arch/unicore32/configs/unicore32_defconfig
>> index 45f47f8..aebd01f 100644
>> --- a/arch/unicore32/configs/unicore32_defconfig
>> +++ b/arch/unicore32/configs/unicore32_defconfig
>> @@ -161,7 +161,7 @@ CONFIG_LEDS_GPIO=y
>>   #	LED Triggers
>>   CONFIG_LEDS_TRIGGERS=y
>>   CONFIG_LEDS_TRIGGER_TIMER=y
>> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
>> +CONFIG_LEDS_TRIGGER_DISK=y
>>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>>
>>   #	Real Time Clock
>> diff --git a/arch/unicore32/kernel/gpio.c b/arch/unicore32/kernel/gpio.c
>> index 49347a0..bf164bb 100644
>> --- a/arch/unicore32/kernel/gpio.c
>> +++ b/arch/unicore32/kernel/gpio.c
>> @@ -27,7 +27,7 @@ static const struct gpio_led puv3_gpio_leds[] = {
>>   	{ .name = "cpuhealth", .gpio = GPO_CPU_HEALTH, .active_low = 0,
>>   		.default_trigger = "heartbeat",	},
>>   	{ .name = "hdd_led", .gpio = GPO_HDD_LED, .active_low = 1,
>> -		.default_trigger = "ide-disk", },
>> +		.default_trigger = "disk-activity", },
>>   };
>>
>>   static const struct gpio_led_platform_data puv3_gpio_led_data = {
>>
>
>
> --
> Best regards,
> Jacek Anaszewski
>
