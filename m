Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB3C27C40
	for <linux-ide@archiver.kernel.org>; Thu, 24 Aug 2023 01:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjHXB5u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbjHXB5h (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 21:57:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA18CED;
        Wed, 23 Aug 2023 18:57:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso2950491b3a.1;
        Wed, 23 Aug 2023 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842255; x=1693447055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvfFTYbFDsOZIdoUyEZdGL+Re1FyOZrSFvSKCnfC+Tw=;
        b=ONX2whnqaiQoXmR8q4qOs2rBqJ5GWYRT4g8OAaARBUjjjlLc9nMzEMwJDdGNQ3lmgL
         4do70SX8yiMvkQlq2s80/UIy6oGcxZGDCRI52OHdr7spv3lVbyx72oQjh16gmAKH8Mco
         YKY96JNRHOmgx4TEw6rJ5d6a1Qbark8QDY8ezsfKRvQMY7yjgFFXLoyP30gs78/YtRB0
         Yo9zlH0ZLpKWqyKPIiRR6VDF3pY8ua7VP0vO6hcJLi/hc82t/nQEVbZEv1t0v4X4hRj4
         k5bXhH/lbKJ3RRbW1a3hm/LGua4t3NwCHzSkqx4yXSdrFQtjQnLznHdTyzZS7FagRZvQ
         gZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842255; x=1693447055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvfFTYbFDsOZIdoUyEZdGL+Re1FyOZrSFvSKCnfC+Tw=;
        b=azrmeX1ULKol495jNRk3qbi1EOvilKcXrnIzVmWNafx0ljNgv8kfJ8aOLHL3dZ3B6D
         QMVxSHDoNwQvvOXb1i0VuRgHluZlGddEyiD1XoeNAyfFjUfUdw+0oSRjNy4sBIbi92n4
         ff2aKdxK3nB2Ixa3yll0uN0veNbJiYQnGigDm9c8mtBnhoJHYyUE9tGe2GGt90WKk38+
         gBh3dUJxZpTDxMnOHRMnqPkADhdR7YRmCH8rgHwuJcB3LAqMZQKKJ+s62GrWPDsfhnFV
         ljSxMipR8co5TqCsybltLMdNMuZtyft40hbIqyfCE/MCJ4h4MlMvEv2S9NvY6GU+EC22
         5iLg==
X-Gm-Message-State: AOJu0YxijRXIju/+jpdG7U63Mm9kd1W/LmCypFaPKQoC0LOz4fsNKFIu
        W+FmuVcHxmPobSL3xdCX7Vg=
X-Google-Smtp-Source: AGHT+IGhyIWTpU4r/hvMH+zRfGr343OhiN/iLUmR4ApCef1+dRn3RAE4dQh8ElTBUPIYxhJ9AaT3Kw==
X-Received: by 2002:a05:6a21:6d86:b0:14b:8b51:44b0 with SMTP id wl6-20020a056a216d8600b0014b8b5144b0mr3932689pzb.37.1692842255280;
        Wed, 23 Aug 2023 18:57:35 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:34d2:df92:ba7c:a2e2? ([2001:df0:0:200c:34d2:df92:ba7c:a2e2])
        by smtp.gmail.com with ESMTPSA id q18-20020a639812000000b00564be149a15sm10181559pgd.65.2023.08.23.18.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 18:57:34 -0700 (PDT)
Message-ID: <f2380d51-ff67-0a83-2249-3b942d89846a@gmail.com>
Date:   Thu, 24 Aug 2023 13:57:28 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to
 byte-swap disk data
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
 <20230822221359.31024-3-schmitzmic@gmail.com>
 <CAMuHMdWaDzG_FJPnc_YEBB7RYrNcwfceeN4QgB-3Z_7PFqCGUw@mail.gmail.com>
 <CAMuHMdWNfCHLx-nLy3C_afH2KpAMn18KdW=UjS+g5Rq16CWFiw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdWNfCHLx-nLy3C_afH2KpAMn18KdW=UjS+g5Rq16CWFiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On 23/08/23 21:10, Geert Uytterhoeven wrote:
> On Wed, Aug 23, 2023 at 11:10 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Aug 23, 2023 at 12:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
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
>>>
>>> ---
>>>
>>> Changes since v2:
>>>
>>> Geert Uytterhoeven:
>>> - only shift swap bitmask if pdev->id > 0
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Oops, I meant
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> But it never hurts to have more review tags ;-)

Thanks - I can pretty much type that one blind ...

Cheers,

     Michael

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
