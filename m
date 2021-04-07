Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A2C433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71090611C9
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhDGXZc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhDGXZc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 19:25:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE852C061760;
        Wed,  7 Apr 2021 16:25:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h19so784126lfu.9;
        Wed, 07 Apr 2021 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=94h9zhuuoZjZJG0qodCDNY/t7MKNasaws+00zTsAsaE=;
        b=Rncn5izKr2aD/p+7TPO+/F2VskBfDiL8ocr5SbGD1mpK8pVz4fH9GuvGLh7QMt2AdR
         lhfp4hzNXb7tzQViyUl4L1yBsjZw7cm/LlMBI0JS6aVSdek6ywO7eTTGWlUavL1yxz5k
         enIins9C516c3qlvp2Co4b6iGucJX/iGZqhug7R+C85vPiWoDpjSLXGyJ2jbn8LGBI62
         0Inp0Vvjdvgf+J40jKIr1cReVFNqERn7nTiGq8BJH2woCoq+CzGaDexR0UZEE0Y8Q28D
         p20RuLWT31T7hb+7nOs407jCDr08tbdZSD+mvLIBmqisuvTpFdTeJnp1gLAoXkn0XkiO
         /IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94h9zhuuoZjZJG0qodCDNY/t7MKNasaws+00zTsAsaE=;
        b=cXP1ldzbX1wPQbzl2qKYjpecZvIu6pzjXUgT1Quzb+9d8uVreYVlenyIIBzR/Bly9K
         mmWOaZqdJ7vittoCZAtooKtfX0TBA+2Qn8qk2SH1g0zPwknvYykuoRGsoLubbfOVLrWP
         SpcULChUvM0SBJ/axT6g+WWJz70lacKCYl6nITZBHyuJ8kPJFd5tzN+TUCVbWyhqbmaS
         cxrsKbf944HEuCcw29qwKgBICrkXL12VI8AA0p0wthcn7nv1eLE/VrtP22Ad05yx8n7O
         Cqoc3StwIkXQf6KxXiKHS/Bq4Bceb+6Mm1vBEwUt7eE7sdZvP87GyQ5bwtJ4FexQ2dZP
         2iaw==
X-Gm-Message-State: AOAM5316C5d95D0uJHod88L+0tS+CkpTRY1s8YAtMJJK4gCBGmSqCy5k
        CFR+lUjSBTCIsDmJxL/fEO48DZPJgV0=
X-Google-Smtp-Source: ABdhPJyypgEFoDGX0vbaMG5H5+Zri7dEyUhFXDai3JlFHxX7hYKglgvoqbpfJjqFIoCZwPP1pKvILA==
X-Received: by 2002:a05:6512:6d6:: with SMTP id u22mr3965920lff.386.1617837920240;
        Wed, 07 Apr 2021 16:25:20 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru. [109.252.193.85])
        by smtp.googlemail.com with ESMTPSA id d27sm2624528lfv.226.2021.04.07.16.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 16:25:19 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
 <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
 <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
 <01fd01ab-f4e7-57ee-2ad7-2aabaeb92a0e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2ef2a124-9e4b-bc02-3830-8ef077638ced@gmail.com>
Date:   Thu, 8 Apr 2021 02:25:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <01fd01ab-f4e7-57ee-2ad7-2aabaeb92a0e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

08.04.2021 02:00, Sowjanya Komatineni пишет:
> 
> On 4/7/21 3:57 PM, Sowjanya Komatineni wrote:
>>
>> On 4/7/21 2:36 PM, Dmitry Osipenko wrote:
>>> 07.04.2021 04:25, Sowjanya Komatineni пишет:
>>>> +    if (!tegra->pdev->dev.pm_domain) {
>>>> +        ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
>>>> +                            tegra->sata_clk,
>>>> +                            tegra->sata_rst);
>>>> +        if (ret)
>>>> +            goto disable_regulators;
>>>> +    }
>>> Hi,
>>>
>>> Why you haven't added condition for tegra_powergate_power_off()? I think
>>> it should break GENPD and legacy PD API isn't not supported by T186
>>> at all.
>>>
>>> I'm also not sure whether the power up/down sequence is correct using
>>> GENPD.
>>>
>>> Moreover the driver doesn't support runtime PM, so GENPD should be
>>> always off?
>>
>> This driver already using legacy PD API's so thought its supported and
>> added power domain device check during powergate_sequence_power_up and
>> yes same should apply for powergate_power_off as well. But if legacy
>> PD is not supported by T186 then not sure why original driver even
>> using these API's.
>>
>>
> Sorry just took a look and driver supports T210 and prior tegra as well.
> T210 and prior supports legacy PD and this check is applicable for
> those. So we should add power domain device check for power off as well.

You could fix it with a follow up patch. Please try to test that
power-off works properly, at least try to unload the driver module and
re-load it.

> But for T186, we should have GENPD working once we add runtime PM
> support to driver.
> 
> Preetham/Thierry, Can you confirm where SATA is un powergated prior to
> kernel?
> 
> 
>> But as RPM is not implemented yet for this driver, GENPD will be OFF
>> but SATA is not in power-gate by the time kernel starts and
>> functionally works.
>>
>> But with RPM implementation, I guess we can do proper power gate on/off.
>>

I now recalled that GENPD turns ON all domains by default and then turns
them OFF only when driver entered into the RPM-suspended state. This
means that AHCI GENPD should be always-ON for T186, which should be okay
if this doesn't break power sequences.
