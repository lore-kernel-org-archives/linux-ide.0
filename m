From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH v4 2/3] pwm: iproc: Add support for Broadcom iproc pwm controller
Date: Thu, 23 Jun 2016 23:16:27 +0530
Message-ID: <CAL2FKYmz+EgKkq201X-e+980yMMtn8v3R_fC=3Hg=L1WX_NtSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35677 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcFWRq3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jun 2016 13:46:29 -0400
Received: by mail-io0-f169.google.com with SMTP id f30so77987395ioj.2
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2016 10:46:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-ide@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Hi Brian,


On Wed, Jun 22, 2016 at 11:01 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Wed, Jun 22, 2016 at 07:29:46AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> Add support for the PWM controller present in Broadcom's iProc
>> family of SoCs. This driver is derived from the pwm-bcm-kona
>> driver, with changes to the register offsets and bit positions.
>> It has been tested on the  Northstar+ bcm958625HR board.
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>  drivers/pwm/Kconfig         |  10 ++
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-bcm-iproc.c | 327 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 338 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
>>
> [...]
>> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
>> new file mode 100644
>> index 0000000..952c457
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-bcm-iproc.c
>> @@ -0,0 +1,327 @@
> [...]
>> +static const struct pwm_ops iproc_pwm_ops = {
>> +     .config = iproc_pwmc_config_check,
>> +     .set_polarity = iproc_pwmc_set_polarity,
>> +     .enable = iproc_pwmc_enable,
>> +     .disable = iproc_pwmc_disable,
>> +     .owner = THIS_MODULE,
>> +};
>
> Have you considered trying the new apply() callback instead of
> config()/set_polarity()/enable()/disable()?
>

I will make it and provide a v5 version patches.

Thanks
Dhananjay

> [...]
>
> Brian
