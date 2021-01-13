Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71908C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jan 2021 14:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F1123382
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jan 2021 14:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbhAMOFw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbhAMOFw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2021 09:05:52 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F8C061575;
        Wed, 13 Jan 2021 06:05:09 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b10so2665403ljp.6;
        Wed, 13 Jan 2021 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+4E+lnq7Lfrarj+nkHQ8tPsDebXBBkHafUd9ovjkRs=;
        b=Jz6tULJla1sHO4zRPH4ORwFlZJSQj9rU13uptXp/ggI4hWWdaSWc7NJoLYimUwLJ9y
         aSGZxjF0GjFKaHrSh0ZbZ0NQQYlHt5okgvJ9hVmMNzNkAWtYYPQNa4lRCV0jl2biewxV
         opd07HiPO2mP3zAU0OSVGuCkruIhhCpINGqMtpl2AN9kvaT2AWK9bqulyn08wGgENTd7
         Jpgf6KaD607xicTwdFmuEAEebLjT5NadgxDwuXeoDTm/59Ogw1wi0uNTBo9oX6GaL7os
         /A/OXKZ98SK/0iGZE9GFpEeY77NYVf8X9UNbgf2aAkGdeJs0fV2ECJQwagKb6EdLkIx2
         13mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+4E+lnq7Lfrarj+nkHQ8tPsDebXBBkHafUd9ovjkRs=;
        b=RW29rl72V5dmhCUgnvkEiyNAN3XONxCGCpXmisRZZXp4A9wy0PfXmGJNKDCdUMN6XA
         99HH0Rv3QHldP+lhR/GuHL9VHUv2omWuFRzFqz/53BBrq+llBg5iCTzq/bJ2L+xiHEkY
         ctbh1f6KXTffHSCSHvWiRHwG8vFT8a0Fgm/cOznB7uDxiplX/7bGSYLeWkLT+sPNhCtb
         QtBEVJ2rz0TE56Nlolo2D6qW2Q/eM+9MDLhLB0L787sC8uckiLY0XntNPmgEKqsSLIzt
         FDOKt8Y18zg174nEDLRkqtg+VteGJQZCccGE3G90LFw+suTN3kiRllMlepYZ3YmHc2Xu
         fihg==
X-Gm-Message-State: AOAM532Gz8N03zUW2kejyA5RBB4wfiyciYuXXf40uhOf+GZTouSM6emf
        U45mMOn/aCEu/OHxQr5Y+aiQQ84YfaiDcDpBZos=
X-Google-Smtp-Source: ABdhPJzu0E6WYwBQ6xp/EipnGmdq62l3BjJ/CnJAZFu3yJ1Ac9Zc0zExKJ8JXTg3y6EISNFKGRO0vgT4anGFN5iwSSM=
X-Received: by 2002:a05:651c:1129:: with SMTP id e9mr977294ljo.135.1610546708226;
 Wed, 13 Jan 2021 06:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20210112023619.5713-1-dong.menglong@zte.com.cn> <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
In-Reply-To: <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed, 13 Jan 2021 22:04:57 +0800
Message-ID: <CADxym3bzFPeCXzkO1iFy+Sx7GhwRGo=VkOUzrDE4KMCjMx0v-w@mail.gmail.com>
Subject: Re: [PATCH] ata: remove redundant error print in rb532_pata_driver_probe
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello, Sergei

On Tue, Jan 12, 2021 at 7:15 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> Hello!
>
> On 1/12/21 5:36 AM, menglong8.dong@gmail.com wrote:
>
[....]
> >       irq = platform_get_irq(pdev, 0);
> > -     if (irq <= 0) {
> > -             dev_err(&pdev->dev, "no IRQ resource found\n");
> > +     if (irq <= 0)
> >               return -ENOENT;
>
>    This still beaks the probe deferral. :-(
>    But that's another problem...
>
> [...]
>
> MBR, Sergei

What does this 'MBR' mean? I am a novice~~~
So, is it better to replace 'platform_get_irq' with
'platform_get_irq_optional' here?

--
 Best Regards
 Menglong Dong
