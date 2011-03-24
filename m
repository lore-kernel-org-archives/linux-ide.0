From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4] davinci: da850: add support for SATA interface
Date: Thu, 24 Mar 2011 21:01:57 +0300
Message-ID: <4D8B8715.2000407@mvista.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com> <1300879949-16379-2-git-send-email-nsekhar@ti.com> <1300879949-16379-3-git-send-email-nsekhar@ti.com> <4D89E308.8060404@mvista.com> <B85A65D85D7EB246BE421B3FB0FBB593024C47E42D@dbde02.ent.ti.com> <4D8B415A.2050706@mvista.com> <B85A65D85D7EB246BE421B3FB0FBB593024C53228A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61187 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933572Ab1CXSDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2011 14:03:36 -0400
Received: by ewy4 with SMTP id 4so171607ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2011 11:03:35 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C53228A@dbde02.ent.ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello.

Nori, Sekhar wrote:

>>>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>>>> index 68fe4c2..276199d 100644
>>>>> --- a/arch/arm/mach-davinci/da850.c
>>>>> +++ b/arch/arm/mach-davinci/da850.c
>>>>> @@ -373,6 +373,14 @@ static struct clk spi1_clk = {
>>>>>    	.flags		= DA850_CLK_ASYNC3,
>>>>>    };
>>>>>
>>>>> +static struct clk sata_clk = {
>>>>> +	.name		= "sata",
>>>>> +	.parent		=&pll0_sysclk2,
>>>>> +	.lpsc		= DA850_LPSC1_SATA,
>>>>> +	.gpsc		= 1,
>>>>> +	.flags		= PSC_FORCE,
>>>>> +};
>>>>> +
>>>>>    static struct clk_lookup da850_clks[] = {
>>>>>    	CLK(NULL,		"ref",		&ref_clk),
>>>>>    	CLK(NULL,		"pll0",		&pll0_clk),
>>>>> @@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
>>>>>    	CLK(NULL,		"usb20",	&usb20_clk),
>>>>>    	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>>>>>    	CLK("spi_davinci.1",	NULL,		&spi1_clk),
>>>>> +	CLK("ahci",		NULL,		&sata_clk),
>>>>>    	CLK(NULL,		NULL,		NULL),
>>>>>    };

>>>>      I'd put the above into a separate patch...

>>> Why should addition of clock data not be in the same patch
>>> as the one which adds platform resources etc? It is not a big
>>> deal to change, but I would like to know why you request this.

>>     I didn't request anything, I just said what I'd have done. :-)

> Okay. I guess I will keep it as is.

>> I think modifying the DA8xx-common and DA850-specific files should better be 
>> done separately. Although in this case we're adding DA850 only device, so 
>> perhaps the added code in devices-da8xx.c should be enclosed into #ifdef?

> Good point. Will add the #ifdef.

    Or perhaps the device should just be placed in da850.c instead?

WBR, Sergei

