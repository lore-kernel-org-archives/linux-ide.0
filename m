Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E2C433ED
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51114610F8
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHOlf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOlf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2021 10:41:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190EC061760;
        Thu,  8 Apr 2021 07:41:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d13so4442416lfg.7;
        Thu, 08 Apr 2021 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQy8MLan9FVitDAGtlGUNA7rO1yc07hKRiQL0kl4NUc=;
        b=oDpJxbqfgCz3VM2m4ZljlARuHLcN5D/nLcuT01NlqHakXynltNCSbCQ/fXkKVmLJ6S
         uhSZok2mShKj+altpRFHuqkt5w1jPa9yrHB5acd87CkeU/sDMLl2oZtwB1Sn2P12fF5R
         udMu7LPs/1UEFThSUxB43qm9PuBF8pQcCN4fEy5VtSdzfN6H73K/W6GJPqiQTLNrbC+m
         g9gLtN5GAeXKujzUKqfAau1lJwOrs674osmiDIqGzqW+xkpJTFKUXQCFbyxupU50GOdW
         wSxG6bjkls9XBdfMdG3Hfjd9ymLRJDpwc32YUF2kVtVu8GD3lhSDEQ3wPVk2uTj03o8Y
         gvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQy8MLan9FVitDAGtlGUNA7rO1yc07hKRiQL0kl4NUc=;
        b=LzlX1Be1lEp94mFIxy1Itip2mr6WpAp9YvJj+hJeMp4uJSyt9oZ74eT09iJR6UVKb7
         f5p5lhnjvceefC5YQ8734Lmp/ZFdoCD89b9tW44fk9Ga7VNnxWOtPEjT+efQfbF4tXQB
         6TXJmlryV2NJ1Wzvmhd9armPP9hu0RSXuYump4pt67qaPXw/6Ry6bNp10xc9FacEjy7m
         f27FIeXA/AbnkGqgVS9dGgOHwpx05GoMNcejrgC+zLpGqjFZkCatHk1JkOtOU61n8Je6
         Z/I2z9nL5XDD6mtw7MNRRS5hk1HrlXXlEFXgU9KbJwSraT+FuVKuhba0f/tKyH782GEo
         oKsQ==
X-Gm-Message-State: AOAM532vtHCDBdEw8UBh7AFKr4/uCth1V+9cmN9uo2adgL45v8QZEWgY
        LLZ+4orAkaPfGaaaip3rSOB7KTemBek=
X-Google-Smtp-Source: ABdhPJwBFQ8ADKo07Q+gjxhb9Gs15OFUfzYiitQPx4MftXy5iPUaYDqJTT51syi6TAltR7abt/V31Q==
X-Received: by 2002:ac2:5f9a:: with SMTP id r26mr6462253lfe.624.1617892882147;
        Thu, 08 Apr 2021 07:41:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru. [109.252.193.85])
        by smtp.googlemail.com with ESMTPSA id 3sm33155lfy.238.2021.04.08.07.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:41:21 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        jonathanh@nvidia.com, robh+dt@kernel.org, pchandru@nvidia.com,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
 <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
 <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
 <01fd01ab-f4e7-57ee-2ad7-2aabaeb92a0e@nvidia.com>
 <2ef2a124-9e4b-bc02-3830-8ef077638ced@gmail.com>
 <YG7/xPVoA4gPrMBf@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c05f6f69-b355-857a-1fe7-6c68596d141f@gmail.com>
Date:   Thu, 8 Apr 2021 17:41:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YG7/xPVoA4gPrMBf@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

08.04.2021 16:06, Thierry Reding пишет:
> On Thu, Apr 08, 2021 at 02:25:19AM +0300, Dmitry Osipenko wrote:
>> 08.04.2021 02:00, Sowjanya Komatineni пишет:
>>>
>>> On 4/7/21 3:57 PM, Sowjanya Komatineni wrote:
>>>>
>>>> On 4/7/21 2:36 PM, Dmitry Osipenko wrote:
>>>>> 07.04.2021 04:25, Sowjanya Komatineni пишет:
>>>>>> +    if (!tegra->pdev->dev.pm_domain) {
>>>>>> +        ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
>>>>>> +                            tegra->sata_clk,
>>>>>> +                            tegra->sata_rst);
>>>>>> +        if (ret)
>>>>>> +            goto disable_regulators;
>>>>>> +    }
>>>>> Hi,
>>>>>
>>>>> Why you haven't added condition for tegra_powergate_power_off()? I think
>>>>> it should break GENPD and legacy PD API isn't not supported by T186
>>>>> at all.
>>>>>
>>>>> I'm also not sure whether the power up/down sequence is correct using
>>>>> GENPD.
>>>>>
>>>>> Moreover the driver doesn't support runtime PM, so GENPD should be
>>>>> always off?
>>>>
>>>> This driver already using legacy PD API's so thought its supported and
>>>> added power domain device check during powergate_sequence_power_up and
>>>> yes same should apply for powergate_power_off as well. But if legacy
>>>> PD is not supported by T186 then not sure why original driver even
>>>> using these API's.
>>>>
>>>>
>>> Sorry just took a look and driver supports T210 and prior tegra as well.
>>> T210 and prior supports legacy PD and this check is applicable for
>>> those. So we should add power domain device check for power off as well.
>>
>> You could fix it with a follow up patch. Please try to test that
>> power-off works properly, at least try to unload the driver module and
>> re-load it.
> 
> Agreed, this should have the same check as above for
> tegra_powergate_power_off(). It currently works fine because on Tegra186
> tegra_powergate_power_off() (and all the other legacy APIs for that
> matter) will abort early since no power gates are implemented. The AHCI
> driver doesn't check for errors, so this will just fail silently. It's
> better to be symmetric, though, and add the check in both paths.

I missed that tegra_powergate_power_off() usage isn't fatal if GENPD is
used, thank you for the clarification.

>>> But for T186, we should have GENPD working once we add runtime PM
>>> support to driver.
>>>
>>> Preetham/Thierry, Can you confirm where SATA is un powergated prior to
>>> kernel?
>>>
>>>
>>>> But as RPM is not implemented yet for this driver, GENPD will be OFF
>>>> but SATA is not in power-gate by the time kernel starts and
>>>> functionally works.
>>>>
>>>> But with RPM implementation, I guess we can do proper power gate on/off.
>>>>
>>
>> I now recalled that GENPD turns ON all domains by default and then turns
>> them OFF only when driver entered into the RPM-suspended state. This
>> means that AHCI GENPD should be always-ON for T186, which should be okay
>> if this doesn't break power sequences.
> 
> Yeah, the generic PM domain will just stay enabled after probe and until
> remove. This does not impact the power sequences because they have to be
> completely implemented in the power domains code anyway. With the legacy
> API we used to need more rigorous sequences in the individual drivers,
> but with generic PM domains none of that should be necessary, though it
> also doesn't hurt, so some of the unnecessary clock enablement code is
> kept for simplicity.
> 
> To be honest, I'm not sure if it's worth adding runtime PM support for
> this driver. If this top-level layer has a way of getting notification
> when no device was detected, then it might make some sense to turn off
> the power domain and the regulators again, but I'm not sure if that's
> the case. tegra_ahci_host_stop() seems like it might be usable for that
> so yeah, that might work. We currently do turn off the powergate in that
> case, so extending that power optimization to Tegra186 using runtime PM
> makes sense.

Alright, then this all should be good as-is.

