Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78A7C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiA1RFo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350427AbiA1RFn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 12:05:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24FC06173B
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 09:05:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id me13so18019407ejb.12
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwYAKS2PHkfBDSUcmz7WICdK0TWuicFdF8sZ/pYvJpY=;
        b=aOFXYQlsHjkhalBYrcJC7ChfMeHG4NuBjALk93xd5gISZH+xR+JIHZfpsdB/KV5HRd
         amPnLLMogD/Kq5ldL/bMX59e3eOCNhNjR6hOyBG1Byyf/BBrLX/ZRauRM9IH+lkGFk43
         qdHVpN4ttt5Z9TpbnkOONBCBWxKhuSNKMATM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwYAKS2PHkfBDSUcmz7WICdK0TWuicFdF8sZ/pYvJpY=;
        b=uSL93y3hn/dBtJnsRDkSw/YwukV1fSrKSSjJa7jvjO7ZbH6ZLQHJounA0zZBb2N8D6
         ssmP6WPNEqqD6kZxu/k+QZ8Y4Wns2LMnqdDSI4MONATcngpHLQav1nWydm/ZFQVWrtQC
         8RWLLlaIGnJhlrEG9QTzNhx27qhr3eBgLD9O2sEe651rWsVNNjQBaCBY+zUIBxd0x/UH
         /YIXi+/upkWsyYvYQJxjW09ruJ3h6hmKeJIgYV1LFgOP7wWUhUbhATSRdC0UY5fb/r6t
         RbXKi+JNJrtSQ7MPhc3Pre64IQHp2Smjjx1JphBn7ALX0enRWmCUvCwVneyRTe5LgYXG
         L1NA==
X-Gm-Message-State: AOAM533muOd4l5vDbtINdt1Jr+y+4mG9HSdzkUikJnkNRDHIltow8oaQ
        01HYQeSCONVQDO5ujC0GQKZYPkcIe0HdXCCR
X-Google-Smtp-Source: ABdhPJzrlIokQaIuGydEf9pWe9m4xXJmpuVjPKtdmhmwGALCykFlRP+Fkohyq26xxg42lKymMvItqw==
X-Received: by 2002:a17:907:1692:: with SMTP id hc18mr7751735ejc.295.1643389541384;
        Fri, 28 Jan 2022 09:05:41 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id o11sm13140601edq.5.2022.01.28.09.05.40
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:05:40 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id u15so12111543wrt.3
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 09:05:40 -0800 (PST)
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr7957438wrc.442.1643389540166;
 Fri, 28 Jan 2022 09:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com> <06c7c6ade058b2ac4684be932cff5193aa3b31b2.camel@HansenPartnership.com>
In-Reply-To: <06c7c6ade058b2ac4684be932cff5193aa3b31b2.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 19:05:24 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgxnya07dHiZnS8x1rQkyQYmf6K37gwxkR+6e80Tk26DQ@mail.gmail.com>
Message-ID: <CAHk-=wgxnya07dHiZnS8x1rQkyQYmf6K37gwxkR+6e80Tk26DQ@mail.gmail.com>
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jan 28, 2022 at 6:57 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> However, the original patch:
>
> https://lore.kernel.org/all/20220124164525.53068-1-zhou1615@umn.edu/
>
> does look suspiciously like a fishing attempt to see if we'd notice the
> logic inversion in the supposed null check.

Right you are.

Gosh darn it, I thought the umn people already apologized for their
bad behavior, and yet here it is again.

It's good that I'm now a reformed person, because otherwise I might
use bad language.

                 Linus
