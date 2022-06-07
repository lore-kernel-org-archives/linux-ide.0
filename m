Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54BC43334
	for <linux-ide@archiver.kernel.org>; Tue,  7 Jun 2022 09:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiFGJu7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Jun 2022 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiFGJuW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2022 05:50:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A09EBA84
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 02:49:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so5789024lfa.11
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2022 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=osMFyRNZSbpgD+ikzJcSTdM5bItB0V1zO0LHaEiyZKM=;
        b=dMM+KcZzUAdkYRQjSOWwVxXLgSWQvAN8gqvj/mDFFtXMqaShMsce7TQqfpv3ljmtUK
         DkhkHItyEuU9qkNMZbfgpnmfVFs3UsFPRPXg1XGZF7m/AZniu/SsMXEFo43JFStMlAjd
         UnFqA2kUH07fNXpXU0SaclJdwV2ML6RGKdBl2PwQ5tIkdMCl19XnBYowtpC2nm/TsJhq
         ZucDIuWJXf99fKl4+c47OTA4dnd0TLiDNMwsxoDJM5LKDJka5fOiogiWnSPNReX3/aGX
         fxeAVGTyKmG5VrRpbYGnXOdZSKn7/XSihPXCZDLnNob16ZG8ogzFFDTfNcxPtj8Rcuo2
         wTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osMFyRNZSbpgD+ikzJcSTdM5bItB0V1zO0LHaEiyZKM=;
        b=e4+kcRrxjvTh1mj8PJ4DlXX89+Kk29af73j2+MYAncG1qoTPf/IwX3i+/6/W61wRJ+
         rgs8nw0znGFfZNiYD0Qml4DrmujC/WAI6ScWmZu1ZEJByYHpM+D6q0kyIs8joGXIBp+y
         FLPgwUbzeoD/lEoAMfF/ejfDAIaXH48t4V04Dm/d47jllcBZ15zt3DNkDeBe/vckNlcf
         wZEF+vUVp+DCmxbP2Pn1Mt7jcTrorsjmFB2xt8tPbkNbC4DIi3UkUapt0F2PYWD8poS5
         ujKgkSD0TlaVVYFyPg/bF9GpfENN7r8yRSghsiuy1p2l3/9le6zCWVHXszM5sz/6ByWw
         9q5g==
X-Gm-Message-State: AOAM531N46uaO5JL3lSD8LCUz5lBsITAT86SBAqA5tG8Q5W4k+oOCQBF
        VXbEk0T9VRLGL0UeJYmAZ/ylQngCwCc=
X-Google-Smtp-Source: ABdhPJyuXx3d9NhA026LzGUawgqALjcX+cbRUxhi0LeX2lK0fhKhBrL0e+cguX5xorcu20L9r2f3Yw==
X-Received: by 2002:a05:6512:31d4:b0:479:78d:9c96 with SMTP id j20-20020a05651231d400b00479078d9c96mr18851486lfe.121.1654595347252;
        Tue, 07 Jun 2022 02:49:07 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.79.94])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e918f000000b00255804c185csm1741123ljg.22.2022.06.07.02.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 02:49:06 -0700 (PDT)
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
 <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
 <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
 <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ac79bf20-5db0-90fa-380d-3e16f81bd79f@gmail.com>
Date:   Tue, 7 Jun 2022 12:49:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/7/22 3:37 AM, Damien Le Moal wrote:

[...]
>>>> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
>>>> ata_bitfield_name_match() macro which leads to reading such kind of
>>>> nonsense from them:
>>>>
>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
>>>> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
>>>> XFER_PIO_0
>>>>
>>>> Using the correct ata_bitfield_name_search() macro fixes that:
>>>>
>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>> XFER_PIO_4
>>>
>>> Looks good, but Documentation/ABI/testing/sysfs-ata says:
>>
>>    Completely forgot that the sysfs files are documented as ABIs... :-(
>>    Hm, shouldn't that file be added to the libata's entry in MAINTAINERS?

   So what's your opinion on that idea?
>>> pio_mode:       (RO) Transfer modes supported by the device when
>>>                 in PIO mode. Mostly used by PATA device.
>>>
>>> xfer_mode:      (RO) Current transfer mode
>>>
>>> dma_mode:       (RO) Transfer modes supported by the device when
>>>                 in DMA mode. Mostly used by PATA device.
>>>
>>> which seems incorrect/badly worded for pio_mode and dma_mode. Since these
>>> 2 sysfs attributes do not actually device the pio mask (list of supported
>>
>>    Device?
> 
> advertise :)

   Makes sense now. :-)

>>> pio modes) but the pio mode that will be used for that device, we should
>>> reword, no ?
>>
>>    Yes, of course. :-)
>>
>>> What about:
>>>
>>> pio_mode:       (RO) Transfer mode used by the device when
>>>                 in PIO mode. Mostly used by PATA device.
>>>
>>> xfer_mode:      (RO) Current transfer mode
>>>
>>> dma_mode:       (RO) Transfer mode used by the device when
>>>                 in DMA mode. Mostly used by PATA device.
>>
>>    Sounds quite tautological... :-)
>>    What about:
>>
>> {dma|pio}_mode: (RO) {DMA|PIO} transfer mode used by the device.
>>                 Mostly used by PATA devices.
>>
>>    I think this should be done in the same patch. Or would you prefer 2 patches?
> 
> Let's do 2 patches. Not sure if you can find a fixes tag for the doc update

   It'll be the same tag.

> though. But we should not aggregate the 2 attributes as you did. These doc files
> have a defined format and may not be happy with that merged syntax.

   Sorry about that -- I did that just for the mail... :-)

MBR, Sergey
