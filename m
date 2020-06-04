Return-Path: <SRS0=h3CG=7R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C779C433E1
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E1420659
	for <linux-ide@archiver.kernel.org>; Thu,  4 Jun 2020 19:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPGYj+Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFDT40 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgFDT4Z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jun 2020 15:56:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D3C08C5C1
        for <linux-ide@vger.kernel.org>; Thu,  4 Jun 2020 12:56:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so3971844pgl.11
        for <linux-ide@vger.kernel.org>; Thu, 04 Jun 2020 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JchjGYZl0wqUOrU5YQvGeZV5DROtdtYOgYQQhEiIskY=;
        b=qPGYj+Fa3kUn8rqUio1Dqo/wmmdxLTwJv3dkdlE3ClgOnCxbEa6OJED06WKQ9xZ/S5
         drxLk5d97vcv5eQ6d4d6pUs5J9MwW0FbQj4r4wLXcZG5wYgEinukAsqpd6SbNEpGTiIL
         ybbjkH30SzUTY9QY0bM3t5oBYgf/gdFtcqSjGZ4Vd93wXluzmD0tkk2N1s4+IczoK5T8
         73LFTDcT2N2adp5wR2Mlu3UFct0QurWe1qbINXwuT+3G9C5se3K/oYDgtwvOmb8nMB81
         9/qgL3YapcLXLfnBA8fVq9DtyGqYOQK0MGNYMtExoxZdmGcyOrFvw2budA/p7MR7MkMh
         dTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JchjGYZl0wqUOrU5YQvGeZV5DROtdtYOgYQQhEiIskY=;
        b=l7WVksvE3q7LXLDr003bVu6O5Dsyxjedj1rfbepeUM8ebbIApNwnjbJU8WnIcd15qx
         hSh7eL+O18LGeO2q3Iuu/O2ebZVbZWAYlNdFl6S8Hx1ckDz93Ym9B9Xbj3N9qmkKdUSD
         WEGFk1JeGOM7MVNu0hJn5aeNlWOPyswcMZfV9fSfl37O+2lkg7M/kyhY7G6PO9ao8Wf8
         BqgMd3r0GKD7OsM7dC7zAtqfswWLIkLgzyZIhu4xwSkQX29/sm/xoTNcGR/FepR7KI5y
         4UX8W9BOgGiyVKkjkLlfgk33HYla02U+nT2vEYMVH8eJpsK/oEzukJVkPqg8K4BvFNQ6
         x7Nw==
X-Gm-Message-State: AOAM532oZpWVQoPmDpA4c+XV3cE6UABFP3KXOrmhH8hpzksYSpX9EowL
        sSAxDeTP/0xwYczahwJprD9qfHBuBZhpRJEN9bfrUQ==
X-Google-Smtp-Source: ABdhPJy7InXrusPAFFTJ9/oFSaSF0Eic2jn49VfP7aR0w5k1vGP4KYsGIQVm0HirYrhRu0SFvISfn3kdwUp620gXyHY=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr6167247pgh.263.1591300583418;
 Thu, 04 Jun 2020 12:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org> <20200603233203.1695403-3-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 12:56:11 -0700
Message-ID: <CAKwvOdmfOSGAZiuapXOaiU74AQVMDgimrnCiRDjzw4p4oh1vaw@mail.gmail.com>
Subject: Re: [PATCH 02/10] drbd: Remove uninitialized_var() usage
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
        clang-built-linux <clang-built-linux@googlegroups.com>
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
> to removing[2] this[3] macro[4], just initialize this variable to NULL.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes: a29728463b25 ("drbd: Backport the "events2" command")

> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index eeaa3b49b264..0067d328f0b5 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -1604,7 +1604,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
>         unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
>         void (*last_func)(struct sk_buff *, unsigned int, void *,
>                           enum drbd_notification_type) = NULL;
> -       void *uninitialized_var(last_arg);
> +       void *last_arg = NULL;
>
>  #define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
>  #define FINAL_STATE_CHANGE(type) \
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200603233203.1695403-3-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
