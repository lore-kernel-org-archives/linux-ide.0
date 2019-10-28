Return-Path: <SRS0=dmdd=YV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA5BCA9EA0
	for <linux-ide@archiver.kernel.org>; Mon, 28 Oct 2019 07:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A7820679
	for <linux-ide@archiver.kernel.org>; Mon, 28 Oct 2019 07:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhyE5/6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfJ1HDw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:03:52 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43091 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbfJ1HDw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Oct 2019 03:03:52 -0400
Received: by mail-pg1-f180.google.com with SMTP id l24so6245746pgh.10;
        Mon, 28 Oct 2019 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jERAWE+x1BLl4MJgyCXD41+1uwdaxk3zhMq+FdsMEoo=;
        b=uhyE5/6kk9SqnBowemsq4djl7IltU9qAtQXsCbxUn74nB5h4edCkmdNMcSiaWjg1va
         K7yGmPpTAtnatESunXXNga01Y/05cGPtd76FiWKRyggBWQwVn4CfffQyr9J9NgtzkujN
         dl6Y7TQ9CNbnROZBdh4Ysoc76lYlPpRXsAJHZZwUq+b8W65kI+F5Cld19/BF3hrzBiyb
         klGltOaiYLxYobbJk9S03ZWAtPCaT9Qq9qXRTa3sJnFOIekR7OMR7odTQrccFPt05X0k
         vyxGS8rayOy9HMZE9JF0wdvqw3wd68O8AkcQI4cFEJXPOmQQjMoBSquL1WDtnKo0BDNl
         l0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jERAWE+x1BLl4MJgyCXD41+1uwdaxk3zhMq+FdsMEoo=;
        b=mFKRsG0/W/GZ6rJSn1OkgKi8aic0qi6VZ22swFqEO43TqI5+Nulr/TxjdtpA3b/uAE
         cGSVn4cdDJAYA38yIFpOJWAJ/6EOgky7fsZ7b34Tl0K8cz6j3U4I4vGlpiyhWCquFgXl
         D71cvxb2X6w7x+I3EZUoaNXbDwqo0U9crBerY12Aj/hNsKZw5s9TwM1NNw+ZH1ied9bf
         urcLGDQ1N3vNxRbKM29Vzd+aywk6kKLJT9M9HW/BX6BDyDBprar0H/NbkC451B+K9fer
         GHdNxJnHiV79sl9rHupAtohC/XGn7nxR537mF3KA3JreK7gcLYWog5Jfton8h9BmrfEO
         VxAg==
X-Gm-Message-State: APjAAAUYq7MFaTH91qZj2El7GaqH8m28HGtTJOk8pSgs4Mw+JnB3n8LF
        XVOCq2wVmKdecgX5bpngGNo=
X-Google-Smtp-Source: APXvYqz0uc5lgj/j+WvNQTmWEyMcxhFioHMxCOjS99LUnqTWr5n7aResCKHxNPGvMpQHKT/4rQD9cA==
X-Received: by 2002:a17:90a:9f94:: with SMTP id o20mr20764126pjp.76.1572246231207;
        Mon, 28 Oct 2019 00:03:51 -0700 (PDT)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id u68sm10147307pfu.39.2019.10.28.00.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 00:03:50 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
 <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
Date:   Mon, 28 Oct 2019 20:03:46 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 27.10.2019 um 07:17 schrieb Geert Uytterhoeven:
>>
>> Who's going to pick this one up? I can do it, but it'd be nice to have
>> m68k on patch 1 first.
>
> Sorry for the late reply.  I'll have a closer look after ELC-E, and will apply
> to the m68k tree if it passes.
>
> BTW, I believe v1 of both patches has been acked by Bartlomiej?

Correct - on July 3rd. I totally forgot about that, and didn't add his 
Acked-by in v2, sorry.

Message-IDs are <89366005-c1f1-4a0c-9917-720bb9e9e100@samsung.com> and
<69dd2d85-c9f2-23b9-b45c-34147e4dab86@samsung.com> FWIW.

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
