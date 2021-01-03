Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642A2C433DB
	for <linux-ide@archiver.kernel.org>; Sun,  3 Jan 2021 18:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3595220782
	for <linux-ide@archiver.kernel.org>; Sun,  3 Jan 2021 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhACSQW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Jan 2021 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbhACSQV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2021 13:16:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98681C061573
        for <linux-ide@vger.kernel.org>; Sun,  3 Jan 2021 10:15:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e2so17309602pgi.5
        for <linux-ide@vger.kernel.org>; Sun, 03 Jan 2021 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=waGowa0FtUQXfzT4adOsmLs9T/6QK5vr6HCcoxT4PQo=;
        b=tVgBEoM7045AKWVnj071upgZvLNTCb8RMz9CMoXFhf3cd2hIsjpcLqEyZ103uuQrL/
         cQBuvsFJnPZPXrCbuX7xyve4n4Dp9OXi2oCejxFYu8tRcBkkQi0D3Kv60rhloghzszLL
         2w7pgFBeKwQVq2SaRt6+GOdUoJHE/gVswXLKFdqTpp1qeXG2x7fTThJVYYh0iObmZDUb
         OsF4uT5jtVG49aJu4Z+fiUvcK94vxKCVdJ1w33cW7QWIG6WvHg2+/cs7zfz10heFD6vY
         +gPFy4x9cF7UeEDxW3uV588Bxd9MEt4cIQnbu7QJQnkSH7ZivScyvGE+d26NmgzsPT8F
         mgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=waGowa0FtUQXfzT4adOsmLs9T/6QK5vr6HCcoxT4PQo=;
        b=tmniFfU9UeEX79ZYzv5qB5h500HzycZKQcBIyEwkds8g0ScDmUmGGp7jZ3Bk/gHoPq
         YRr6kquzNcMqPOnjZxXJlzl7zN0b2lFeTbb4eV2G9Z3rVbEgY01FhelwGVvvuc1vvE9X
         w+Za8cpqSZ6oKjz5vQWrZnjg+yRG9nKI5sjf6FcpqAHAAPVlL6QySeYUTWgxBlryF5Jx
         7yuFcpB6N9XnrL9KXKIe1qu+hzBRICcUQSRavYT1i4CjgrJFqFexvlcPuc6baYKwVMI0
         AKWaHz/5RVL249Jyh+KywrMbT6PPrrxQ8DxPVwhN8pxANX0qTrOjWPXfqMMyX20r4C1q
         OTWQ==
X-Gm-Message-State: AOAM533VvtKn0rKK5NDiHpfQ14RLVDVZgu2/o+xi0iRY7LBCkXzbgOLP
        Gnp86CO072qB1u8NhlL3dk+MAA==
X-Google-Smtp-Source: ABdhPJyKM0mUtKxSmTJiYR8vTOfM23/ZX6k1LtMsY/K64o6H/xEW1HWWHyeWnqis5IZ2VIp5DEWgFA==
X-Received: by 2002:a63:7503:: with SMTP id q3mr11823621pgc.318.1609697740789;
        Sun, 03 Jan 2021 10:15:40 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id cl23sm18307308pjb.23.2021.01.03.10.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 10:15:40 -0800 (PST)
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
Date:   Sun, 3 Jan 2021 11:15:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/2/21 4:29 PM, Finn Thain wrote:
> Hi All,
> 
> This patch was sent in September and subsequently resent in November. I've 
> since learned that the maintainer has been ill. What's the best way 
> forward for fixes like this?

I can queue it up.

-- 
Jens Axboe

