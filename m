Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA0EC4743E
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB25611CA
	for <linux-ide@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFDViU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDViU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 17:38:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86913C061767;
        Fri,  4 Jun 2021 14:36:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so8172169pjz.3;
        Fri, 04 Jun 2021 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wGqdV4bNNz4VAcdMHyar3DhYCaMKnNzMvXRq2H+IWtI=;
        b=Yj3sYkqVhkpnvdu0jr0bWdQcYU9ZRNr5W+Y/Nqg/bbj7rsCFrD+nsOg8ujfNBMAvYY
         9Hmif3zF3KpJyh59w+74a1e4K6qfmmEOdaDKoAqWVFyGNhlGMinH4dmDOmssmDYhgBEz
         eFD4geLksXcNYoBPGTJuQXKFPqAeFJMvbdrixH3Xxac1j5UzdzDlyTPsRY3DM/2ELuHv
         q7yqhna0+h+2vEKzoiN3oEOZWXqchs0TNwPKKC8Sw24EaOmKT9FC3KsCZrwW6jlY/jxt
         oI8tOUAEMjs2SL217Dx2mvIkg81/NH3pFxQpKNkE5Ndo8ilx8dlHEAnmuYvtAeIY7Ib1
         +7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wGqdV4bNNz4VAcdMHyar3DhYCaMKnNzMvXRq2H+IWtI=;
        b=UvxDAnnt2i5N5gJ8+7kIabG9855yM9O4Pyfa784QjCSxLDKxmjkCHmuyJNlqATOBGN
         K751pzfHBbF0WGeBI+7Nh4kO3xcQFF8LhszZ33s/NA6VmHMEZ5gKToO0h1Fopp44nGue
         awGbPQAlloRo5Fcg9E9YZn/Q7siccVmbt3MSEsHuY/vXAreNIOGfpdsvMMQjP32lT8oE
         uX2JKJnEeT2JbN7hc67csinloKoguFb99GsYIWmrvIRdjedxbrZ3VA7gsDLeDI8wOXIy
         J5zjSirYUH0O7RLz3Xi6Wy6MR4Q1kFuPfGuNlTtuNa6vuF4Sm8D8akV075o8mJhtIoWR
         BUGA==
X-Gm-Message-State: AOAM531oivQr7K8VFrvGuuj0512hsdwtsX02nbWDNTRkXLpGWI01Ovvg
        WpyTzI2QfWbPdIhAtTNwT6PxOrAcqVM=
X-Google-Smtp-Source: ABdhPJzzhDuAKOdhODAvipxYTxxL6SC278eYPRwX9XeJiKiEWRZfGMD803btqx7HfIc3s3RQdGiisg==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr18683537pjq.173.1622842578852;
        Fri, 04 Jun 2021 14:36:18 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id r4sm2344685pff.197.2021.06.04.14.36.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:36:18 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <CAMuHMdU5ebmsErLdy6EykCHNULsBVFCpVsz0H3gpTLUmH1tt7g@mail.gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <28042fd1-4a54-af21-347f-165b8e4e63b4@gmail.com>
Date:   Sat, 5 Jun 2021 09:36:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU5ebmsErLdy6EykCHNULsBVFCpVsz0H3gpTLUmH1tt7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 04.06.2021 um 19:54 schrieb Geert Uytterhoeven:
>>> I have to wonder whether there is a nice simple definition for MULTI_ISA.
>>
>> As I understand it, MULTI_ISA means that different byte orders and/or
>> different address translations need to be used in the same kernel, so
>> all that cannot be decided at build time.
>>
>> As long as there is only a single platform that will use this code (ISA
>> only used on a single platform, and neither Atari IDE nor EtherNEC
>> used), MULTI_ISA is not needed.
>>
>> If we have Kconfig symbols for 'single platform only', and
>> 'multi-platform ISA use', that might be shorter to write and easier to
>> understand. Geert?
>
> It would be nice to have that automatically, like with the current
> MULTI_ISA define (and all the MACH_* in arch/m68k/include/asm/setup.h).
> Perhaps we should extend kconfig syntax to define a group of
> related symbols, and to automatically generate CONFIG_FOO_MULTI or
> CONFIG_FOO_SINGLE (and even CONFIG_BAR_ONLY?) symbols?

I take it this is not supported by our current Kconfig syntax?

>
> group ISA
>      item ATARI_ROM_ISA
>      item AMIGA_PCMCIA
>      item Q40
>
> => CONFIG_ISA_MULTI or CONFIG_ISA_SINGLE (+ e.g. ATARI_ROM_ISA_ONLY
>    if appropriate).
>
> Are there other users who can benefit from this?

Nothing comes to mind immediately. But there will be other drivers 
shared between different architectures (Mac / PowerPC?) that might benefit.

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
