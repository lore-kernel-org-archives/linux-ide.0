Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DCAC433E0
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 23:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42CE64E68
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 23:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhB1Xjm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 28 Feb 2021 18:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhB1Xjl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2021 18:39:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C1C06174A
        for <linux-ide@vger.kernel.org>; Sun, 28 Feb 2021 15:39:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s23so10505393pji.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Feb 2021 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1uTxHZvnykz36Aw0bL/yt/Yp4aJN2LGfaSItobB/8A=;
        b=bE3kl+AyYosxWjfo5BFJ5eejTrdJwYTe6QVO/Zt6rBWRIububXeGwXdCmd7M/3x12n
         E0vDdBKNvAwyv20Xj5AgZPBdrDM/j95M9g6UUpnmZVGPkSxKPkMzTeAu3EW7Mnzat1ip
         soVimXtjXkLB2FXbrQdbZjQiMK01pxGTI+GKVTg4b0kZitXMlDs9M6nRZfZTiRiYMzmj
         xWe56GsTdPjBN0mmMidGKxZ+32sJqil7R2m6w5bPbUUvRpz+Skcas0Csc47n0EJ8ItvG
         9ppb0NPYMeX67x9i9eTVh4TUsrwoy2a9PVB1z5ZdO1paVXPU4xYe3I3+0NQJ3WNMYJqe
         IGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1uTxHZvnykz36Aw0bL/yt/Yp4aJN2LGfaSItobB/8A=;
        b=ACxJBo+tgvcq9GVREBaIwJrUDGpcAXHJSRzTfs8VNkpGCa1fhRTAHAns4DE4D8K874
         Qo5F6Nh5uPj96gO46ocHttDMOhbN/1btLsYGXDy9CQZbtnXtxgdbwa7suWI3PvJu6hHo
         yqth6/RKVUQ0R78eX5b1cKEo4xxNEgWLHDKzkPRxnWQAKKWpu9wRjaq0NaDibnRtE46l
         R38Spb0xVXqfRzExOshU8QkcxmrR53gKKvwRDuZbs/YfPMeHiUIIlYG5DQh/fFzF9izi
         PCvJUe1MmxbEcHUqXX5ObVEXxFhBKAMCT7ioKlqUwerkik9L3gsL+C6hnFMDZf784CVa
         axxA==
X-Gm-Message-State: AOAM5322hpfucIukNhUUtv/U0Rn1weCrJHrn1JW5g/sn7fV8IalTbyy2
        wRdU9b6C1R54vaLmpmH0Yu8ZnA==
X-Google-Smtp-Source: ABdhPJxbBWj3EcABpsuTtXDvujkPgINeUUJDaXCPH265T/laVmNhH9btA76hOXdWhe8yLPW/Y80STw==
X-Received: by 2002:a17:90a:9f48:: with SMTP id q8mr10176160pjv.53.1614555541120;
        Sun, 28 Feb 2021 15:39:01 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d11sm2563752pjz.47.2021.02.28.15.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 15:39:00 -0800 (PST)
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet>
 <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
 <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec29f009-ba3a-29bb-196d-a8893ed880a0@kernel.dk>
Date:   Sun, 28 Feb 2021 16:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/27/21 5:19 PM, Finn Thain wrote:
> On Sun, 3 Jan 2021, Jens Axboe wrote:
> 
>>>
>>> This patch was sent in September and subsequently resent in November. 
>>> I've since learned that the maintainer has been ill. What's the best 
>>> way forward for fixes like this?
>>
>> I can queue it up.
>>
> 
> That would be great.

I did, and then I forgot to push it out... I'll do that tomorrow.

-- 
Jens Axboe

