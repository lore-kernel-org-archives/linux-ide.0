Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B66C4743F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C76124B
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhFHV6w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:58:52 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36444 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhFHV6q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 17:58:46 -0400
Received: by mail-pf1-f178.google.com with SMTP id c12so16815084pfl.3;
        Tue, 08 Jun 2021 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mr9J0RXtCDZq3pRoOBycR1dqunNt6hX8FuEJsnSVmro=;
        b=PfcI5crnVHRvKskKI62kLlNbY5tuW2XSc4BghK6NoINfwvY0FYxntuYmAJ58eHKZEg
         6d5z9fNv/fTV2T4Zo77XriGM+w6wVEMwbkSXwXuro9AJMIGRHYm2HB/Dspv3519/m3oM
         IZKXzyvS+A4QqAaO564E/jMLCRtGRLCLNUZ1DlA4kAr+yVYAJdLdjbwXIijft5W7w2AY
         1OeIZm0iuvurQAVX56IdaVGuyoCNRWlpY7KzKeUlqDwK17jCg2SCtlS15M28zcgWL2YP
         Lf1H5DmFk2yjgV4SFFqpKEmjC80QQptTjZZy89nbtXgaB3Zk8DKq1GKxTsQO49wqrmHI
         7aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mr9J0RXtCDZq3pRoOBycR1dqunNt6hX8FuEJsnSVmro=;
        b=BuAwwjEJoqV1Qu+2n+f3hBj4Vy+ZNew2BSUtYwyGznOR/GR3gQ6MgXO3FEcLTsF/p6
         izZRYYXkMdSRk+6IfU9nloEb4P2R0NSiI3g/UuHFhDl/waYLGS//g/HAkPLqiuhpchj5
         3E3oha1t9mBg8StlkFxXb0SN3pk/FUEPzIOZj91BkQ1ZBsmYBkm5PVOf9Bq6NtPNsEnB
         LTHlSgfbZTvApO2mrYunxcOhPBOR9FOChu8wqXFeeYVFHHNV87N+DLD5v1WCxKIMQ+RI
         GhKTksSmrTBp9pNcQmUrbgIxzQqut3VsD4hkUWOp7WmNUWxvt1XKdoutikA4o8OozTpR
         lOew==
X-Gm-Message-State: AOAM5327ijC8dgUvhEd2gwrCSU2qswlYDz0Z+rotmXbGC+4RT6Xoaskh
        rmHLj+NjNhSSYqqhU2g0oPGzyeBjX2U=
X-Google-Smtp-Source: ABdhPJw0NTcVeabyAHs0/a0kTX+yGxw/o/pZb1WKvzQSYvmAZhf+G/ry7k2lD8mzZOEyHSucD28YLQ==
X-Received: by 2002:a63:1004:: with SMTP id f4mr329361pgl.115.1623189352821;
        Tue, 08 Jun 2021 14:55:52 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:6c1b:b1ca:5501:207d? ([2001:df0:0:200c:6c1b:b1ca:5501:207d])
        by smtp.gmail.com with ESMTPSA id s15sm15794228pjr.18.2021.06.08.14.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:55:52 -0700 (PDT)
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
Message-ID: <602d8eed-dcad-33db-3b64-d099c2f33503@gmail.com>
Date:   Wed, 9 Jun 2021 09:55:47 +1200
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
