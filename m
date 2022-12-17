Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A03C10F1B
	for <linux-ide@archiver.kernel.org>; Sat, 17 Dec 2022 02:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLQCcS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Dec 2022 21:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLQCcQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2022 21:32:16 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69C680A5
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 18:32:15 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id bw27so2108274qtb.3
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32+z01bS/60qA2mmoByJGqJAOHtZb/bEvDiYOeG8ufE=;
        b=DTaBFry/QZoeuOH8bgOfjwLNEpYNqZzab+fCnqwy3J3+8q3/x84mM3bHSdja/1gN4I
         uaaXOIhD6RKnw9HSGLSwuVQ/veQVCcZtqIZCRyFURXAgPJy3BGnn7PAtcYRYeeLZn9Gt
         87gspRP1SiWekpT2XiWME2QkbC+z5x/IkkbAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32+z01bS/60qA2mmoByJGqJAOHtZb/bEvDiYOeG8ufE=;
        b=jl7IBYDBIE15u8Y5QDEMXX6dNALcwRkwTbSD11V3zKcZY1Y1dzqC6BMPo2PwICZoco
         zbTa9uzrDT7bmifvgAWxY6CWaMXHPvU9asxsoL/a4jaRe5SbWhWGAvi7ii7P5EnoYhys
         5wld3FDM+VfOBFJKqjwBKbSbEhoM14tDSpyJh1gIP1Lzt2MCCGz9og79sZFtnw46Ciy+
         wyGcHsuf7kQZTKI1sz5zwEHIvBICH705rcD5td6jpkT8tDD8Djo6fEUhhgsPwvvEJyek
         VIAWRq0h3cW8TXCQL5+K4VOmyRCHKM3/WNALEc5p81h7RTXMg59eyLf2XqeuZ3ZMqkxx
         /60w==
X-Gm-Message-State: AFqh2kpc5qXWEirepWe/E53MVK6XivAbzYyDqViVVU/jYXcDqVltzAVQ
        dMpPBl5r6e0kJbZSLGvJzHK5olJ7t12RWiix
X-Google-Smtp-Source: AMrXdXsDkB9EDdBZL3QmXWhZnjX+p97iWGzOGlqTFBQp4yj2eOuKlLegWeKLnewOhEpi1H9fQCRu9A==
X-Received: by 2002:ac8:7149:0:b0:3a6:a35f:caa with SMTP id h9-20020ac87149000000b003a6a35f0caamr2645100qtp.18.1671244334427;
        Fri, 16 Dec 2022 18:32:14 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id fu25-20020a05622a5d9900b003a57eb7f212sm2307973qtb.10.2022.12.16.18.32.11
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 18:32:12 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id pa22so1682546qkn.9
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 18:32:11 -0800 (PST)
X-Received: by 2002:a05:620a:678:b0:6ff:cbda:a128 with SMTP id
 a24-20020a05620a067800b006ffcbdaa128mr524218qkh.697.1671244330735; Fri, 16
 Dec 2022 18:32:10 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com> <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com> <Y5vo00v2F4zVKeug@ZenIV>
 <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
 <Y50BqT3nSF7+JEzt@ZenIV> <Y50FIckzrV9sWlid@boqun-archlinux>
In-Reply-To: <Y50FIckzrV9sWlid@boqun-archlinux>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 20:31:54 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
Message-ID: <CAHk-=wj7FpAXZ0hnPKh-5CG-ZW8BmOhd4tEW+J7ryW26fkcDNA@mail.gmail.com>
Subject: Re: possible deadlock in __ata_sff_interrupt
To:     Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Ok, let's bring in Waiman for the rwlock side.

On Fri, Dec 16, 2022 at 5:54 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Right, for a reader not in_interrupt(), it may be blocked by a random
> waiting writer because of the fairness, even the lock is currently held
> by a reader:
>
>         CPU 1                   CPU 2           CPU 3
>         read_lock(&tasklist_lock); // get the lock
>
>                                                 write_lock_irq(&tasklist_lock); // wait for the lock
>
>                                 read_lock(&tasklist_lock); // cannot get the lock because of the fairness

But this should be ok - because CPU1 can make progress and eventually
release the lock.

So the tasklist_lock use is fine on its own - the reason interrupts
are special is because an interrupt on CPU 1 taking the lock for
reading would deadlock otherwise. As long as it happens on another
CPU, the original CPU should then be able to make progress.

But the problem here seems to be thst *another* lock is also involved
(in this case apparently "host->lock", and now if CPU1 and CPU2 get
these two locks in a different order, you can get an ABBA deadlock.

And apparently our lockdep machinery doesn't catch that issue, so it
doesn't get flagged.

I'm not sure what the lockdep rules for rwlocks are, but maybe lockdep
treats rwlocks as being _always_ unfair, not knowing about that "it's
only unfair when it's in interrupt context".

Maybe we need to always make rwlock unfair? Possibly only for tasklist_lock?

Oh, how I hate tasklist_lock. It's pretty much our one remaining "one
big lock". It's been a pain for a long long time.

            Linus
