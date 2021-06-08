Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66600C4743D
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522BC61278
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhFHV6A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhFHV57 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 17:57:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DDC061574;
        Tue,  8 Jun 2021 14:56:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t17so1113564pga.5;
        Tue, 08 Jun 2021 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mr9J0RXtCDZq3pRoOBycR1dqunNt6hX8FuEJsnSVmro=;
        b=IO63RfGZ69ZgM942TEJFeYP5OftLiQp7RB3prmowsyo7ABGi4wwT2lNf/cekvvBQ16
         gRN9oHb2ETn3gUHwaZBPDFqGoJ0iVL3IOyefwqitQTn1DtDHLxXjaibRizAfKnBLKVEY
         OgA0ZzSQRUPycn+KGpf/q0X9ccWY4MNFkluG2sd5qNR0BpjAw/RdeW4Wrz2BPUpKGy8z
         XqNTJL4fipB8ydUqXrH81olOKLawWWINtzyy4eJI/YDssdC+62HtIDmykkmPTxJCGFeq
         8+1HSPaTVY/zsjAcvcIJZl7ONyE6VroBZGi8lI1e0wE983mP4oaX9qnV7UR6VPj9ShMm
         679g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mr9J0RXtCDZq3pRoOBycR1dqunNt6hX8FuEJsnSVmro=;
        b=khzKOVWHPhj6xstao9Bh/G37Rm5VyRqzUn93PpawsLRoRAaz79+5cTZVoV2Z5U94vE
         kfJ8AjubTfLcBrymc4lsHp2dYmvIeoZuLdtmnhi+ESpjFbwdV1ZuwbQFdaBTVHmFCyPq
         23ZG5kL887iruYy2zFnRp1x149BAowuJaZCtBfSyB0DR98hFtGIf2byOs3+LxOE7NaS2
         c1YIR20IK2S4N0C690V6I50poB/62VqddG4A3iLGQ42/zQtax/OPP+zhLZVfh7CYPDc7
         VAL8fKw5nuupIPPI9MTiIhRDUpJTWg375o6RGuVZwJ99Cae1v1aE1yHJMSAiE8IqWQUg
         Jwqw==
X-Gm-Message-State: AOAM5327UbxBQflPYE5Gnb2RkpHA4UcFGT31EYBGAGwF9BQ5OtPZ1irH
        rlnLwPWqUtzPNKU1CFsuhBNqQEkgd9o=
X-Google-Smtp-Source: ABdhPJyY17wt2L23v5ox7iYCDQIIRUJ3jI7hGfRDf1VkuPj/83v4GO/ajw2Pa6akByn7yny+/+QB3Q==
X-Received: by 2002:a62:2901:0:b029:28e:ef3d:10d2 with SMTP id p1-20020a6229010000b029028eef3d10d2mr1865168pfp.45.1623189365520;
        Tue, 08 Jun 2021 14:56:05 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:6c1b:b1ca:5501:207d? ([2001:df0:0:200c:6c1b:b1ca:5501:207d])
        by smtp.gmail.com with ESMTPSA id m129sm11488816pfb.7.2021.06.08.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:56:05 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>, ALeX Kazik <alex@kazik.de>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
 <b2943f57-396c-cfd7-7064-4a1351585fa3@gmail.com>
 <CAMuHMdXDXSh2VkpFyFDXpPFDS+f2JGhU-x1gn2dTCSub=9gw8w@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <617eb8d2-7cd3-e6c5-7c9c-bb32ef35fb2c@gmail.com>
Date:   Wed, 9 Jun 2021 09:56:00 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXDXSh2VkpFyFDXpPFDS+f2JGhU-x1gn2dTCSub=9gw8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On 8/06/21 6:42 pm, Geert Uytterhoeven wrote:
> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
>>> This fails to compile due to a missing closing parenthesis.
>> Sorry - looks like brown paper bag time today. (I did say 'entirely
>> untested'? Didn't expect such a thorough review for a first RFC patch ...)
> Sorry, I missed that part in the cover letter ;-)

I'll put it more prominently next time.

Ran all patches through checkpatch now, and I still get warnings and 
even a few errors ('trailing statements should be on the next line'). 
All due to my keeping to the code style used in io_mm.h, as far as I 
could see.

What's your preference - additions in new style, or keep the old style?

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
