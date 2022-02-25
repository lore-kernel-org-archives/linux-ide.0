Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0869DC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Feb 2022 16:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiBYQQl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiBYQQk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2022 11:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33CE0285A84
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645805767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OEd/VtmTJwMrSGPhOxJTg9pxuU0lX+Y7uaWoPiMDHI=;
        b=dYA28GvOHcoyPVmeo6upNVASueVQlj0vd5XGzF9PwLD5sx0RPK0xHj9foSkUYcC+9qMN2F
        ztBXE+dd5uc65t03dsvMM2s/MeRMjZV7nssfUz+gOTktjI/NV9R/zYUiK1nRjNlZWDb4Ho
        UsMC+j5+E+2MskQ0GJXQOS7MdxHNdwc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-D5y961ACOGCYuat-LalzqA-1; Fri, 25 Feb 2022 11:16:06 -0500
X-MC-Unique: D5y961ACOGCYuat-LalzqA-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso2540191edh.6
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2022 08:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3OEd/VtmTJwMrSGPhOxJTg9pxuU0lX+Y7uaWoPiMDHI=;
        b=OT1emSyysWRWBu916rFvri0Yst+2r13wu6u30E8MR1FoByEOQtnqf+ijALhjwjCz28
         Mjj+gIsF7ve1w2e2fxhBnJcSrAlLwYPBBRGrR7XiagRUgLJiQFIYWedETRWSN0Gmv9Sv
         CJQNU80pV3RPm8Fj5PUuqp2thY7FDMk8msROPeb6VAipNPn/UcHgruPy+bedck9JLupS
         vZZtQhVdIh81wh9pyQ0CjkVkSgOJZ49qD9LE6pitBCxUbsh76loNJ1Yy9H7ltRttfRQE
         BXe41o4c09O8ekEVI9X9bK33IexqLSnYiJ/5sdyujuCQR+LlIP4BRhO0Jb1O49k8JdQU
         mjaA==
X-Gm-Message-State: AOAM530EZF8k6RNz07TAhfFBlFvoySnySYDVUiLz/WHPwWBPuuW4vJB5
        tu/lwq6T0FAgcg4tdKa0s5GzU9ux5K+cYG27RZ2XYynfgz6dtdIbnqv2lP1hVzaNbEnZMifRFQD
        UOnj1aPaxkEL3ZzcNkvTU
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id re28-20020a170906d8dc00b006cfd1d1db25mr6673710ejb.285.1645805764851;
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPMT+narGYqhLUuyTwbLAnY1OoMrWWhtWDKJmVqPtEW1vPN9oiz2mOUWtRBrRBFQDs0aYyKA==
X-Received: by 2002:a17:906:d8dc:b0:6cf:d1d1:db25 with SMTP id re28-20020a170906d8dc00b006cfd1d1db25mr6673693ejb.285.1645805764627;
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm1539540edv.62.2022.02.25.08.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:16:04 -0800 (PST)
Message-ID: <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
Date:   Fri, 25 Feb 2022 17:16:03 +0100
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/25/22 17:04, Limonciello, Mario wrote:
> [Public]
> 
>> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
>>> This board definition was originally created for mobile devices to
>>> designate default link power managmeent policy to influence runtime
>>> power consumption.
>>>
>>> As this is interesting for more than just mobile designs, rename the
>>> board to `board_ahci_low_power` to make it clear it is about default
>>> policy.
>>
>> Is there any good reason to not just apply the policy to all devices
>> by default?
> 
> That sure would make this all cleaner.
> 
> I think Hans knows more of the history here than anyone else.  I had
> presumed there was some data loss scenarios with some of the older
> chipsets.

When I first introduced this change there were reports of crashes and
data corruption caused by setting the policy to min_power, these were
tied to some motherboards and/or to some drives.

This is the whole reason why I only enabled this on a subset of all the
AHCI chipsets.

At least on devices with a chipset which is currently marked as
mobile, the motherboard specific issues could be fixed with a BIOS
update. But I doubt that similar BIOS fixes have also been rolled
out to all desktop boards (and have been applied by all users),
and I also don't know about older boards.

So enabling this on all chipsets is definitely not without risks.

Regards,

Hans




> 
> Hans?
> 

