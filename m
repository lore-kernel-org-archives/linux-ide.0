Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10EBC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D776660F70
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhKSTKB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhKSTKB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 14:10:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FADC061574
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 11:06:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so46737366edd.3
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZXnzyZTf4l7ZKMprGyfxSmHpsr8SLIzFdNVbMtiMqI=;
        b=NLAUA1T8rYBCTcZTzDSc1Ii1RLEY40NjVfTQo17x386y1ySE5RJ3kxOQF1OsWGQ/wi
         FlB6p+n6No9Kqtb96t51ME6s0hBitHHM+dRkdF9Vu0QWSxlsNgmBV6/+IjQxfyt683jl
         x0evr92dhxsKD+1nWzn41YKT88l7hrbppi5CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZXnzyZTf4l7ZKMprGyfxSmHpsr8SLIzFdNVbMtiMqI=;
        b=ZY5ZIGMC3LF1aXq8sMzAx9vEUJCMLMp/uIBAMvBZ/uJqodBI2CMPwk5BajSj5S9kR4
         zi4Kx2h+k88lgQZGb5ls85fLdmIZ/w5ZMrPFe68GIivAbr8D6Yw2+sLxkSJL5YXElEoa
         dzBBFtjz00Zv5jSlB471nnTu2AJ8fVkqvOAWjLe8dksORXFZ4PKGBsMk9YgC5s+CQriO
         GiAUrSJhST+OZmFXuEKy81VlSb+QAUhRWM84Wgm9EHYl15i1KMzxTX5mhlRZ832p1PBj
         Hl68wmfNAkVB79zXpg7HgKaOvXSw9WAQZSQAQeVaniMT1tHLTUjpr9Xn4RO143MoTln9
         DTJQ==
X-Gm-Message-State: AOAM532nL9oBGxmvKjRxvuajnMBlq2wJTHaBSnQsVnmpekXsjB5kHr/N
        JucrnrQ3OdW6tZ9dK7gYb8jrbxsjb8YgknUD
X-Google-Smtp-Source: ABdhPJw6YrXl7I0SqfPaCZzYa+IzsoNbC5bzpJctWmyiR2jD0Q9Krag5zWQcGwzhp9O6Rc9NOcy7KQ==
X-Received: by 2002:a50:9514:: with SMTP id u20mr27871693eda.117.1637348817225;
        Fri, 19 Nov 2021 11:06:57 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f22sm324699edf.93.2021.11.19.11.06.56
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 11:06:56 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id d27so19798790wrb.6
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 11:06:56 -0800 (PST)
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr10331628wrt.131.1637348815978;
 Fri, 19 Nov 2021 11:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com> <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
In-Reply-To: <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Nov 2021 11:06:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
Message-ID: <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Nov 19, 2021 at 7:46 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
> On 19.11.2021 11:49, Damien Le Moal wrote:
> > Baokun Li (2):
> >        sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
> >        sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
>
>     At least this one needs fixing! You were too fast at merging... :-/
>     Well, I guess this will need a follow-up fix now...

Hmm. I'm missing the context, but considering this note I have skipped
this libata pull request.

Damien?

               Linus
