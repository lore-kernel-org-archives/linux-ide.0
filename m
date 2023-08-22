Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CECEE49AF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Aug 2023 19:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHVToO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHVToO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 15:44:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A6CCB;
        Tue, 22 Aug 2023 12:44:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so7607178e87.3;
        Tue, 22 Aug 2023 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733450; x=1693338250;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+t2Hk6v0/1BUGXeoEkKhh3ob6fE9p1qH2h8fLbl4gw=;
        b=WdLophBSzzIMZjRKu3kc9VEVT1r9GDsagR+UTXFtmM/u5Vkfo0OzcRyE/X6C3Q/Y42
         TR8AlsSada5lfSY4IQp05QZFcVbCEHAtHZwRnS/wmPNqK7dsey0cxvQ2GyBb0PlrFO5Q
         4kWsZvDgt+z/ji9rhqsSEyvE17AFFIgMW1LdjMdq6dWf9Q59RDopHM/dvMbNJYesSmJY
         KM4Fqbia0DWQi0cH3VtY8h0uhAJoWFI3Pk67v3P5biFjuNp4QT04dpJyyy56HGvjEUIZ
         TWvxSpuK0Dtl1U2mSMUxvjeSttRRkE12QsI22+CBK4LUjAzH4gaB2ozZ+8f0VrmHm74C
         oWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733450; x=1693338250;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+t2Hk6v0/1BUGXeoEkKhh3ob6fE9p1qH2h8fLbl4gw=;
        b=dqlorUplfeAPn0+U8d9xd34OBCgjq5gGaxzpVQasjb/oAhxt5nSngD1hOu5uj7hza2
         pr4/zdpFzjjnwUnHDUrJw3a6eVD3LfgelaY6SG3++OCf369VIlnKJ8XG5C3kIrYCeGLp
         tnLxw+Gb+9H0pd+cpy316pkKgSIBW0dULTr1vHs0rCu9ossaMRpsuLcFBP0V8/f5c6LJ
         dOvJt9inGyGMHCyPjPuYW8oDcufVEFV3KZfknhCNtbqSmrIn9D7pSBrou25qwYisTHcq
         U8bgco6rSFewH6vx79IATEgC2rpRQc2gVSguiAMQlyECK8lFy79HQyrOI/Bt5BSs5ubm
         J63A==
X-Gm-Message-State: AOJu0YzD0YxkN4BCV9uuehaj13u+TeYttW+3WegQJFbYCGMd8T2gfNc3
        k1Esr3FjO4EiAcgQrojAPQw=
X-Google-Smtp-Source: AGHT+IFhiib4KEtipJPRFgXXju0GOHkIEjWVkVvj9UcnrU09yXZyEtHjq0KQO7H++3q6Zq4enFe65A==
X-Received: by 2002:a05:6512:3d11:b0:4ff:a25b:bca0 with SMTP id d17-20020a0565123d1100b004ffa25bbca0mr9292816lfv.40.1692733450382;
        Tue, 22 Aug 2023 12:44:10 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.28])
        by smtp.gmail.com with ESMTPSA id j3-20020ac24543000000b004fe8593b67fsm2341790lfm.107.2023.08.22.12.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:44:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to
 byte-swap disk data
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
 <20230817221232.22035-3-schmitzmic@gmail.com>
 <3af82526-1b8f-87bd-b936-9171e4d821df@omp.ru>
 <5e5217a4-837c-fac8-246c-15f8a2d46bfe@gmail.com>
 <7463b0e7-cc9c-c091-ab47-14d19a0daf07@gmail.com>
Message-ID: <7dfabbb3-1bda-103d-d357-a6f167dab9b9@gmail.com>
Date:   Tue, 22 Aug 2023 22:44:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7463b0e7-cc9c-c091-ab47-14d19a0daf07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/22/23 10:10 PM, Sergei Shtylyov wrote:
[...]

>> thanks for reviewing - this has mostly been addressed in v2 or v3 (which I forgot to send to you, sorry). Damien asked for the patch title to be changed (now 'ata: pata_falcon: add data_swab option to byte-swap disk data) so you might have missed it on the list.
> 
>    I didn't want to repeat such request after him. :-)
>    I'm subscribed to linux-ide thru my Gmail account, and I'm still not seeing
> your further patch versions on the list... :-/

   Had to reply from Gmail account as the OMP server rejected my msg.
Please be sure to always CC: me on the PATA patches!

> [...]
> 
>>>> Some users of pata_falcon on Q40 have IDE disks in default
>>>> IDE little endian byte order, whereas legacy disks use
>>>> host-native big-endian byte order as on the Atari Falcon.
>>>>
>>>> Add module parameter 'data_swab' to allow connecting drives
>>>> with non-native data byte order. Drives selected by the
>>>> data_swap bit mask will have their user data byte-swapped to
>>>> host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
>>>> all user data on drive B, leaving data on drive A in native
>>>> byte order. On Q40, drives on a second IDE interface may be
>>>> added to the bit mask as bits 2 and 3.
>>>>
>>>> Default setting is no byte swapping, i.e. compatibility with
>>>> the native Falcon or Q40 operating system disk format.
>>>>
>>>> Cc: William R Sowerbutts <will@sowerbutts.com>
>>>> Cc: Finn Thain <fthain@linux-m68k.org>
>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

[...]

MBR, Sergey
