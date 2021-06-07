Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2264DC47082
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6760233
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGIkQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:40:16 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:42669 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGIkP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:40:15 -0400
Received: by mail-vs1-f44.google.com with SMTP id l25so8457605vsb.9;
        Mon, 07 Jun 2021 01:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYObgoUDn1dZfzXvNOLi4ACAcC+zbDXmQL5SVeQ1ZdI=;
        b=lvdceScZfrZ1AyCEHILpAnz2jrBmTEOWu8nEo+SObSNMm9jJSQCsbPeDIAhF/XHdJE
         5s4c2i6B12WxXzpHsCO4DRtXeEOCmUQSnQWm3Ym/RbN3lSd3L3/lmk1YqS4NKGQiH77l
         wWre5q6Ek1FAhODw6UFNQgjwrSvfe6WU3JQATI2A4pwZI1pI1djC554xubhDcg840jtK
         AqM5uOS7Dv/bvy94FF8VSE8JM21h/Lr5uLKXIxvElLQMleWzOINtBxhfqnanv0MtA515
         Whv+WS0U6QDMeRjvixQYgbf/Al+tW5yH1lM0HqCDkIzGfaXMug38v5L4jbdtKpStxztY
         r1NA==
X-Gm-Message-State: AOAM530EhVdFHpWAKpNIX/O9LwDhjzcC8JoXssPQ4Yh4FhvVXvfSf1Xh
        55hqKnNf5YdbWP72QwTYCy/qi8Mq5Qc6q2UKQZg=
X-Google-Smtp-Source: ABdhPJxjksG4tSgH7kBrptHVDZYgoOaK/J8ZM0GPBueKVXw5fG+cxqxXBTyZQs/w3tEY/PBOUsI8fQ5fuZ2OwaOuCDc=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr7945226vsp.3.1623055090060;
 Mon, 07 Jun 2021 01:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 10:37:58 +0200
Message-ID: <CAMuHMdVCQHm2SX1XzphZ_cq6YtcjuudqG9SZUSTi+f80L=d9YQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] net/8390: apne.c - add 100 Mbit support to apne.c driver
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
        ALeX Kazik <alex@kazik.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Sun, Jun 6, 2021 at 7:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Add Kconfig option, module parameter and PCMCIA reset code
> required to support 100 Mbit PCMCIA ethernet cards on Amiga.
>
> 10 Mbit and 100 Mbit mode are supported by the same module.
> A module parameter switches Amiga ISA IO accessors to word
> access by changing isa_type at runtime. Additional code to
> reset the PCMCIA hardware is also added to the driver probe.
>
> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
> Kazik <alex@kazik.de>.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/drivers/net/ethernet/8390/Kconfig
> +++ b/drivers/net/ethernet/8390/Kconfig
> @@ -143,6 +143,19 @@ config APNE
>           To compile this driver as a module, choose M here: the module
>           will be called apne.
>
> +if APNE
> +config APNE100MBIT
> +       bool "PCMCIA NE2000 100MBit support"
> +       default n
> +       ---help---

"help" (support for "---help---" was removed in v5.9).

> +         This changes the driver to support 10/100Mbit cards (e.g. Netgear
> +         FA411, CNet Singlepoint). 10 MBit cards and 100 MBit cards are
> +         supported by the same driver.
> +
> +         To activate 100 Mbit support at runtime, use the apne100 module
> +         parameter.
> +endif
> +
>  config PCMCIA_PCNET
>         tristate "NE2000 compatible PCMCIA support"
>         depends on PCMCIA

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
