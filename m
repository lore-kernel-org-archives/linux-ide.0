Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EDC47082
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 03:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DA613EA
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 03:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFDDFq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:05:46 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:42863 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDDFq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2021 23:05:46 -0400
Received: by mail-pj1-f48.google.com with SMTP id l23-20020a17090a0717b029016ae774f973so4415548pjl.1;
        Thu, 03 Jun 2021 20:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=foBcKM8oQKpGRFiMtx1DpQAvBm6is28Y9YbDkPjGUQg=;
        b=EGcbkKLVt0HYJCwV6lZ0mbL6sJJYlyhiHYqHJ8cs7Hs7SzjKGE9bnrTWJHw7gIWnx0
         EdUqI9q+z0j5ebpA2e0+P9X5XO2PGRtp/brYmIodiYU/64q9XPH/2H8H1TP1+2vwENO3
         ep3UlEk8fEELo/HxvMSduwMffY2yrrL7y37EizBR1hgsEn649LKKxfLQULqZbaky2UYx
         v1dxHIKmQUhsjwzumcHtyESqe4QqIkIHJr4E21OmZBmYqWZmxtBk/bif8QlDckDEVn5x
         xm2tW8d8UFNInDmlpP40HnVNfkvQp07caUM+S4A7GyV6qMpXK2u/ONNEUub/AUBrwDPg
         mB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=foBcKM8oQKpGRFiMtx1DpQAvBm6is28Y9YbDkPjGUQg=;
        b=EFq+W0QfIjr8tS52cw+7O55PydqJTe2DcnJ5bOvVJrpyxs644RfyOub2/YN/Lqp3//
         MqFcltI6PDv1zMBwozm6Qjf0SsnA4MFOH03NBY0h6W53opj+fBW75w8Y0iD59+15y26x
         J3yy924A4YEr86Hm0veocyg47ypZqlEKImy5FFa8rQodNeuexzhBO3VHkwpe3FQuCr0I
         iTvQZtKsLTAsZnSyEZPZdCsaVevCQw+iH3GU8JIvIvlzVtDxQPseYONbchR1GqWSQdTW
         iBzpXQPmLdjLsfBCarxMqrFnBhcgvSYUxmHB0tLwYuuIVWqUqxbbwX4Mem5BncwbWTwd
         Vn7Q==
X-Gm-Message-State: AOAM5319dwesOJLWIl9MMXfnBhNS+rzuADjNMKXam75mDHUlYCThWaYX
        n2p6MKf5NuKrIWAb2byAeVAtwbYBdmk=
X-Google-Smtp-Source: ABdhPJw+voB7sAyb14soqVCRXkrF7yIxmAb4X464HfFk+NNDT4fiAHh/vyZZdWso3NOTP0f5JeWfFQ==
X-Received: by 2002:a17:902:e9cb:b029:101:cebc:b8d with SMTP id 11-20020a170902e9cbb0290101cebc0b8dmr2251212plk.5.1622775767005;
        Thu, 03 Jun 2021 20:02:47 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id 125sm356248pfg.52.2021.06.03.20.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 20:02:46 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] m68k: setup_mm.c: set isa_sex for Atari if
 ATARI_ROM_ISA not used
To:     Finn Thain <fthain@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-3-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdWhdSVCktaVZY+XHeyfeP8uw-RAcOWe--HsBn9Qf5_NOQ@mail.gmail.com>
 <ea80060f-983b-8adb-93f9-e2b84ea5f4b5@gmail.com>
 <7ecc9c4e-3ee4-9cf7-a45d-fa84d5d2a62@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ab0fa9fd-75f4-4b55-f2de-8c19f34b310c@gmail.com>
Date:   Fri, 4 Jun 2021 15:02:41 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <7ecc9c4e-3ee4-9cf7-a45d-fa84d5d2a62@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 03.06.2021 um 20:29 schrieb Finn Thain:
>>> However, this is inside the CONFIG_ISA && MULTI_ISA block, so what
>>> kind of ISA does this correspond to?
>>
>> No ISA at all in that case, but since we have to route all readw() calls
>> through isa_readw() for the sake of generality if we want to support Q40
>> ISA and Atari MMIO in the same kernel image, we need to make sure
>> isa_readw() does the right thing on Atari if CONFIG_ISA is set.
>>
>> I know io_mm.h says it's about various ISA bridges, but as I found out,
>> drivers using only MMIO are also affected by these definitions.
>>
>> 'Maze' does not begin to describe it, 'mess' might be getting closer,
>> but I can't see how we would avoid use of definitions in io_mm.h by
>> non-ISA drivers.
>>
>
> It seems that the need for explicit zero initialization has more to do
> with subtelty over in asm/io_mm.h than anything else. If so, it would be
> better to add commentary there than to add redundant code here.

OK, I'll drop this one and rely on default zero initialization of 
globals instead.

More explicit setting of MULTI_ISA along with comments will be included 
in v2 of the remaining patch.

Thanks!

	Michael
