From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [V8 PATCH 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
Date: Thu, 22 Sep 2011 23:24:46 +0800
Message-ID: <CAJNCFVJZgpvimWY8Q8RpDzGxmyRmPzQBQPXj+Od+3kqq7aP2og@mail.gmail.com>
References: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
	<1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
	<4E7B1F0F.10601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41042 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1IVPYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 11:24:47 -0400
Received: by ywb5 with SMTP id 5so2033091ywb.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 08:24:46 -0700 (PDT)
In-Reply-To: <4E7B1F0F.10601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

Hi Fabio&Sergei:
Thanks for your comments.
Accepted. Would be changed later.

Best Regard
Richard Zhu

On 22/09/2011, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 22-09-2011 14:14, Richard Zhu wrote:
>
>> Signed-off-by: Richard Zhu<richard.zhu@linaro.org>
>> ---
>>   arch/arm/mach-mx5/board-mx53_smd.c |   16 ++++++++++++++++
>>   1 files changed, 16 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c
>> b/arch/arm/mach-mx5/board-mx53_smd.c
>> index bc02894..9d06fbe 100644
>> --- a/arch/arm/mach-mx5/board-mx53_smd.c
>> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> [...]
>> @@ -111,6 +112,19 @@ static const struct imxi2c_platform_data
>> mx53_smd_i2c_data __initconst = {
>>   	.bitrate = 100000,
>>   };
>>
>> +static inline void mx53_smd_ahci_pwr_on(void)
>> +{
>> +	int ret;
>> +
>> +	/* Enable SATA PWR */
>> +	ret = gpio_request(MX53_SMD_SATA_PWR_EN, "ahci-sata-pwr");
>> +	if (ret) {
>> +		printk(KERN_ERR "failed to get SATA_PWR_EN: %d\n", ret);
>> +		return;
>> +	}
>> +	gpio_direction_output(MX53_SMD_SATA_PWR_EN, 1);
>
>     You can use gpio_request_one() instead of
> gpio_request()/gpio_direction_*().
>
> WBR, Sergei
>
