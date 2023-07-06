Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A1EB64D9
	for <linux-ide@archiver.kernel.org>; Thu,  6 Jul 2023 18:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjGFSCi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Jul 2023 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGFSCi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jul 2023 14:02:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B9E199F
        for <linux-ide@vger.kernel.org>; Thu,  6 Jul 2023 11:02:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bd77424c886so1199988276.0
        for <linux-ide@vger.kernel.org>; Thu, 06 Jul 2023 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688666556; x=1691258556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp1EjdfHH9ncfytaq28XNjejcIMtxhJK6i4hsIXtgIA=;
        b=EmlH79ozm2XgthEqgBNVDrr2M9UVj+56g2QJxcexPnshrwIa94OTVYqHURw0LsOQOi
         dnz3xfKGqeZt7NstoTNHyEygGHkEvfbQUh5ER8c+jQQ4jG+uQxfnk6r+Yh5O0HCJCIPM
         ESiJNiIpRUsyizu7/KtHsmd+5hEucwHO/KUpmrcxJNsS7MyRMlPspbff5r3QIl4eXZd5
         UsnGupp9DU5vFXmWo03i7s8uCVckMCGoGxaKXinKu8Tbxuql4apgDJ41NVxX2Hn1v6Vh
         YmzIUzM30vCa5vMfdk3jywRZXrUaKdnsFrX0OS/E3B7dES3f+n8Ss7IRtadEy1jnLoVQ
         xkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666556; x=1691258556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp1EjdfHH9ncfytaq28XNjejcIMtxhJK6i4hsIXtgIA=;
        b=O6rCkya7V4qwa9aemLsQQH/dwBXra3t6S1ldZCD4hTnz79E142OfVyWASrAYib7dAP
         qCryw2hqd0OceUm1X90poNcZThNmCq2zDFy60kCihaHFK/b19Z1ajqyyMXh4x+nelQNV
         Cztdek/xt5IImJtOHZdW3tXh8Zq+z9c35zlpDS3N7W9h96prc5CIrxZiRVPUuTm3E/sz
         Km2gIjFji3D+U+e17AdkqDuKdabsJn+tvBccHIM381CNJn1htgar1b7jKLkLB8Rk3EYq
         q0mPC9OCW/EGTXpzj7hZ4vImCH3UO327ELsgTRlDXS2ty2nor32CeGcJd9PZm97RpFmF
         RJSg==
X-Gm-Message-State: ABy/qLYInKwHldniHfYJSXijeOROdPx/E9XrFRPynsLqGkZrbJ6e2jbN
        yZiVAeUD15TCDNewt+0csM/wxV3y1TA7WW5vpIrIWA==
X-Google-Smtp-Source: APBJJlFTDtlGJPqhjR7lEZ+O3t1RJwP4VvxGhySPQ373Ogt5DrEeq71+OvxsxcK2TUQvLsYAd9BLjj/nxyedC330u5c=
X-Received: by 2002:a25:b7d3:0:b0:c4d:c258:7ad with SMTP id
 u19-20020a25b7d3000000b00c4dc25807admr3607123ybj.64.1688666556569; Thu, 06
 Jul 2023 11:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230706124239.23366-1-frank.li@vivo.com> <20230706124239.23366-7-frank.li@vivo.com>
In-Reply-To: <20230706124239.23366-7-frank.li@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2023 20:02:24 +0200
Message-ID: <CACRpkdZkdhtTG0BZpGzyJp50iF+81StNPq8EDQec7N7Ev_ibNw@mail.gmail.com>
Subject: Re: [PATCH 7/8] ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Jul 6, 2023 at 2:43=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
