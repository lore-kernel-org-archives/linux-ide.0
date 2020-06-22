Return-Path: <SRS0=6nws=AD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA41C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AD420707
	for <linux-ide@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKm/Whls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgFVREb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgFVREa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2020 13:04:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB44C061798
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2020 10:04:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so110866pjb.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m5221Ut6o3WuT6BjiL72c05hVwdkXllFG7aX4yJx4M=;
        b=qKm/WhlsQKDgGm0JFnkCdb0IzzhquY358SdW3YjXotmWgdudNMJZnXNXgvLG0UCoo9
         7Cw6pnkmDWaW0NfZwL15NqU9yndpUvZfap4/r4/N0EchCfKEkHwdBZzA06x2GNQH+3Mt
         J/3WYO6M5B8qpkeQr8fpVlBadLhCAZf2C9poaWq+QLaHYcQ0rGyiUjvhR65Bxkj+hA2b
         s9+jLdjx7crDjAvCyWnbR0bBghdrf6Nltn1qYGOn5boJGAxwdb3AWa19DW56iVy38cNF
         K25EWlpr0J4GIzjxfrzpPzlHwPqk4eyUHRflEds57fzvbDL6gzcelUVq6RZ2ZRqHOBVq
         4aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m5221Ut6o3WuT6BjiL72c05hVwdkXllFG7aX4yJx4M=;
        b=hCspPDA0d+9ZMJ2XVduKppPX5DlEH+JSmZO2l6GqKnGsPeK2/cehGlWe6Hg4cQsecB
         l4FryIPVBGB9wd+MWRWIg6BWNIEmsCMlaE4rr4V54qXZLsMXr+Fgq+D+yw/4M5R0kPCJ
         2Kmrj9vbjCInQ5Qh4z1Hg1h2nynUh//O3GJ+/DYj5fNAEkqLazo3pzG+1UbSl9W0n9uv
         5CM8THBxCpXKNHLqSmMn8F0DiwB/sPz7ohydE49AjftX9ZCx3nngo8r4yvWEnmeSqV0C
         vsZrWYcq/+fbAx0WUPMcMSQhkiE2RvHPbYHFdhOMRg0DjGofFB1cG15pIN4POk49maRu
         2nfg==
X-Gm-Message-State: AOAM533+c6oQaGhEWgDhYpbdDi/dI5IIgpTNceEXA+I38eAo7cSjfbWT
        sCSQcS3mQ4tMfwaJBu8Puy5zySu+OBYJo3xBIpq8OQ==
X-Google-Smtp-Source: ABdhPJwq3U6/P+kOQWrtaPsfC7pEtXaKjHv6HeLE+nRTnxPEDc+MHw061OC9xpPpZ7i7YIPBLzcZEdJFmiD+WA1tEsk=
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr19317188pjb.32.1592845469798;
 Mon, 22 Jun 2020 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-5-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 10:04:18 -0700
Message-ID: <CAKwvOdmsXuqx-3Rt_KNFq4psAeFjG2-7qQaqkJ7dDqqmscUFNw@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] b43: Remove uninitialized_var() usage
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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

On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just initialize this variable to NULL.
> No later NULL deref is possible due to the early returns outside of the
> (phy->rev >= 7 && phy->rev < 19) case, which explicitly tests for NULL.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Fixes: 58619b14d106 ("b43: move under broadcom vendor directory")
> Signed-off-by: Kees Cook <keescook@chromium.org>

I see three total uses of uninitialized_var() in this file, do we want
to eliminate all of them?

> ---
>  drivers/net/wireless/broadcom/b43/phy_n.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/b43/phy_n.c b/drivers/net/wireless/broadcom/b43/phy_n.c
> index c33b4235839d..46db91846007 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_n.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_n.c
> @@ -4222,7 +4222,7 @@ static void b43_nphy_tx_gain_table_upload(struct b43_wldev *dev)
>         u32 rfpwr_offset;
>         u8 pga_gain, pad_gain;
>         int i;
> -       const s16 *uninitialized_var(rf_pwr_offset_table);
> +       const s16 *rf_pwr_offset_table = NULL;
>
>         table = b43_nphy_get_tx_gain_table(dev);
>         if (!table)
> --

-- 
Thanks,
~Nick Desaulniers
