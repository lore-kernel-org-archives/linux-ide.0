Return-Path: <SRS0=swEm=AN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3CFC433E0
	for <linux-ide@archiver.kernel.org>; Thu,  2 Jul 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858E6206E2
	for <linux-ide@archiver.kernel.org>; Thu,  2 Jul 2020 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fz3Jh9Eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgGBPVn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGBPVm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2020 11:21:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C020C08C5C1
        for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2020 08:21:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so11433299plo.7
        for <linux-ide@vger.kernel.org>; Thu, 02 Jul 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=85NgcoW6jBNBGz0tQzl+oqewL1I9o/iwYquf90s0iyI=;
        b=fz3Jh9EbW2QNq/2MyLiNywl+Bw+HpwfpGyCppJTlFpNOcSFS1TexJkrkG1UxqufMgU
         DTnt8qDgoR6kpc5Uov/N8ZFtF9gBkglTu3rbJlgEgXDnMffWLDd4jgcOStrGlPxU6l/S
         kAv+vOh2+5LMMHeltnDKRB/tSSiTCWUefTVYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85NgcoW6jBNBGz0tQzl+oqewL1I9o/iwYquf90s0iyI=;
        b=j7BFyb6rtkv61NsU+jfURjVOGi9dOBAkMieHhZCKFjwlXUBubNX8SOs62gGZM8fKDh
         QQ1KtG3bM4FWPSQm7rTm+N9Kc9vRz4vX7Tty+3nriesiUGtVKFxLDxYsXNzqJwndX4ud
         GeUN8xSSD//DgzFWhSjJlwld2F9LuKGHCw1gKEzYkpm7YHYmZ3p1aCTjz1m0TGwdQM/0
         ADnCje4DIr9FZdVLMuDPJaamCuHRgM04e/HQNZPyOZQUZ2f1eZynXes2cRJ81VriP6S6
         p0BmErf8BI73kvQ0eJXsehjG+GTpWFqEHlV6X1w+Yo9Z8K3JYoKk0NNVeguyrEOnZYTj
         /eow==
X-Gm-Message-State: AOAM533WRKC9rubeBobVoySYecH6K8N+xySownembnEMUANPoFJIjNBJ
        gBc6m4dVD5sxL5fdRo6XRZ7C3w==
X-Google-Smtp-Source: ABdhPJyPnF33faJF3QEw2ElnpTvwp44zuiTBz6WWqS/hEjfBUUANHOACCnQyGoZR2gBcK7ir4/OsKg==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr31267430pjt.140.1593703302136;
        Thu, 02 Jul 2020 08:21:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19sm8151174pjs.11.2020.07.02.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:21:41 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:21:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 08/16] spi: davinci: Remove uninitialized_var() usage
Message-ID: <202007020819.318824DA@keescook>
References: <20200620033007.1444705-1-keescook@chromium.org>
 <20200620033007.1444705-9-keescook@chromium.org>
 <20200701203920.GC3776@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701203920.GC3776@sirena.org.uk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jul 01, 2020 at 09:39:20PM +0100, Mark Brown wrote:
> On Fri, Jun 19, 2020 at 08:29:59PM -0700, Kees Cook wrote:
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > "unused variable"). If the compiler thinks it is uninitialized, either
> > simply initialize the variable or make compiler changes. As a precursor
> > to removing[2] this[3] macro[4], just remove this variable since it was
> > actually unused:
> 
> Please copy maintainers on patches :(

Hi! Sorry about that; the CC list was giant, so I had opted for using
subsystem mailing lists where possible.

> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

-- 
Kees Cook
