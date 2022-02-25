Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D932C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiBYVT6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiBYVT5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2022 16:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E551F0803
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645823964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gZbc4TcaCZdLZxV1MMHprMxNzXnHBsUW/ffb0ZS4Zs=;
        b=TV6bBNI1cf73S3erROIogYUr2cN5wH/P+/IdY1IK0TW2CmduQ/9wonCAz/CLsMH1F0vJCE
        c4dlxgqlKAbByvoAoIOMy23SaheZbtJn0PZyt6AABYcvIaF4IaE3pZsaEUdyYBoOmLb/2L
        3M2c1CZxqXqpKiZMvjcEsgxUrgZqPgE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-Dp1gFfi9OzuDAMx5bB_NvA-1; Fri, 25 Feb 2022 16:19:22 -0500
X-MC-Unique: Dp1gFfi9OzuDAMx5bB_NvA-1
Received: by mail-ej1-f70.google.com with SMTP id la22-20020a170907781600b006a7884de505so3143967ejc.7
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 13:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2gZbc4TcaCZdLZxV1MMHprMxNzXnHBsUW/ffb0ZS4Zs=;
        b=sbOGY6ksKZZDTv1V6s60A+eb3SnkaMgakSpKvPmVPxMREWUGYGFX7CY+Tr4ri8xwSN
         Xzzc3LFRcW05KN55gIs2xxA3HUeD4Hn+bGLlIILad16vtxdeBHyX+wpkzAevqXj3JYry
         AqVcuCVqgqW8uHHg5d8gxzrNDEmBpRjXLuXokHeAxVAYRhEy1NR1kr46Ma1LRZUvtVTZ
         Y+C03yiSbAHciNx32hzU4a7uF8h7GfPQltMmqSyiwBB+EpIpZlI9ajcKjxz8spV+cqYp
         Sh49FvoKL2MEOxJWQH1Ej67gBnRqyW+LcT+nzrvsN4q+kyRDy9rtO+SEto324v1V1aDt
         HRzw==
X-Gm-Message-State: AOAM532EntJ/QhNNysfzjxIDdqvTPaeLSKP1FVmQPYOFLnQcGYSv9lFs
        DE4pU7RgwDT9FtQUO+wFVpj3+62EAIDW4SSbT4oli427h2eRWt7xSE83OvBvwUKsXs0X4EGB+YX
        Jmxml5Cx+dWYhsAK/0jYL
X-Received: by 2002:a05:6402:4245:b0:410:ee7d:8f0b with SMTP id g5-20020a056402424500b00410ee7d8f0bmr8904314edb.295.1645823961560;
        Fri, 25 Feb 2022 13:19:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmqY6RF/BPUMEIC5oni6wZZYqdjd6+b5CqZP0pP7QZowDenIZ9VizpuZ6rq2SBTitkMaH3kg==
X-Received: by 2002:a05:6402:4245:b0:410:ee7d:8f0b with SMTP id g5-20020a056402424500b00410ee7d8f0bmr8904301edb.295.1645823961354;
        Fri, 25 Feb 2022 13:19:21 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm1866517edq.50.2022.02.25.13.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:19:20 -0800 (PST)
Message-ID: <7ab071a2-4e5e-9aea-6887-d3e4281de607@redhat.com>
Date:   Fri, 25 Feb 2022 22:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
References: <20220225061113.223920-1-mario.limonciello@amd.com>
 <Yhj9Pdp/sHASmBw4@infradead.org>
 <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
 <BL1PR12MB5157D6984E5855701A9449E0E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <ee9a51e2-1733-dcd5-7514-0b8d1c1fa430@redhat.com>
 <BL1PR12MB5157B104CF62D747587A0412E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157B104CF62D747587A0412E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/25/22 22:13, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
>>>>>> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
>>>>>>> This board definition was originally created for mobile devices to
>>>>>>> designate default link power managmeent policy to influence runtime
>>>>>>> power consumption.
>>>>>>>
>>>>>>> As this is interesting for more than just mobile designs, rename the
>>>>>>> board to `board_ahci_low_power` to make it clear it is about default
>>>>>>> policy.
>>>>>>
>>>>>> Is there any good reason to not just apply the policy to all devices
>>>>>> by default?
>>>>>
>>>>> That sure would make this all cleaner.
>>>>>
>>>>> I think Hans knows more of the history here than anyone else.  I had
>>>>> presumed there was some data loss scenarios with some of the older
>>>>> chipsets.
>>>>
>>>> When I first introduced this change there were reports of crashes and
>>>> data corruption caused by setting the policy to min_power, these were
>>>> tied to some motherboards and/or to some drives.
>>>>
>>>> This is the whole reason why I only enabled this on a subset of all the
>>>> AHCI chipsets.
>>>>
>>>> At least on devices with a chipset which is currently marked as
>>>> mobile, the motherboard specific issues could be fixed with a BIOS
>>>> update. But I doubt that similar BIOS fixes have also been rolled
>>>> out to all desktop boards (and have been applied by all users),
>>>> and I also don't know about older boards.
>>>>
>>>> So enabling this on all chipsets is definitely not without risks.
>>>>
>>>
>>> This was before min_power_with_partial and min_power_with_dipm
>>> were introduced though right?
>>
>> The issues where some laptops needed BIOS updates was with fedora
>> using min_power_with_dipm as default for mobile chipsets.
>>
> 
> Do you know if the drives actually supported slumber and partial? 
> I wonder if that was the real problem that they were being set when
> they shouldn't be.> 
> I added something for this in 2/2 in the RFC series you can look at.

Fedora defaults to ATA_LPM_MED_POWER_WITH_DIPM so patch 2/2 is
a no-op on Fedora; and IIRC (it has been a long time) the
need for BIOS updates on some mobile devices was with
standard Fedora kernels / settings.

Regards,

Hans




> 
>>>  Maybe another way to look at this
>>> is to drop the policy min_power, which overall is dangerous.
>>
>> Maybe, see above. I'm not going to block this if people want
>> to give this a try, but it is going to require someone keeping
>> a very close look at any issues popping up and we must be
>> prepared to roll-back the change if necessary.
>>
> 
> Per Paul's suggestion I sent out v3 of this series and then I sent
> out a separate RFC series (you're on CC).  For this type of
> thing if y'all think it makes sense to do.

