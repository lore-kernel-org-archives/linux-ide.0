Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A4EE49AF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Aug 2023 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjHVTKv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjHVTKu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 15:10:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24751CF9;
        Tue, 22 Aug 2023 12:10:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so7583799e87.1;
        Tue, 22 Aug 2023 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692731445; x=1693336245;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac/h0h+I+1GzYqIyspUgEAqPDap+Q/+PaFcMaJrdGk0=;
        b=pIBUBKA44n/yjmm5J6q6ZK9+uTx1yfwxYCipyQniVb+gg5aXQa0T63DmhZ2/vSatPM
         XEq5sSODv/RzN1rXI3SzTqmSfyyScFH4dxa4ghb6OOcbPBE+v5qKr+VEtUhOk5RXM1mg
         aRyBlf/XpFAFOvsgPTRv6aSGnMu2tZ7kxGurwSs7U+zlRFSpo6rz4wg+HT1PjFYhQL+b
         bSrjwHAiRcFAY82air7LyIh9tCafK1Bx8jSjQfTV3e00IUCBdpejGtLhmEPvSaa9EFxO
         oeqG6ovzTScVUQqYWSL0yjMpfp7WATKK7ea+iTBK8djzQ/s11/dFxnCjFWPCG1gzFX8C
         HMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731445; x=1693336245;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac/h0h+I+1GzYqIyspUgEAqPDap+Q/+PaFcMaJrdGk0=;
        b=OV7WczwwZDScwvN5aD6XQUOAgzaIl77IyXzSFKihPDUXcbXVwN3XN0Kitdj1Ww2eap
         YkKEJE7iXsALr4Nm0zweInQZtz983S3sM9fE7u+/i1G+2ZWUWqlp5A+lBydoNmnSdByi
         cL3J/TdIfkBkgjfzg92nWqmpJpBhD5UJuxrcWx4GvZ6THCCcB5rRquDUobF7xf65F/2X
         6vdjpzSsK42R/GMYUZQdJ8pSuJTxCKTJMZdPsLyBnawybvSPwW8b8cpyAD+jussW4Nlo
         cKgZAACCAxpk/SUp4lyARaelIIlrWQdvxQR0g1ds/AUrNzZXlQ7L00kJW9zk+HxUsAQh
         IpFg==
X-Gm-Message-State: AOJu0YzY7/9tPXMewbpUhvK6YIbNyM/NWtj+d3gyxnWwtF/5J+IsPTyL
        ZOfxbk1IFvbLKMP18L4Q8e0=
X-Google-Smtp-Source: AGHT+IFX53DtK7pu9ZnGkG5CEbsovhmtS7p+gbDV7NudgBkAtIsK5bFqoDUvRYJacXdUhe7/zELrGQ==
X-Received: by 2002:a05:6512:4023:b0:4ff:8f45:677a with SMTP id br35-20020a056512402300b004ff8f45677amr9688694lfb.51.1692731444988;
        Tue, 22 Aug 2023 12:10:44 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a19a402000000b004fdfd4c1fcesm2295791lfc.36.2023.08.22.12.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:10:44 -0700 (PDT)
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
 <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
 <5e5217a4-837c-fac8-246c-15f8a2d46bfe@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7463b0e7-cc9c-c091-ab47-14d19a0daf07@gmail.com>
Date:   Tue, 22 Aug 2023 22:10:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5e5217a4-837c-fac8-246c-15f8a2d46bfe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 8/20/23 10:27 PM, Michael Schmitz wrote:
[...]

> thanks for reviewing - this has mostly been addressed in v2 or v3 (which I forgot to send to you, sorry). Damien asked for the patch title to be changed (now 'ata: pata_falcon: add data_swab option to byte-swap disk data) so you might have missed it on the list.

   I didn't want to repeat such request after him. :-)
   I'm subscribed to linux-ide thru my Gmail account, and I'm still not seeing
your further patch versions on the list... :-/

[...]

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
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

[...]

>>> diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
>>> index 346259e3bbc8..90488f565d6f 100644
>>> --- a/drivers/ata/pata_falcon.c
>>> +++ b/drivers/ata/pata_falcon.c
>>> @@ -33,6 +33,16 @@
>>>   #define DRV_NAME "pata_falcon"
>>>   #define DRV_VERSION "0.1.0"
>>>   +static int pata_falcon_swap_mask;
>>> +
>>> +module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
>>> +MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
>>     Hm, Greg KH keeps saying us that the module parameters belong to '90s. :-)

> What else can I use that would allow setting a driver parameter at boot time? This driver will be built-in pretty much all the time.

   I guess he means sysfs...

[...]

MBR, Sergey
