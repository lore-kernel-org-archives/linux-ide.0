Return-Path: <SRS0=h3CG=7R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C433C433DF
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E472077D
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNWdjuwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgFDT3a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgFDT3a (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 15:29:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C7C08C5C2
        for <linux-ide@vger.kernel.org>; Thu,  4 Jun 2020 12:29:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n9so2629011plk.1
        for <linux-ide@vger.kernel.org>; Thu, 04 Jun 2020 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BN0NA5oXxaJmgloA0bV1VuRl7DweslwGb9BXC5tlSZI=;
        b=qNWdjuwtEh3SepeFF9fNagsbBVKMOdC+i2KqVDopsH6dlehq61YjmGsjU3zQ6/6Sm+
         RI59y6nTt3iJaugOaLxusXHriKBWVNJCrzHeENeqAGVpHLkPMQooCck+j2xRNg4QVbq2
         U7Aga0bTxqeYSMNSshjefDdYD9kzqlGJMlmXX3yAeOrKcPi394fVJzn+N+UEYVrgLikW
         PJ80Ob/zePEkwKogqqleJVCwqC4lBAXZfyFsOJ1Q71OHbRbc0fyAs9RyF+VvGzxb6jyN
         PR+j0XjbkYKBjIdoJN78dsQ95HeKy3QSGz7aES9jpi6oH42fz2hvJ1Opql+7AsV4VMb8
         cVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BN0NA5oXxaJmgloA0bV1VuRl7DweslwGb9BXC5tlSZI=;
        b=AgBvwr9YCtqle4QifOcvcE8KdETxuDOKkTm+9I15qGJPFLKYCaIj8uTdU93voG3r2J
         p8o8u+mtMnjR1UDUYZte4Wwf5oMz3qYvyeQmDnHFSz52410fZFG/NtTigYH8T77vm41d
         tHB/gs0uoVNlq8xHFIUQJsaT0j9GISOVPR6i2hh8dCIL4EJbQcXbbOWaK2l+oY3HztBS
         YgKNFX1VxRbQra4Wfjd0cM3AL4DFUVl9uHLEVFDKcBkgiGnK98bO6+6rsL8Zhp3FMwX9
         H9unrtRgZ+tRtKzs4U11urhpKNQhdyAdUn/88GM8+7owZDVceRDSHpb/6tUry98thwMw
         rpbg==
X-Gm-Message-State: AOAM533Ldm/NVSMD2NOhYAdfjqOqFo62KDCE9nGscyaFZgwuA+chf5Pp
        8tf1wCNg2VNUKtFA0gBpN+HnLPoV8aAWwmO06ick8A==
X-Google-Smtp-Source: ABdhPJzSzKsiHc4z7LwcmpkgMu0NbAbDQYhYcnmTB/97B33m/EUjE6lKfBun6ZCLEkmHQ8gJwyD1p9mb5gkpJj8C3R0=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr6119344pll.223.1591298968901;
 Thu, 04 Jun 2020 12:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org> <20200603233203.1695403-6-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-6-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 12:29:17 -0700
Message-ID: <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
Subject: Re: [PATCH 05/10] ide: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just remove this variable since it was
> actually unused:
>
> drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
>         unsigned long uninitialized_var(flags);
>                                         ^
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")

> ---
>  drivers/ide/ide-taskfile.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> index aab6a10435b6..a26f85ab58a9 100644
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
>         ide_hwif_t *hwif = drive->hwif;
>         struct scatterlist *sg = hwif->sg_table;
>         struct scatterlist *cursg = cmd->cursg;
> -       unsigned long uninitialized_var(flags);
>         struct page *page;
>         unsigned int offset;
>         u8 *buf;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200603233203.1695403-6-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
