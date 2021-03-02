Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481DDC433DB
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C4A64E90
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 02:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhCCC2j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379957AbhCBKWF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2021 05:22:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E0C06178C;
        Tue,  2 Mar 2021 02:20:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s16so11752617plr.9;
        Tue, 02 Mar 2021 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d11v9IAqVbtRrrz4bJn+a0ncXxedyZNk4F00Rwt6DFw=;
        b=UXRCu+os0fc4GJYjB0rPkfKJfzT3HB6VKvcp+L6pJbf5n0mJAW7MNFHoEWgsj3RIy+
         qah0cPjcFyFDVstfGMNoOi+TXq/W52zGc8jVTx3cA1tnK92DTiG9hq4hTX+KL2FDjhXE
         tZA/p0tg3hZZvnwN5ptN//msrcLBo7mH4PmqtJRmRjsAxwaAZRVepyfRVaPrlsOxsPC9
         5PDoNlTIwZlGlWH1YXVukOmxHkpNrqsQ0V/XZk7TcSwwG6IMMhHncSDo+BwZWlXbtec5
         PwUmq/Pq5H5M3KO1cRbreyg5/j5hJgykepwelLcFUJMxJgLnrX0D+9UG6DqTkmjC7Fo/
         4eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d11v9IAqVbtRrrz4bJn+a0ncXxedyZNk4F00Rwt6DFw=;
        b=RwpLJckudagG6nyPHp6U/TwxFKt40dvL2UjbfRubSmvSltN+NVOtfE7FjjOTVrj16K
         muqFk3BmcIB/xd9aUjNc4JNtMcQtkjn5o40nYgWAcB2UQwQ9bEyNQ65eO9zdU72HhUZ8
         5wuut6eqaZB0ObXlnpX9gobI0ijSPXoQ3M/vGjcluWPtCVySIeqih4i7jsBmaUjOnX0K
         5mFGv17rKpuvxLa2TOTjHSpgeaYfFJiUYHwO4sNWzv+jSqwASzXfEuPLbRr/jStvt/Vh
         Xiri1mTb1RnOVdTsszLENp604qdz3PGp5gQvJH9dl3IgiwF1zMB8wE/2H92FPmuYThQR
         vYdw==
X-Gm-Message-State: AOAM530kFxXtyaLwyYjAv75qcDD1q7JvWqqU69bmqHQP01JbPp7Mo2tX
        uscw61R5gFoT8o6vddnv8yXDLhIptIklIHodFdYaCK8OMtVPdA==
X-Google-Smtp-Source: ABdhPJzx0RIk9mIvqlpQYKrINVEPciiP5+tibyqxibsLaORkcZ0fGoB1ReSu1J7FcRe6nYxrNdTDZXz93X4TQS5wr+E=
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr3832574pjh.129.1614680446053;
 Tue, 02 Mar 2021 02:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20210301072842.7410-1-dinghao.liu@zju.edu.cn> <CAHp75Vf86_Ccs7wqzbpWbLDZSSJLbMwZ1TX3dwru9JvXUTMR_Q@mail.gmail.com>
 <44c09a14.a0cbd.177ed8446ea.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75VdT04AVzW=C=SubHjUE5_MHBeC0ptHTFSLgKzrSP3HmRQ@mail.gmail.com> <56ec2ffd.a3db1.177f1db3d26.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <56ec2ffd.a3db1.177f1db3d26.Coremail.dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Mar 2021 12:20:29 +0200
Message-ID: <CAHp75VctFSqxpSfCP=XDSd_QsqX6kpEN+VtKQQU7Xp_wpN52gw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] sata_dwc_460ex: Fix missing check in sata_dwc_isr
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Mar 2, 2021 at 9:34 AM <dinghao.liu@zju.edu.cn> wrote:
> > On Mon, Mar 1, 2021 at 1:20 PM <dinghao.liu@zju.edu.cn> wrote:
> > > > On Mon, Mar 1, 2021 at 9:44 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

...

> > > This issue is reported by my static analysis tool, so I don't have the
> > > vulnerable input currently.
> >
> > Should we blindly follow everything that some (non-ideal) tool
> > reports? I don't think so.
> > For all my experiments with that hardware, I haven't heard about the
> > issue with NULL pointers. Useless checks make code harder to read and
> > CPU to waste cycles. It might be maintainers of this driver consider
> > otherwise, so not my call.
> >
>
> Thanks for your advice. I also checked all use of ata_qc_from_tag() in the
> whole kernel and found all of them had return value checks except for the
> calls in sata_dwc_isr(), which is odd.

Thanks for this information, it makes sense to me. Perhaps you need to
put this into the commit message to justify the need of the change.

> There is no issue currently does not
> mean it will never happen in the future. So I suggest the maintainer of function
> sata_dwc_isr() to fix this issue.



-- 
With Best Regards,
Andy Shevchenko
