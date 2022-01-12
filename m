Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF17BC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 12 Jan 2022 23:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiALXP1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Jan 2022 18:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiALXPY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2022 18:15:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD3C061751
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2022 15:15:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so15448484pjf.3
        for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2022 15:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/y2AAoWg0jo7n/Hplc5uIX7ONjc1oVp5Pl/tJw5N/bY=;
        b=ct3L7doJdQkcZMxdhA0xSjCLCeqq29INV0vAvLZJ/PoHgqdf6L3aOZAVhVJC1twVgy
         UzIY3r9n7wNgxSZXlpuG7Rl2GC6ygpvo8XmvEECrMObCy5Rt7QBIntpHqSLUSvtT9Tik
         aqiDhzzGbOTzTSg180N2ZyRC7oLcBRqKO/6RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/y2AAoWg0jo7n/Hplc5uIX7ONjc1oVp5Pl/tJw5N/bY=;
        b=Q/szoHy+Lza67W35RgjxrCiUmk3CpSPxMXBdVTMaChQfT8D0usI05oZEGsCfM+a1UI
         65Qs32/tcLT1eu04EOFFvUG8P1Z0Pkb9amJvJKcxwiV3bbGKZHaePveZdaGZVd9IlI6r
         kAyQwFd00F/F+OxW2+JinhuLs3u93d6dkTWXc49Co69dqRL93DtVTofYFAgue/pEWiuL
         QLtTj+jzNNzkNpvC9ZgXyrvic3qUipQM3uhb7wI7+r851F7gwbL4HR08eR3Uuj0rsEX4
         wUnvC2XUJtrjqnhd6nzXII7E1qAhRWhiqd3W3tRkK53zbfxzXhXhnAsjLXyha3TGmDxu
         CWKw==
X-Gm-Message-State: AOAM533Ua1VS4J7/A9EMUahSs2ZBPswHbE7Yns0+I2tK77n2CQbIYKld
        UBwGOjg5ZJ6yMsbM2Sy9Ma4pzg==
X-Google-Smtp-Source: ABdhPJzsXk6JsYAFimqDxGcn80EZtzgRfrXjeMB3Em9qLPu/9WL/yzdgzVKl9kVoSu3y9oy78IKdSg==
X-Received: by 2002:a17:902:d304:b0:14a:3d9d:3208 with SMTP id b4-20020a170902d30400b0014a3d9d3208mr1973241plc.86.1642029323634;
        Wed, 12 Jan 2022 15:15:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm624376pfm.56.2022.01.12.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:15:23 -0800 (PST)
Date:   Wed, 12 Jan 2022 15:15:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
Message-ID: <202201121515.8679164D6@keescook>
References: <20220112220652.3952944-1-keescook@chromium.org>
 <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jan 12, 2022 at 03:23:40PM -0700, Jens Axboe wrote:
> On 1/12/22 3:06 PM, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct command_desc around members acmd and fill,
> > so they can be referenced together. This will allow memset(), memcpy(),
> > and sizeof() to more easily reason about sizes, improve readability,
> > and avoid future warnings about writing beyond the end of acmd:
> > 
> > In function 'fortify_memset_chk',
> >     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> > ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   199 |    __write_overflow_field();
> >       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-ide@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
> > improvements that are close to being finished. :)
> 
> I don't maintain libata anymore, so Damien is the guy to nudge ;-)

Ah-ha, okay, thanks.

/me waves "hi" to Damien. :)

-- 
Kees Cook
