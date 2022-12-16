Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B04FC001B2
	for <linux-ide@archiver.kernel.org>; Fri, 16 Dec 2022 11:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLPL0m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Dec 2022 06:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLPL0k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2022 06:26:40 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B31A39A
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 03:26:40 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s9so2401990qtx.6
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7C4DlTIJe/XAzDTApvBRiD8XTjnKR9AH5A3VoUGLOg=;
        b=NwQY0lOyux8zQdS9zMAo0gTIVBQw4Tpq5Bt9XfwxOWeeZoExJwK4JnJSNs6XbHTM+i
         Lv5bhR0Bu8KLvRSNai/hEYLSdT1W9Ro3qa4We7yN3/PP2J3AnHLZ4Lfu7LFF67Lx8MY2
         w+h/UW7V9V8UrlOYYhT/brFKFpP4g/HD7/LKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7C4DlTIJe/XAzDTApvBRiD8XTjnKR9AH5A3VoUGLOg=;
        b=ankpUDSB2T26ycHR6n8IpfF26UsxFZN0FDegPlBIAB4RypfTPmrpqFLBx42SZ/sMWt
         p6xRNO//132viMq7RyXeuDBZGzkXAomuO67PPaL6pQRDVBOonOyZiaxa1p/KloElZACz
         wyUFHle0nk4KvKLfcntxEbBpLleha81lw9YEWQpLXR0xOV3/72/s+NB/viWyVjCezsTW
         FCGMCfnKHV752G4kyyXr+KC6A+3IfhvEl3axMUT8o2yy0Lfdmsa6oxN5b/EKNcFNXXYS
         hl7g+2dxmKx3jo+RVXsU+GC1EOh11RqXXXv9hUBvoa9LO9kNSzKQgaysrY1euOcH2r1d
         edlw==
X-Gm-Message-State: AFqh2kp7GnTwp52hRQzdjVrWzCPdYIcmX6jhuxZrHQfmuyk6eWqf7LHy
        Z3r0V4PshVbQKqW1no8IxFbj6m5/g8EkNq/O
X-Google-Smtp-Source: AMrXdXsBoRCHWKGXB0kcRtaStjS8BDjubZQW8hcxheoijygtcuyG5hfb2vVq+2jU0jYkGOq43mIjzQ==
X-Received: by 2002:ac8:6f16:0:b0:3a6:9cfa:d6c with SMTP id bs22-20020ac86f16000000b003a69cfa0d6cmr3724157qtb.39.1671189998681;
        Fri, 16 Dec 2022 03:26:38 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a15b300b006ce9e880c6fsm1234502qkk.111.2022.12.16.03.26.37
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:26:37 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id x11so2366053qtv.13
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2022 03:26:37 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr19675311qtq.180.1671189997363; Fri, 16
 Dec 2022 03:26:37 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com> <Y5s7F/4WKe8BtftB@ZenIV>
 <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com> <Y5vo00v2F4zVKeug@ZenIV>
In-Reply-To: <Y5vo00v2F4zVKeug@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 03:26:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
Message-ID: <CAHk-=wgOFV=QmwWQW0QxDNkeDt4t5dOty7AvGyWRyj-O=8db9A@mail.gmail.com>
Subject: Re: possible deadlock in __ata_sff_interrupt
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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

On Thu, Dec 15, 2022 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> CPU1: ptrace(2)
>         ptrace_check_attach()
>                 read_lock(&tasklist_lock);
>
> CPU2: setpgid(2)
>         write_lock_irq(&tasklist_lock);
>         spins
>
> CPU1: takes an interrupt that would call kill_fasync().  grep and the
> first instance of kill_fasync() is in hpet_interrupt() - it's not
> something exotic.  IRQs disabled on CPU2 won't stop it.
>         kill_fasync(..., SIGIO, ...)
>                 kill_fasync_rcu()
>                         read_lock_irqsave(&fa->fa_lock, flags);
>                         send_sigio()
>                                 read_lock_irqsave(&fown->lock, flags);
>                                 read_lock(&tasklist_lock);
>
> ... and CPU1 spins as well.

Nope. See kernel/locking/qrwlock.c:

        /*
         * Readers come here when they cannot get the lock without waiting
         */
        if (unlikely(in_interrupt())) {
                /*
                 * Readers in interrupt context will get the lock immediately
                 * if the writer is just waiting (not holding the lock yet),
                 * so spin with ACQUIRE semantics until the lock is available
                 * without waiting in the queue.
                 */
                atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
                return;
        }

and that's the new "civilized" reader unfairness.

The traditional rwlock was unconditionally unfair to writers, to the
point that there were starvation issues because new readers would
always get the lock.

         Linus
