Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BBBC4167B
	for <linux-ide@archiver.kernel.org>; Thu, 20 Oct 2022 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJTLSy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Oct 2022 07:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJTLSw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2022 07:18:52 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BD1ACAAD
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 04:18:51 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id p89so8697719uap.12
        for <linux-ide@vger.kernel.org>; Thu, 20 Oct 2022 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4yNfgdYt57OohzxwCH1esBxLVu69+vmUe2ikK/4LWY=;
        b=49vtJf0c5It2Iknt3l/k7+opjdNuUF0nINt5E5Jy21NUgXQ1441CnbelIb+Zb8Iei7
         tbadreJlDzHpoy9h6p81ZK959n3IfECQX9ifwUelTq3Vn3krsB1RSrDzt5XhNOzqLBWB
         RLwqkOxaKd0U5WSQEyvmtJXOf4eZbSwo+r1a1HEmJG+kpflgcYM8RHdJg1D8MfrdE/ar
         PngTM8W/U0BR1Fdoekw0M+/ghlnZCqvnq1Wn5VEVkLLB7rh6gjALftzuadmFoLHngmpl
         K2ID3O6/sb7ssamZDFSise9IRPr+GL1uxwuMFn/yS5vpgdhRlxNBuLmOYlchGGlpJW4b
         DV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4yNfgdYt57OohzxwCH1esBxLVu69+vmUe2ikK/4LWY=;
        b=txhOPri3aPrJkbUoJmdB9kY/jxbO0Q+J7/pbjCDicDAOvor85HNLGeH539Pubwm1aS
         jOC04L8wv6Q50M5gXKgjcqr5MYrbgiRmBvxjcOey7DeyGfC3shPGQWtDjbtpJeitmtul
         tXKQ55Eaxax3TtaLZOqx8bdMbwfLP9wZEUBoYKQx0saQesGJ0o1ybKkqmzfV0GNhiTeM
         gKQ+VQhXFxdKZl5YH/Bc17CQzeiDnPFTXZHwUncMSDoiESl9C/ce354zNINdUN0zPwkS
         x7FUcnyLHPRIXnoxQAhCAYDOA69Z8VCmOhbaFla9KMlfDp718/dpBWm/T8O+ida9/SK7
         EmOQ==
X-Gm-Message-State: ACrzQf2nI3XCdFk6AKqQxm6RjAQycTO5BlWiZldqkOzqhRlUHT5dU2rS
        aJ80sp+vW1Q8+6hgCGRX73lIcEE1pYR1GYEoA2vCKw==
X-Google-Smtp-Source: AMsMyM762bnsENd96YRg5cs5iK+jXaUnjmTAxCH71GWL6OADkqGRfA+/Q9MVteIpYcE1xjQ6HSh4XXVvA4ehsuW7v9c=
X-Received: by 2002:a67:ab02:0:b0:3a9:9953:6471 with SMTP id
 u2-20020a67ab02000000b003a999536471mr4291701vse.47.1666264730567; Thu, 20 Oct
 2022 04:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-12-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-12-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:18:39 +0200
Message-ID: <CAMRc=Mcph92ir5KgSr5C4UHAwCz8MkyykR2hBfgv4NS2rMcLHw@mail.gmail.com>
Subject: Re: [PATCH 11/14] pata: remove palmchip bk3710 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Oct 19, 2022 at 5:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This device was used only on the davinci dm644x platform that
> is now gone, and no references to the device remain in the
> kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
