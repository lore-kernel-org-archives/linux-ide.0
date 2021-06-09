Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B2C48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BD860FF2
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhFIHXy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:23:54 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43948 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhFIHXy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 03:23:54 -0400
Received: by mail-pf1-f176.google.com with SMTP id m7so4797038pfa.10;
        Wed, 09 Jun 2021 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=I7YuKV/mLWSJBIm8tSUThKJl8GuPf3PLyIEpqmpKE+s=;
        b=g7CTi2LkVQrx6Bcf/4B+1Fw3nIZOoKaFdObYLYxC0j8VAg9xarvqrpaerjxw7SmvwL
         Iq2UOaaxhX1TVyuXD0WNrziUlDRZPXxG/5az3ccZR8pYL4abAytn4oLt9gUI8DcSGlR+
         L3lBrBktTAC4FhKQFkgct5eTS8oTRDsM8S2mCXFU3+CrXGFjepo+B3impVscstpTjWSB
         V7CPVVrISBDCm6M0VlybmcMHzkeJNJkJcoCGTQZZ9mf/yr8+5FcJNAONKD9ttJNdZ1if
         gG6SUoKdpRGogkPE1ORWy/IwqMGxXid6Dk6i8bxg7TyBztONWzQ0brhlbtQhAYC4rq0L
         z5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I7YuKV/mLWSJBIm8tSUThKJl8GuPf3PLyIEpqmpKE+s=;
        b=FxDFu7Wxn8LAK2ZtA7Tpt2gAO94XKAjSTpKGgMV5/D9Bw/7TU6SBguqHV8Bc4d2DYF
         5+R0HwOSsfFqX2WH4BKKyoHzfV3Jb+ajb1elMIBfpiU9YI3X4Mlaz56YXu0ZtdGEgV5k
         GWlrFaGaQuz0Jd7J2C8C7bcrHk4ISgSerywJUtiqFYZ8Xdos62Jh96wvFyS4VJPm6+qb
         bMS8S57amAci4LQ8HDsDv6J4t9XzJBjUIjVdnFFIoem/nzlv4WV3/nSVE27+KWjy6Y5o
         qU+UvfKT7O7iknNW9srQNfFmNH19pVqlXLO1IGlzAH1flUztVMOp78nlBvdG+0FkjplP
         EPSw==
X-Gm-Message-State: AOAM530ayG2NyxBkqvINRTX+N4slFyvKB+7zLx2u5z1X3jNumIxISnLk
        fSkXMyAg1cCP8o4t98aadL5Wjp7pLeg=
X-Google-Smtp-Source: ABdhPJxvDnhAS+ykj0PAljdT9igsuEDFdz0yqGfknis2Lng/2wbHGDVEaWKvsn2lyGtzCPp6fNICHA==
X-Received: by 2002:a62:2944:0:b029:2e9:8ce5:b044 with SMTP id p65-20020a6229440000b02902e98ce5b044mr3827150pfp.3.1623223259848;
        Wed, 09 Jun 2021 00:20:59 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id z9sm12714390pfc.101.2021.06.09.00.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:20:59 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdWD-iECGSE5N+hUK-EdCTzMvhhgjRifih6sdx-NbOem1g@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6160bb74-c796-1b76-3b7d-ead3b5007299@gmail.com>
Date:   Wed, 9 Jun 2021 19:20:53 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWD-iECGSE5N+hUK-EdCTzMvhhgjRifih6sdx-NbOem1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 09.06.2021 um 18:35 schrieb Geert Uytterhoeven:
>> @@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>  #endif
>>  #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +                               return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +                       else
>> +                               return (u8 __iomem *)(addr);
>
> While putting a simple return on the same line as the case keyword,
> please start the if statement on a new line.

OK, changed that for v2.

Thanks,

	Michael

