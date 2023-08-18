Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2302EE4997
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379999AbjHRUlS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379992AbjHRUlD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 16:41:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434403C3D;
        Fri, 18 Aug 2023 13:41:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc63ef9959so11103305ad.2;
        Fri, 18 Aug 2023 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692391260; x=1692996060;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtLQgfCoYcv6PrflZjykV7XVcEibcIdh82ngkEuSa80=;
        b=UIg8gR7dP+iHI+eiPrf82CgvK/3NRkugCAoC/L8WfqBG8AUL7/5yturDxY+BdSOOfk
         kqrGxXDfBsPQNo0XvqGNkfEZMHGzahYcnqfSbxd6Lgt8fgmxlLKkEF9neem6iRSyzN9b
         NDmhuXdbC+zfzlBog1qLpI023CTeEPwPuDUNP/EW2+qapclGXK3ZIEf8vYU5I11P85h2
         QsBzx6yijGvRCawQkpTg9n1cx7qaZXSco4qYLkkaIJXNq/oTJPZMk5GY5w9SBlR6Oo+3
         WQBthPGBUjuAjW3qmhgce33D9Kc4xf6qhaeRUIuow6jeWdZlIl6VeGDclWAdWGrTnIs1
         MgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692391260; x=1692996060;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gtLQgfCoYcv6PrflZjykV7XVcEibcIdh82ngkEuSa80=;
        b=SOuvJ4XqCMf5qav6zaUte98HeGGxwULnrUWQUtVwVaRjHG21GMsUcJF7eAa294gTj4
         YoAASIMQTqu5qssQWLOMK+VVeLPH0gDI2mFyIOl0Y85I2vyOQs0zYrZ7miHUJlEauXbC
         aSpsPYRyG21GO78nzjNPJ/WaWAAZRYHv6jGMzaMcYsPl/yqpsXyXS9CSn/ijmzCP1T/V
         muWrCPS7GuDvyEyF7wUJGi6vfG0G1F5s53M/9oOxqg2in3cYyQsi0thMkCShaa6EcbfU
         Fttbqs5Up/971kNcRmYl6iKMLD+l8TEqUR51Rc0fKnZ15tz57oCcR2XwZlB50OhipE9l
         uVBQ==
X-Gm-Message-State: AOJu0YzskO926QGDjp+TXivtARgeEkddakKwwFpjXL46GsH2OWhWbK6a
        1QrY0HkxMW+eOVrVt6i2HxA=
X-Google-Smtp-Source: AGHT+IFiVr8slydDH7X749g4Zs7KU4xW4x46gYRKZfl53JLmSLOsds4L7AzpALzEpXCvWKxkuY8GOA==
X-Received: by 2002:a17:903:22cd:b0:1bd:a50a:e2d0 with SMTP id y13-20020a17090322cd00b001bda50ae2d0mr339781plg.66.1692391260504;
        Fri, 18 Aug 2023 13:41:00 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001b0358848b0sm2171208plg.161.2023.08.18.13.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:41:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] m68k/atari: change Falcon IDE platform device to
 id 0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
 <20230818071405.28581-4-schmitzmic@gmail.com>
 <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <41d64e82-5995-4e5c-68f5-3e9248ece153@gmail.com>
Date:   Sat, 19 Aug 2023 08:40:54 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 19.08.2023 um 02:44 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Fri, Aug 18, 2023 at 9:14 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> The pata_falcon data byte swapping patch relies on pdev->id
>> being 0 or 1. Q40 uses these IDs, but Atari used -1. Change
>> pdev->id to 0 for Atari Falcon IDE platform device so
>> selection of drive to byte-swap through pata_falcon.data_swab
>> can be used on Falcon as well.
>> Tested on ARAnyM so far.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Iff this patch is accepted, it must go in before [PATCH v2 2/3], else
> the latter would cause a regression. And backporting to stable must
> take that into account, too.

I don't see it as a regression - the driver still works OK, it's only 
the byte swap option that's broken on Atari, and that's newly introduced.

But this patch changes the user space exposed platform device name, as 
you point out elsewhere. That's reason enough to drop it.

> Alternative, only consider pdev->id if it's positive?

Only shift by two bits if pdev->id is > 0? (some consider 0 positive...)

I'll rewrite that bit and respin.

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
