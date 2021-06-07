Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC71C48BC2
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C4861208
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFGITO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGITO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:19:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40BC061766;
        Mon,  7 Jun 2021 01:17:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h12so9680078pfe.2;
        Mon, 07 Jun 2021 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oYwfRdrUJ6EWWKBSl5elU0UPL7dyK28hAskZ8R8zVEU=;
        b=ckicI+f3cyBdSBGXg3ldJz2ym8jxIk/7Tw3FCbPOh4JSZroSTOnyUDfX86p3ObTw5E
         SRxv50uWPRKyrUFpZ7h0yQUbZGpNtmApZ8O+w8Lq9PzeNW8CRUxEEmoN5eMvbxAMOtya
         MCiNOlDODCR8Oh21ZO9ZOYLUhw3vXfAiZj/KKP/1nu6yU5uNq2s5h/w5+2Ref9/V9+wB
         gu9Oo0ZEeaUuCdS6NydNraJq6eJyegm4Qjx1azjCM7QI4um0Z7pWWBPuhbk0OEvXB2G3
         4pOPym+XHWoS/2GEraJJM/cGxKp2Y4OJgM+oMHAMLEYWxEBV6vgitwqhaylgra2q7gv+
         uUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oYwfRdrUJ6EWWKBSl5elU0UPL7dyK28hAskZ8R8zVEU=;
        b=d6E8sbANxPXlwIRAdeB50H35x1x+cpmI9Q7btbv9bpUR2asUUzjnqudEmnfUIXzkgd
         /hYsXobrCvtjTQU6IAoubvdmNkROa5ZJSs4ox2+5/L7mOEBa6izMmsmsF4c7CKaESfSg
         j7weoakW/fKv1tWTmaaKPVcuKu24ngo89SwplGbpwd4GM7P9k3acdznfpLmrIzbIn3yq
         WNSZ4a5nHx4jMCmu/59K2ZZy45fCwHvpI8vhDZVbbnBZQxRKbccpdoaSXLchjggGB6/r
         KfmpaE6NU7KTKzRuHjmW5+iSJy20LFFpbiZQYDirjaGJ1lH+LzJJAe7UPuwK1xAqiCNh
         PlKg==
X-Gm-Message-State: AOAM530kS51UByu6TFLDU5OBV7faItm5xAESc/wmOf00LDYEls1gDI4z
        XM7g57cYtcp+OaOzMx+jQ/8=
X-Google-Smtp-Source: ABdhPJyI5NnIXevmp5sjA6wfOfHvhcTfaWO3wnlzInGGMHmMzOfsl4NKDOnESKkvzBdnV1OYnkLoRQ==
X-Received: by 2002:a65:5288:: with SMTP id y8mr16720477pgp.31.1623053826729;
        Mon, 07 Jun 2021 01:17:06 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id c11sm11491093pjr.32.2021.06.07.01.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:17:06 -0700 (PDT)
Subject: Re: [PATCH] m68k: Fix multiplatform ISA support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdWxYJ-ZvbTUhcnye=3ztCp7qTHpX0aqLWKtXk2NEZx+Vg@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8b867324-b6a5-a0a8-a120-5b95f8b55c3e@gmail.com>
Date:   Mon, 7 Jun 2021 20:17:01 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWxYJ-ZvbTUhcnye=3ztCp7qTHpX0aqLWKtXk2NEZx+Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

thanks for your review!

Am 07.06.2021 um 19:49 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Sun, Jun 6, 2021 at 7:28 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Current io_mm.h uses address translation and ROM port IO primitives when
>> port addresses are below 1024, and raw untranslated MMIO IO primitives
>> else when CONFIG_ATARI_ROM_ISA is set. This is done regardless of the
>> m68k machine type a multi-platform kernel runs on. As a consequence,
>> the Q40 IDE driver in multiplatform kernels cannot work.
>> Conversely, the Atari IDE driver uses wrong address translation if a
>> multiplatform Q40 and Atari kernel does _not_ set CONFIG_ATARI_ROM_ISA.
>>
>> Replace MMIO by ISA IO primitives for addresses > 1024 (if isa_type
>> is ISA_TYPE_ENEC), and change the ISA address translation used for
>> Atari to a no-op for those addresses.
>>
>> Switch readb()/writeb() and readw()/writew() to their ISA equivalents
>> also. Change the address translation functions to return the identity
>> translation if CONFIG_ATARI_ROM_ISA is not defined, and set MULTI_ISA
>> for kernels where Q40 and Atari are both configured so this can actually
>> work (isa_type set to Q40 at compile time else).
>
> Thanks for your patch!
>
>> Fixes:  84b16b7b0d5c818fadc731a69965dc76dce0c91e
>
> Fixes: 84b16b7b0d5c818f ("m68k/atari: ROM port ISA adapter support")
>
> Hint:
>
>     $ git help fixes
>     'fixes' is aliased to 'show --format='Fixes: %h ("%s")' -s'
>     $ git fixes 84b16b7b0d5c818fadc731a69965dc76dce0c91e
>     Fixes: 84b16b7b0d5c818f ("m68k/atari: ROM port ISA adapter support")

Thanks, I'll change that.

>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
>> --- a/arch/m68k/include/asm/io_mm.h
>> +++ b/arch/m68k/include/asm/io_mm.h
>> @@ -113,7 +117,7 @@
>>
>>  #ifdef MULTI_ISA
>>  extern int isa_type;
>> -extern int isa_sex;
>> +extern int isa_sex;    /* Atari relies on this to be zero-initialized */
>
> Shouldn't that comment be next to its definition in
> arch/m68k/kernel/setup_mm.c?

I ended up dropping changes to that file, and would rather omit the 
comment here than touching setup_mm.c just for the sake of adding a 
comment.

We might omit the isa_sex = 0 stuff in setup_mm.c altogether, OTOH ...

>
>> @@ -135,9 +139,11 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>  #endif
>>  #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +    case ISA_TYPE_ENEC: if (addr < 1024)
>> +                               return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +                       fallthrough; /* not ROM port? fallback below! */
>>  #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>> +    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
>>      }
>
> Moving the default out of the switch() statement, as suggested by Finn,
> would make this more future-proof, as any case (not just the last one)
> can fall through to the default, using break.

OK, I take that to indicate the default may be changed in that way, and 
will move it outside the switch().

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
