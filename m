Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C7C433FE
	for <linux-ide@archiver.kernel.org>; Thu,  3 Mar 2022 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiCCXK7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiCCXK6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2022 18:10:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87357141
        for <linux-ide@vger.kernel.org>; Thu,  3 Mar 2022 15:10:12 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id u3so13370407ybh.5
        for <linux-ide@vger.kernel.org>; Thu, 03 Mar 2022 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YInCGTDHP4uEDLfZ+VtOKdALPoSEe5yJvGES7+vW7vI=;
        b=rYUcvXAjbjBP/e/HHL9CQrZXT3yEcE6V3E5vTjyI8ujlve9/iZ/WOdLLbrrhK8HQgC
         IcplXQchbeeDO0QN4mH3DD9fn3VaYVSZdGR5pAXvesv9RZxAHf84T3ZMaWXRceTdLtRJ
         Co3yPy5txLG+rQqamF7+DphG6YADQ0R6yiTdhJJoogWVX4BJiQwXXLHwMBti9IKDhFjZ
         A12cV6bBEf08yORmYmsfD021Q82YuE+w1YA2Dqkw1Fba4Y87oOK7FweNtHWEKCAuwsKI
         paQf3SYp8l7zTuhvdmpZE3PKUGoh+NTaVD9S0mH7cODfPuuAXu4j6BDt9P4zGaiT9iUG
         tNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YInCGTDHP4uEDLfZ+VtOKdALPoSEe5yJvGES7+vW7vI=;
        b=Ms+Mk0creyT0KSt4l80SC7omRM+loJ7F2KLl5Urv3wwF4cj4VSioNJG/tXZ+Wi3E1H
         8HN8rOVs09vM1wuUhtscjKWjUiz0itvUHJDARY9QT8XVI1pj4ZRNiak8pB6OH6EtXzG9
         q93p9dEzWt4f/c9V6ANVcFi5df64ITv8pOFcx84rEvz2wnvsANGsDjWtMVl+kolcwxei
         BNmSS4JdslJssFE2IF8nvDjlOItiLm6x7N+YWFfper3cOBWta2DmS4Rt3HudpeK95QV5
         uphIe06Vmt4kknaxqqlPRurEVcevHiJ/v3gscgqVtzYF3knMx08XCXPuFMt+0Ch0/O8m
         F+Eg==
X-Gm-Message-State: AOAM532gqstGypanCv6K+7loSEd5lwGDWEXoCXUbN6oQRFAlLv5buFTK
        yPotpOnD1A8MzeNCg3DGCJ3iCA4dyMO3nQ8Nr/pHOg==
X-Google-Smtp-Source: ABdhPJzTeVvy0ZXmMbNug5JQgHPRdUPKsYwepu2pUfahumGm8539y4yaEH88/G2mI0zVqSydkS+y839Csd59U8fXZts=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr10394599ybj.626.1646349011461; Thu, 03
 Mar 2022 15:10:11 -0800 (PST)
MIME-Version: 1.0
References: <52970494111d9287cc8355e0f2e3de474361c75f.1646296493.git.geert+renesas@glider.be>
In-Reply-To: <52970494111d9287cc8355e0f2e3de474361c75f.1646296493.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Mar 2022 00:10:00 +0100
Message-ID: <CACRpkda+gNgE1bE1_79pLrqku86dXygg4v_ynC5OaFNb0yth=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ata: Drop commas after OF match table sentinels
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Mar 3, 2022 at 12:03 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
>
> Add comments to clarify the purpose of the empty elements.
> Rewrap entries to a single line to have a consistent style.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> [ahci_brcm]

This looks so much better.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
