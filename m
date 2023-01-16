Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8985C54EBE
	for <linux-ide@archiver.kernel.org>; Mon, 16 Jan 2023 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjAPSWo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjAPSWY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2023 13:22:24 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DE3A589
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2023 10:09:18 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n85so6230693iod.7
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2023 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=hC8rifHiuHXCPgttcmOOf/xO+1ZeeDOeIZfW9Ym8Ory+CkzNJPkrfO/C3JXy2EE1LL
         2kTaAysayLbTpr+7RDLLrKq0FCECx/EKRPZa3mKY+K67nyLJZ8f7PA4gCRWG73mV4Yn4
         5cdNgXBpvhk8M9iRXw8+R8fW3tOu/c3Ashp10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=2w4J/7KROfTq/+I6sztmYn2A1LU9uArTACErwj2mUtx+7HdlD9HY9Q/JnJt18ayIJn
         bZrv1lfQ0WcJcMlLxO6XGndvC/pIrJYzElyhpWDRFKi9OBH1lGlL/EHBS4HCFLHDBEL5
         dkQbeBVkWhrTxtmfWYFajZ+INIQK3Hz4QDd9kMty8gWQfXMaF3rseWxVghV2Je0LtZLH
         7AYaF/0vPP3i3+eQrQ97CLzeNDabaJBIrJAOQlG7Dz4jufGXuN0U8iNSiNJmV1Ct0cgF
         yKSh7DeQHf5hJjpS9PFtNzRm/3B3YCG6WkbbSxgvkP7YydGMfTp9izM5kJwXntX4FfnS
         vhuQ==
X-Gm-Message-State: AFqh2konS8onKUlGxxoeTWaqvr9Dev0X98iBM+q9Y63ax/aEaWLnmm//
        5cvsrBQfrNhQEcOeDrvRlAcWuGebGV3hd+A8
X-Google-Smtp-Source: AMrXdXuYubHFthpkG5kZen7j6YsTlbZnqRkQhoMc9XYNM/2m/wt3CqRc0EbsXSBs2LpI7MnuFiMVUw==
X-Received: by 2002:a05:6602:72d:b0:6e3:1ced:b60e with SMTP id g13-20020a056602072d00b006e31cedb60emr35227iox.9.1673892557235;
        Mon, 16 Jan 2023 10:09:17 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id n5-20020a02a185000000b003a0a7a22572sm2586806jah.175.2023.01.16.10.09.17
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:09:17 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id q130so908372iod.4
        for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2023 10:09:17 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr364175qtb.452.1673892068650; Mon, 16
 Jan 2023 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:00:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

[ Back from travel, so trying to make sense of this series.. ]

On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.

Ugh. I hate how this adds random patterns like

        if (timeout == MAX_SCHEDULE_TIMEOUT)
                sdt_might_sleep_strong(NULL);
        else
                sdt_might_sleep_strong_timeout(NULL);
   ...
        sdt_might_sleep_finish();

to various places, it seems so very odd and unmaintainable.

I also recall this giving a fair amount of false positives, are they all fixed?

Anyway, I'd really like the lockdep people to comment and be involved.
We did have a fairly recent case of "lockdep doesn't track page lock
dependencies because it fundamentally cannot" issue, so DEPT might fix
those kinds of missing dependency analysis. See

    https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

for some context to that one, but at teh same time I would *really*
want the lockdep people more involved and acking this work.

Maybe I missed the email where you reported on things DEPT has found
(and on the lack of false positives)?

               Linus
