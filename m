Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346AAC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 13 May 2022 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiEMV1Z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 May 2022 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384667AbiEMV1W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2022 17:27:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD412AE4
        for <linux-ide@vger.kernel.org>; Fri, 13 May 2022 14:27:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w187so17424544ybe.2
        for <linux-ide@vger.kernel.org>; Fri, 13 May 2022 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5AthED04DvJKPgqpu7aFbZJ2so3QAiqmWJHWR8vFaU=;
        b=SNOrvzyPthgcBhIMLJS++HW5z0GuyJwLjXKA2K73VDB2hRg8mgC5kpEFN2SCEnd1Df
         4ong9e7mtL3QvvmbZfeYOkfP7zjFdGiXsDr8pNUVP8ruCyC0GAvvABFcM/flbrIfwkmJ
         +SU9AJVBfzn832ahOfi/isu4j3EiNvZMPjijck2vsQyf7wrqX4L1mHp+CReHtG9LdfsW
         Fw/44ZL4wpHMDWrxPNcstCK0H8jSytBPUykESvjqyxxNONcdqivkWlJKJP2SOmOtoysg
         bjgTmKZKsW/9Moq5W7iicISLpsdgVHTKlIlpaPIzzSAUSTMtwu0+giE5bOrsFTZsuOlm
         4AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5AthED04DvJKPgqpu7aFbZJ2so3QAiqmWJHWR8vFaU=;
        b=3PlqF9j/r3fViWOtGJRN4uuAkY4KdYoO2zdNI/owZuFNXIKn4eKCe9qMMX7m1dKa/+
         7oKje1scteKWx7oS/AQiMVRBgMIaSPJnyP9K5xKocGtjAyXeuYSNZKSpvTMhwDMNViMz
         t2hio47p4XQ0ZA/eiDXBxgV3HoxS72WiB2VMNt4TmnmEYf9QHAiwqjAsghGaNcDOz2tZ
         npdUocPw9NS0kLV6HqUbNDXFwuwlgQnIJzrx8X1yWmt7zyW+SuHDjU5DTwHtemGfpAN1
         M3A5lg4w8R3t51hcBgZM9ivtw2JISa/PcOh1KoOoqJLHhplNYmw0hgpPhbGPM37vkirj
         rCCw==
X-Gm-Message-State: AOAM532oV6ADdR9639E+syTmqxfKARshhjP+NV/UZVQCaeJbRbmVjiWs
        UJCmy2Wc1/UwpPKKjeB4queuV9MODlAv+Xb6KrzzD7gcZKy7RQ==
X-Google-Smtp-Source: ABdhPJw+o49OaFd2ww+QOMWIlJs0P4szqp/cOcXcZhsilvmGlEbkOYSY3aBHnBUbtfc19fSqMxxlocvLPmva7WBZNes=
X-Received: by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr3984163ybf.514.1652477238724; Fri, 13
 May 2022 14:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220513075554.127677-1-wanjiabing@vivo.com>
In-Reply-To: <20220513075554.127677-1-wanjiabing@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 23:27:07 +0200
Message-ID: <CACRpkdaLArmZc5Zwi-2r3kvBgWHDJ6tbY5o-=qLAG=8B70Hfag@mail.gmail.com>
Subject: Re: [PATCH] ata: Remove unneeded ERROR check before clk_disable_unprepare
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, May 13, 2022 at 9:56 AM Wan Jiabing <wanjiabing@vivo.com> wrote:

> ERROR check is already in clk_disable() and clk_unprepare() by using
> IS_ERR_OR_NULL. Remove unneeded ERROR check for ftide->pclk here.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
