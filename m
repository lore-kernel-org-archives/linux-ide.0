Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27ABC27C40
	for <linux-ide@archiver.kernel.org>; Thu, 24 Aug 2023 01:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjHXBuS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 21:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbjHXBt7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 21:49:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CB12C;
        Wed, 23 Aug 2023 18:49:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf55a81eeaso30460925ad.0;
        Wed, 23 Aug 2023 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692841797; x=1693446597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tthPILBRIEBKRZiDx52H4Wr+VQy3aqNFk8k4wJEbVCI=;
        b=h9yoQP95iHCr4ndhWRKdvXmn9xWTZytRbNV/cunAXSQBLiG7SDfOo5Co5/0I5mGcyc
         066pfRzLXAvLkShdl2QScaIAyW4C9jTaXIAMXMAnEsJVl/ZdToEvg1tI7dbJ93MTfuAK
         0+wWzt6jDW9IfUm93m2akvDKQsjHJDeDSl7SF8E1Z7ZjiiK+CwVtz9mHF7nTGEV9IPZP
         8ET6k2rx+vMIFpHgla4JNnD93QgZyL480+uHZO1jhIm3btHtkd3Gxb1N+ZSjpuKj3/tI
         uuVJSEGDkJzvZc+1JbklIi3RXzGjnUdt7HBVaUGiRTPE07pkopTavL4v4z6wcc3gaqO2
         vH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692841797; x=1693446597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tthPILBRIEBKRZiDx52H4Wr+VQy3aqNFk8k4wJEbVCI=;
        b=gV9eQIkiW3ILvW/dO6Nnu6YA9YzGBR2icUg8tKBqbrGmmEp3vgineOYLc4mPmg9wWM
         DUywZu6YhjXKKY4hwn2LKVJmaD6QYdxYvDRyxBwB9H0Q7iCGqK+7NRsDSyuLcb/RfZWA
         CWjzNQ22xaxzlNQRjAnbXRNSkfOy954daD6j9PMNpQpj0mdtKv0MJQhr7PdTf56Vgjcf
         2jIT6ma2S9AwXMsAoHf1MTMtz1pmuAeGgzj9fWn8RQFrD/i3gXC08JCegZQCXpzAEMrC
         GeS3gscQq3tjTuzFGm1s40Da9gnJzJnEgcN+gsnQjqbkO9Ggb3H7fH8odeBj9oN3U70P
         Z+Ew==
X-Gm-Message-State: AOJu0YxguO4a65TQk8r6gw4y+D9GN4jBCNmBWYAGRXx/kIiWDtGCfHer
        LBx+a6oUeVIB+t475CXQFhgClwarBhQ=
X-Google-Smtp-Source: AGHT+IFb8B9SuJppbcm5XXY26FsHWAQ0JMy5cIqLy2MawAt2tT9X4kdGiARzYXZhfxBn2hr/FMQWUg==
X-Received: by 2002:a17:902:c1c4:b0:1bc:73bf:304c with SMTP id c4-20020a170902c1c400b001bc73bf304cmr11543419plc.48.1692841796832;
        Wed, 23 Aug 2023 18:49:56 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:34d2:df92:ba7c:a2e2? ([2001:df0:0:200c:34d2:df92:ba7c:a2e2])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b8a3dd5a4asm11498052plg.283.2023.08.23.18.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 18:49:56 -0700 (PDT)
Message-ID: <4f3d3973-cec5-803e-9588-d5d7c20a41f8@gmail.com>
Date:   Thu, 24 Aug 2023 13:49:50 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-3-schmitzmic@gmail.com>
 <56654dc7-37e7-1fd7-0d3f-647563f4cc5a@omp.ru>
 <35b28bcb-13ba-fafc-a30b-d84eb3b6bbea@kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <35b28bcb-13ba-fafc-a30b-d84eb3b6bbea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Damien,

On 24/08/23 11:03, Damien Le Moal wrote:
> On 8/24/23 01:35, Sergey Shtylyov wrote:
>> On 8/23/23 1:13 AM, Michael Schmitz wrote:
>>
>>> Some users of pata_falcon on Q40 have IDE disks in default
>>> IDE little endian byte order, whereas legacy disks use
>>> host-native big-endian byte order as on the Atari Falcon.
>>>
>>> Add module parameter 'data_swab' to allow connecting drives
>>> with non-native data byte order. Drives selected by the
>>> data_swap bit mask will have their user data byte-swapped to
>>> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
>>> all user data on drive B, leaving data on drive A in native
>>> byte order. On Q40, drives on a second IDE interface may be
>>> added to the bit mask as bits 2 and 3.
>>>
>>> Default setting is no byte swapping, i.e. compatibility with
>>> the native Falcon or Q40 operating system disk format.
>>>
>>> Cc: William R Sowerbutts <will@sowerbutts.com>
>>> Cc: Finn Thain <fthain@linux-m68k.org>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Tested-by: William R Sowerbutts <will@sowerbutts.com>
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [...]
>>
>>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>>> index 3841ea200bcb..7cf15bd9764a 100644
>>> --- a/drivers/ata/pata_falcon.c
>>> +++ b/drivers/ata/pata_falcon.c
>> [...]
>>> @@ -194,6 +199,9 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
>>>   	ata_port_desc(ap, "cmd %px ctl %px data %pa",
>>>   		      base, ctl_base, &ap->ioaddr.data_addr);
>>>   
>>> +	ap->private_data = (void *)(uintptr_t)(pdev->id > 0 ?
>>> +		pata_falcon_swap_mask >> 2 : pata_falcon_swap_mask);
>>     How about:
>>
>> 	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >>
>> 			   (pdev->id > 0 ? 2 : 0));
> This is so hard to decode... Let's please spell this out.
> Something like:
>
> 	int shift;
>
> 	if (pdev->id)

Atari Falcon has pdev->id==-1, so this must be 'if (pdev->id > 0)' here.

(Testing for pdev->id nonzero did work in earlier versions of my patch 
because patch 3 changed the platform device ID on Atari. That patch had 
the potential to confuse user space so I dropped it from v3 on.)

> 		shift = 2;
> 	else
> 		shift = 0;

No need for the 'else' if we initialize shift above (as is done for irq, 
io_offset and reg_shift).

> 	ap->private_data = (uintptr_t)(pata_falcon_swap_mask >> shift);
>
> This is initialization, so no need to try to optimize and rather privilege clear
> code.

Hmm - or maybe I'll leave that spelled out as you suggest.

Cheers,

     Michael

>
>> [...]
>>
>> MBR, Sergey
