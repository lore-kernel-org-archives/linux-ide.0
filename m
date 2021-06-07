Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3AC4743F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 11:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5E961205
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 11:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhFGLRV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:17:21 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:38586 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFGLRV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 07:17:21 -0400
Received: by mail-ua1-f45.google.com with SMTP id d13so8775435uav.5;
        Mon, 07 Jun 2021 04:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wgp/tBpjeqf6O2lPslH9bnakWrDSZCGb8Fz8Hl4UvnQ=;
        b=rd7fZ/Vc5Tsay7oyC4m89l5lqP08dgiz09ZdO4zJ6HMYgmJvuH6hXsxDYXBwB1yXeW
         CcD/yq1hOEV4NKwk6DahbTpdihR9ASHQYzV5yHoDY0SUm3RLdOBtnM+XO/TXKPdAFnBk
         m3bloOuU8x2w6GPMs24zEK2Ai8wHNSekm2HxRx+YRbc7nbDmrmjIhIcYwyBH51aOnd5r
         NbDRexnwa/1j30Pjx6f8cHI/529WMBCtisWiMUFV4M2d3o7/wAj7SNh/aXuu4p6yH9NQ
         bioNtg39fLmaasgjhN84GWLAk9GAyX/EtAHhO3BKwgIeJhMici0RcueLDUa81deR2RDZ
         gyDQ==
X-Gm-Message-State: AOAM530rsROBqmATWwAcFhc6rjkMGUPzKZZn4szat8iJabkNIzGj5cDw
        vV8QJvBSFUy2pZOwql/49mvb+Zyn38ZV2MSMMqM=
X-Google-Smtp-Source: ABdhPJwXLFVczFNkh7qoopILS7Zq6IMI4+2N7i/u5ETu9RMK0fDl0OmoiIgsh/Y9sOA5u809zy+ptyPJmCdH9bcLgXE=
X-Received: by 2002:a1f:d8c3:: with SMTP id p186mr7553368vkg.1.1623064529977;
 Mon, 07 Jun 2021 04:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 13:15:18 +0200
Message-ID: <CAMuHMdX1cD_zt6hU-6CUZi=uyYdk_xgW+hTCXvxSTRFPy_qn5w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
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
> Add code to support 10 Mbit and 100 Mbit mode for APNE driver.
>
> A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
> to word access as required by the 100 Mbit cards.
>
> Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
> 100 MBit card support" submitted to netdev 2018/09/16 by Alex
> Kazik <alex@kazik.de>.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/arch/m68k/include/asm/io_mm.h
> +++ b/arch/m68k/include/asm/io_mm.h
> @@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
>  }
>
>
> -#define isa_inb(port)      in_8(isa_itb(port))
>  #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
>  #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
>  #define isa_outb(val,port) out_8(isa_itb(port),(val))
>  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
>  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
>
> +/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
> + * dead code if MULTI_ISA is not set */
> +#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))

This fails to compile due to a missing closing parenthesis.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
