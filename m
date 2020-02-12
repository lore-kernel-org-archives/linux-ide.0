Return-Path: <SRS0=BUdv=4A=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72935C3B186
	for <linux-ide@archiver.kernel.org>; Wed, 12 Feb 2020 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D8B20714
	for <linux-ide@archiver.kernel.org>; Wed, 12 Feb 2020 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b29IfQRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLLcS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:32:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727264AbgBLLcS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Feb 2020 06:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZfKARYhDHAwscJobtxX4OuVdiv8pCmlPkNurxMoTgc=;
        b=b29IfQRjRogxiNodcuH/Cn8b7UJKKo+n9FxMYuBGnrPIUB0DILLrgmZ2zU1DGo0oIoix05
        CwAdo8nGP8xoqITAPW9/Mfp0S4KyRv7Oq/mB4ZC5ObXTaZ/FLEbwq/wfvr9chakEzm+5fw
        FprdNHOVt/7jdzTu8QYG30guL/TlzwQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-ObL5mQYoPzCxJmnczfG02w-1; Wed, 12 Feb 2020 06:32:15 -0500
X-MC-Unique: ObL5mQYoPzCxJmnczfG02w-1
Received: by mail-wr1-f70.google.com with SMTP id r1so688089wrc.15
        for <linux-ide@vger.kernel.org>; Wed, 12 Feb 2020 03:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZfKARYhDHAwscJobtxX4OuVdiv8pCmlPkNurxMoTgc=;
        b=qJCodT3Za53tNTyNjN1NJ+zbNYnuVIRzf03+1OxP/lv0aSO+7chDdz5WKBEFHSMqE2
         YHVVuib4p3s/P3uVwzyM51Tg1G9GewoYsCYBy9VEjsllzVwTnNbyhXIrxl1x6rBt+/DO
         cS9P09X27O6uoH+EWB65K1worSzUWG5vW9V1fRdCN2LwKMtnwyLnJPX4bWC/WV2Y1mPI
         3EkmqcVTWri1rINHjVNmT6VPmOLHA15UFdno2iaNOq1bOLoIlkuLSnJVG24Rm/GhIEun
         Bvz3LQPnYNf7Juh4YNlX3IQmdV2qVnPOoyZWC2OB9JYfjsM9QdAxte+FFutg72V82ZzY
         3Umg==
X-Gm-Message-State: APjAAAXNq/K3IqhhYMgLB3QHMrrSA+S/wQrVmBhavqRhyXMmwQus9wcC
        YGRBLydvRGE+UgbcKYY/VwHRpA7iGKNrX7oSz99MLtbbRrLFv1SLrFlQUPkPd++gB9t0Onm7EI5
        xaygVq+15e3Nc/WTSs+Wk
X-Received: by 2002:adf:db48:: with SMTP id f8mr13970200wrj.146.1581507134356;
        Wed, 12 Feb 2020 03:32:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqymdOikcn0q6iSdZabHUxgl+9cWdFUpP0jpg5cIEafgdtGAaLv1tKjeCLeHAmz/EKVsxY5zDA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr13970177wrj.146.1581507134068;
        Wed, 12 Feb 2020 03:32:14 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id f207sm398575wme.9.2020.02.12.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:32:13 -0800 (PST)
Subject: Re: [PATCH] ata: ahci_platform: add 32-bit quirk for dwc-ahci
To:     Roger Quadros <rogerq@ti.com>, axboe@kernel.dk
Cc:     vigneshr@ti.com, nsekhar@ti.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
References: <20200206111728.6703-1-rogerq@ti.com>
 <d3a80407-a40a-c9e4-830f-138cfe9b163c@redhat.com>
 <1c3ec10c-8505-a067-d51d-667f47d8d55b@ti.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <37c3ca6a-dc64-9ce9-e43b-03b12da6325e@redhat.com>
Date:   Wed, 12 Feb 2020 12:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1c3ec10c-8505-a067-d51d-667f47d8d55b@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 2/12/20 12:01 PM, Roger Quadros wrote:
> Hi,
> 
> On 06/02/2020 13:50, Hans de Goede wrote:
>> Hi,
>>
>> On 2/6/20 12:17 PM, Roger Quadros wrote:
>>> On TI Platforms using LPAE, SATA breaks with 64-bit DMA.
>>> Restrict it to 32-bit.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>   drivers/ata/ahci_platform.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>>> index 3aab2e3d57f3..b925dc54cfa5 100644
>>> --- a/drivers/ata/ahci_platform.c
>>> +++ b/drivers/ata/ahci_platform.c
>>> @@ -62,6 +62,9 @@ static int ahci_probe(struct platform_device *pdev)
>>>       if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>>>           hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>>> +    if (of_device_is_compatible(dev->of_node, "snps,dwc-ahci"))
>>> +        hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
>>> +
>>
>> The "snps,dwc-ahci" is a generic (non TI specific) compatible which
>> is e.g. also used on some exynos devices. So using that to key the
>> setting of the 32 bit flag seems wrong to me.
>>
>> IMHO it would be better to introduce a TI specific compatible
>> and use that to match on instead (and also adjust the dts files
>> accordingly).
> 
> Thinking further on this I think it is a bad idea to add a special
> binding because the IP is not different. It is just that it is
> wired differently on the TI SoC so DMA range is limited.
> 
> IMO the proper solution is to have the right dma-ranges property in the
> device tree. However, SATA platform driver is doing the wrong thing
> by overriding the dma masks.
> i.e. in ahci_platform_init_host() in libahci_platform.c >
>          if (hpriv->cap & HOST_CAP_64) {
>                  rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>                  if (rc) {
>                          rc = dma_coerce_mask_and_coherent(dev,
>                                                            DMA_BIT_MASK(32));
>                          if (rc) {
>                                  dev_err(dev, "Failed to enable 64-bit DMA.\n");
>                                  return rc;
>                          }
>                          dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
>                  }
>          }
> 
> This should be removed. Do you agree?

I agree with you in principal, but I'm afraid this might cause regressions for
existing hardware. We only do this if the host has set the CAP_64 flag,
this code is quite old, it comes from the following commit:

###
 From cc7a9e27562cd78a1dc885504086fab24addce40 Mon Sep 17 00:00:00 2001
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Date: Thu, 12 Jun 2014 12:40:23 -0500
Subject: [PATCH v3] ahci: Check and set 64-bit DMA mask for platform AHCI driver

The current platform AHCI driver does not set the dma_mask correctly
for 64-bit DMA capable AHCI controller. This patch checks the AHCI
capability bit and set the dma_mask and coherent_dma_mask accordingly.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Suman Tripathi <stripathi@apm.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
###

Presumably this was added for a reason, I'm guessing this might come
from AMD's ARM server chips adventures, but I'm afraid that AHCI support
on other (ARM) SoC's has become to rely on this behavior too.

Maybe we can add a check to see if the mask was not already set and skip
setting the mask in that case ?

Regards,

Hans

