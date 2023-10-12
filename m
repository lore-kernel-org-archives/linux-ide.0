Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CBDCDB483
	for <linux-ide@archiver.kernel.org>; Thu, 12 Oct 2023 11:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378862AbjJLLtP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Oct 2023 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378296AbjJLLtJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Oct 2023 07:49:09 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70DF1FCE
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 04:47:54 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7d532da4bso11044267b3.2
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 04:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111273; x=1697716073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTz+wDGQhRaVZ7e735trJhj08b2/+MxhchJCSE78PTs=;
        b=vmuDPXQwtMauasKfhAl8Bb1ycm81VqqKPP5bmUbyLPofTxNz0FIi0nRtoS0EnCkGal
         4RtAD6pAoeZrd2tQdXlvdVgjyVfozX2jpKhC8PPWzh0bWlt4cYMwvcWCjarSaIlaAqag
         fFd6UfmWBg2T5xlFxDoVJG7ZyaAPTXf1pa0K7G0H5kNEveSo1XaM4jLpbZ3a/Osj63jX
         q8xQ8iHsTHPjCAnLQ7Gpfywqdu/zx0nwywS/wEQrvUOiTDJF1zQEuauvQfgPYosBz2L7
         oN+yd08vX1R8d+JdH0u+JQEZIRrrYWwVjrEjzufQmYYa908/wP9A5PLkL118tQjJGy01
         4fUg==
X-Gm-Message-State: AOJu0YysE31elFrZKpF15D1GlFOgV/3a03gHYLXPcA4pfhypWY558HHO
        ZC6JtnvvRk9e4XOvVatMHuWjQEs3lxSZLg==
X-Google-Smtp-Source: AGHT+IES7T71wFe8Fnb6ZyVWUarfI2u2DLVJx3gKv0MMJPKA8omsRtfquBXIL6RpkYQDOAx7VL1Teg==
X-Received: by 2002:a05:690c:2a41:b0:5a7:bff8:bdce with SMTP id ej1-20020a05690c2a4100b005a7bff8bdcemr7275645ywb.43.1697111273573;
        Thu, 12 Oct 2023 04:47:53 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id g68-20020a0df647000000b0059f766f9750sm5853553ywf.124.2023.10.12.04.47.53
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 04:47:53 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7d9d357faso11355717b3.0
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2023 04:47:53 -0700 (PDT)
X-Received: by 2002:a05:690c:2a41:b0:5a7:bff8:bdce with SMTP id
 ej1-20020a05690c2a4100b005a7bff8bdcemr7275629ywb.43.1697111272996; Thu, 12
 Oct 2023 04:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231012071800.468868-1-dlemoal@kernel.org>
In-Reply-To: <20231012071800.468868-1-dlemoal@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 13:47:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQAe-RMbhKdLWQp6BLfGqh2OF4+dd0s+nPJjJ27fUhdA@mail.gmail.com>
Message-ID: <CAMuHMdXQAe-RMbhKdLWQp6BLfGqh2OF4+dd0s+nPJjJ27fUhdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve drive spinup on resume
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Phillip Susi <phill@thesusis.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Damien,

On Thu, Oct 12, 2023 at 9:18 AM Damien Le Moal <dlemoal@kernel.org> wrote:
> Two patches to improve disk spinup on resume:
>  - Patch 1: Move the spinup operation to after the drive revalidation to
>    ensure that the VERIFY command is executed with the link speed
>    properly setup.
>  - Patch 2: Attempt to spinup the drive only if it is not already spun
>    up.

Thanks for your series!

> Geert,
>
> It would be great if you could test this with your RCAR setup. I ran
> this on my usual machines and qemu. All good. But your setup has been
> useful to flush out issues before :)

Nothing special to see here...
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
