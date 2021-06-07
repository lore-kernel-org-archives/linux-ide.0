Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5148AC47095
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195666102A
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFGUAz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:00:55 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:35833 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGUAy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 16:00:54 -0400
Received: by mail-pf1-f172.google.com with SMTP id h12so11089168pfe.2;
        Mon, 07 Jun 2021 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lKGKykqdX3l2lHrKO1Ga7RdgoyZwYN2DZgfrToJQoJg=;
        b=tHwaSrU8oT3NMHgAHYFxCggUcCyV3+nkmIs1d16zLqWUDs//JKbxhajw8p7DDjOjH2
         q5zbsNG/MTaWbfa5fA3+u6ce4Y9hpQEuh3DuZPMZUEwDi1u5XhYb6lrqTbt/m+yoI16G
         b0VQcnSzUeI4rF4XeaiDusi4RUPYtTP2a2kx+ZjD07eu+2ErA+In5a6VmaQ0tqAu+RLF
         OROH3h/wNwK/5OdYegJFqa/UPl+XjAZOnGKlU6SLORzrJMR60hCbyLHrgN0Y6QJV+w83
         71MLWXwFrD9Lbz/xv3w0SFZ3ff0b8TUCkHfN+hsmFrJun1APsBx1tXHss4Diw37X6KQd
         EOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lKGKykqdX3l2lHrKO1Ga7RdgoyZwYN2DZgfrToJQoJg=;
        b=NYf4Jz8LNPUhCXy1sP4CD83xawL0HLxg+A0HyHdudbh7aUGH6PfM9Co0aRr/58HVA8
         RVqJ4xHWyZj1e+zMKS8KHAmqDF1smsTSsU3zBEuhTGxBANMFEtABy+VSQTvpQZ+5dWla
         sRymdPRhLQpxPF5sVoaNE6bVxUHrujxGLKO0ZBZiFXmdtEXAaVJ8yOlJKnmIouA2xoJn
         bFgwnE5LznKzalF7KYg/Aqbv2aMpx50QmKkFM3hcGiiOmvTShJJ8tU3nZZbtCa6r6eyF
         lMZuGVxgQFdMIgKtU+LWHBJH+0KEjM8qCKMYpJeu0LBz0Pm85Cm7rveDs/3DTFT8P5NL
         oAFw==
X-Gm-Message-State: AOAM533gz9fSCcrIaJr9sJvD8AsgAYmxMV7PZ3n7EHuu1pD3hWg3VgiH
        H50i3gEqk+mlWfUvuMWFtQB9P+J7H+g=
X-Google-Smtp-Source: ABdhPJywe7pcdVy/glUi0frkOMyiq20cgMZHycTGjk8Q35F8S3biP+ctHo4LktQVL9cf4OQitP+QWw==
X-Received: by 2002:a05:6a00:1a11:b029:2e9:e204:42ae with SMTP id g17-20020a056a001a11b02902e9e20442aemr18999989pfv.20.1623095882958;
        Mon, 07 Jun 2021 12:58:02 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:200e:6f35:219a:3662? ([2001:df0:0:200c:200e:6f35:219a:3662])
        by smtp.gmail.com with ESMTPSA id pi8sm8288102pjb.52.2021.06.07.12.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 12:58:02 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>, ALeX Kazik <alex@kazik.de>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b2943f57-396c-cfd7-7064-4a1351585fa3@gmail.com>
Date:   Tue, 8 Jun 2021 07:57:57 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On 7/06/21 11:15 pm, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Add code to support 10 Mbit and 100 Mbit mode for APNE driver.
>>
>> A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
>> to word access as required by the 100 Mbit cards.
>>
>> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
>> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
>> Kazik <alex@kazik.de>.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> --- a/arch/m68k/include/asm/io_mm.h
>> +++ b/arch/m68k/include/asm/io_mm.h
>> @@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>>   }
>>
>>
>> -#define isa_inb(port)      in_8(isa_itb(port))
>>   #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
>>   #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
>>   #define isa_outb(val,port) out_8(isa_itb(port),(val))
>>   #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
>>   #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
>>
>> +/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
>> + * dead code if MULTI_ISA is not set */
>> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
> This fails to compile due to a missing closing parenthesis.

Sorry - looks like brown paper bag time today. (I did say 'entirely 
untested'? Didn't expect such a thorough review for a first RFC patch ...)

Apologies,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
