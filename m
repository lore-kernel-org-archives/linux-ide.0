From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4] davinci: da850: add support for SATA interface
Date: Thu, 24 Mar 2011 16:04:26 +0300
Message-ID: <4D8B415A.2050706@mvista.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com> <1300879949-16379-2-git-send-email-nsekhar@ti.com> <1300879949-16379-3-git-send-email-nsekhar@ti.com> <4D89E308.8060404@mvista.com> <B85A65D85D7EB246BE421B3FB0FBB593024C47E42D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58164 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab1CXNF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2011 09:05:56 -0400
Received: by eyx24 with SMTP id 24so2484267eyx.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2011 06:05:55 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C47E42D@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello.

On 24-03-2011 12:08, Nori, Sekhar wrote:

>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>> index 68fe4c2..276199d 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -373,6 +373,14 @@ static struct clk spi1_clk = {
>>>    	.flags		= DA850_CLK_ASYNC3,
>>>    };
>>>
>>> +static struct clk sata_clk = {
>>> +	.name		= "sata",
>>> +	.parent		=&pll0_sysclk2,
>>> +	.lpsc		= DA850_LPSC1_SATA,
>>> +	.gpsc		= 1,
>>> +	.flags		= PSC_FORCE,
>>> +};
>>> +
>>>    static struct clk_lookup da850_clks[] = {
>>>    	CLK(NULL,		"ref",		&ref_clk),
>>>    	CLK(NULL,		"pll0",		&pll0_clk),
>>> @@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
>>>    	CLK(NULL,		"usb20",	&usb20_clk),
>>>    	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>>>    	CLK("spi_davinci.1",	NULL,		&spi1_clk),
>>> +	CLK("ahci",		NULL,		&sata_clk),
>>>    	CLK(NULL,		NULL,		NULL),
>>>    };

>>      I'd put the above into a separate patch...

> Why should addition of clock data not be in the same patch
> as the one which adds platform resources etc? It is not a big
> deal to change, but I would like to know why you request this.

    I didn't request anything, I just said what I'd have done. :-)
I think modifying the DA8xx-common and DA850-specific files should better be 
done separately. Although in this case we're adding DA850 only device, so 
perhaps the added code in devices-da8xx.c should be enclosed into #ifdef?

>>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>>> index 625d4b6..e061396 100644
>>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> [...]
>>> @@ -834,3 +836,139 @@ int __init da8xx_register_spi(int instance, struct spi_board_info *info,
>> [...]
>>> +/* Supported DA850 SATA crystal frequencies */
>>> +#define KHZ_TO_HZ(freq) ((freq) * 1000)
>>> +static unsigned long da850_sata_xtal[] = {
>>> +	KHZ_TO_HZ(300000),
>>> +	KHZ_TO_HZ(250000),
>>> +	0,			/* Reserved */

>>      Why reserve a place for it at all?

> Because then this table maps one-to-one to the hardware
> defined table.

    Ah, sorry, have missed that...

>>> +		val = SATA_PHY_MPY(i + 1);
>>> +	}
>>> +
>> [...]

>>> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
>>> index e4fc1af..aa6f08e 100644
>>> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
>>> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
>> [...]
>>> @@ -65,6 +66,7 @@ extern unsigned int da850_max_speed;
>>>    #define DA8XX_GPIO_BASE		0x01e26000
>>>    #define DA8XX_PSC1_BASE		0x01e27000
>>>    #define DA8XX_LCD_CNTRL_BASE	0x01e13000
>>> +#define DA850_SATA_BASE		0x01e18000

>>      It's used only in devices-da8xx.c -- shouldn't it be declared there?

> Yes, will move. Base addresses for modules like LCD and MMCSD can be
> moved as well - should be subject of some future clean-up patch.

    Yes, maybe I'll submit one...

> Thanks,
> Sekhar

WBR, Sergei
