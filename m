Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7AC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 30 Jan 2022 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiA3A0y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Jan 2022 19:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbiA3A0x (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2022 19:26:53 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE46C061741
        for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2022 16:26:53 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so29413380ybd.13
        for <linux-ide@vger.kernel.org>; Sat, 29 Jan 2022 16:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68/V3MY5JP9UkyqueQCxP/UeJsRwm9MLgcxb/az+jzk=;
        b=FH4iYTqipNVKqDmij2ZPrX7Qm5hc4cGDKCaSfWi0a+q5JlVIG6VblgL4BDR39CYWNa
         P7Zvd5cMjvx73T31hjp5ouCZctrebkMWzuF3kD2smRB2Ok0u78EycYCj7o5cN3Crtw8x
         pyxhNqO5cqJ0qXep7PRaPvQDAnI25JB/29HJFo6TgNBlsXLHHvgeiGvqT4/rw+iufOqi
         a5ukGMTAZkpvlsNFj73CReuWV8sJObZDhkCmzhmLwdEIQTo772NA1gB/waFuAc6szWcm
         DbgyK3Q1AQmD0JKAM5jxRj/biWMOqo8fFjLrB2J9bTHM3eTZmIVZI76lvGCO9qaBEv+w
         mC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68/V3MY5JP9UkyqueQCxP/UeJsRwm9MLgcxb/az+jzk=;
        b=3J9rT6xhEgGjk+rUCtCji7jjtJtagsqqQjj0anv2pHRmfdwnm1VzGkjnw6IasT/59K
         WZ4Np+CS/D1RbYvi1yPmTXNrDw/haQvdQJi+Q5+7w/vw9zwpvBBVPIQt0zAJaahLPmoa
         44cE+8wi4NaD6mHLDFGYgZec58I44oi9gKOYwmJ4tsntludL+3nfODtybd6uN8MWSeVO
         WIEHcg5HAwj9FLdJSxHXZjyE7fUeLlcBOoV1Eq2HfvW6dy46VwY6RqE2ttzwV3aeIGYD
         qN17h9H/7t9PxVPlvjCveQQ/RcJz9X0S5UXVPQa2QzCa8oMx0JBpL7ogDXiapKXJIHgt
         TDZA==
X-Gm-Message-State: AOAM531yPch4YAB4ggufmSlNaQ2UozupT9wFRPQHWx7XLJGMf30vK8k8
        QaUNVtKLi5YCrVbyG1EubOLaYWjzV4nMzEqZACXbEA==
X-Google-Smtp-Source: ABdhPJwcZgJxoJmzqk0/B/DVIlxi9mGld2KCgaQIQ4yokiP1JKJJwlCWgr3ysrSY3tKeskw+v6lGqPPHxWJOikyw1nQ=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr20106266ybu.634.1643502411942;
 Sat, 29 Jan 2022 16:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20220129204004.1009571-1-clabbe@baylibre.com>
In-Reply-To: <20220129204004.1009571-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:26:40 +0100
Message-ID: <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     damien.lemoal@opensource.wdc.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thanks for doing this Corentin!

On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
this patch when he feels it looks good.

Yours,
Linus Walleij
