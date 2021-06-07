Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F43C4743F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D71A611C1
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGIKR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:10:17 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:43625 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhFGIKQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:10:16 -0400
Received: by mail-ua1-f49.google.com with SMTP id f1so9200764uaj.10;
        Mon, 07 Jun 2021 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0otvC9vBCaWqRl10UjwrttIZk28ULHx2ny5v+oqabM=;
        b=a3ng/OucQhZqrSVESYxW4+qhcJd+w7t7/j/BzZf1+sDrVBrgPJYJ4nbqehX311vf1R
         /xO3Lq/A60tyVZebcTzhQHw3fu37dfJg1R5VK+KIYHhzMi3k4NX+ES65revarqfySOM0
         HKBT+2HtsITs9SHO2Pc+RZnOuqsj8RXw+VH/IkgH030B2opUx57jtiAOTlHcSEcPeNp2
         F7MoMYAYlrS7a+9iB59UzUtW203b8K75W0rtonHedHNpqXdpI+64o9Wx/fQp0QWv21jq
         GkUH83QvAJIIhU8xhm6Li41Wd5CP+t0GB9a3mQdOxLtqGbMHzASVl8HbVT36VcjcKqKU
         EV+A==
X-Gm-Message-State: AOAM531b0A5YFxpAuAmn39+W1o8LJPSOR8gupNV2aDbLJIanDiJ2DZkr
        zw/x8vjFHLttIgdIYWHbNthibT2Rd0k7eS/A/SU=
X-Google-Smtp-Source: ABdhPJwXhYAB7Wg+6QCASblFhqBdxUvDH651311hvhr/y23Jb8zqhaqKzxw+3dY317XZxYGwKbuu9VABxEABlt3L4vo=
X-Received: by 2002:ab0:708c:: with SMTP id m12mr9165088ual.4.1623053305142;
 Mon, 07 Jun 2021 01:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210605060447.GA18461@allandria.com> <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1622958877-2026-3-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 10:08:14 +0200
Message-ID: <CAMuHMdXEs874y3nBjVNt8TQP-AMLTRMFgh+1wMt2xyJP3W_+Dg@mail.gmail.com>
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

Thanks for your patch!

> --- a/drivers/net/ethernet/8390/Kconfig
> +++ b/drivers/net/ethernet/8390/Kconfig
> @@ -143,6 +143,19 @@ config APNE
>           To compile this driver as a module, choose M here: the module
>           will be called apne.
>
> +if APNE

Please use "depends on APNE" instead of an if/endif block, as there's
only a single symbol to cover.

> +config APNE100MBIT
> +       bool "PCMCIA NE2000 100MBit support"
> +       default n
> +       ---help---
> +         This changes the driver to support 10/100Mbit cards (e.g. Netgear
> +         FA411, CNet Singlepoint). 10 MBit cards and 100 MBit cards are
> +         supported by the same driver.
> +
> +         To activate 100 Mbit support at runtime, use the apne100 module
> +         parameter.

Trailing space.

> +endif
> +
>  config PCMCIA_PCNET
>         tristate "NE2000 compatible PCMCIA support"
>         depends on PCMCIA
> diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
> index fe6c834..9648e45 100644
> --- a/drivers/net/ethernet/8390/apne.c
> +++ b/drivers/net/ethernet/8390/apne.c
> @@ -120,6 +120,10 @@ static u32 apne_msg_enable;
>  module_param_named(msg_enable, apne_msg_enable, uint, 0444);
>  MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
>
> +static u32 apne_100_mbit;
> +module_param_named(apne_100_mbit, uint, 0);
> +MODULE_PARM_DESC(apne_100_mbit, "Enable 100 Mbit support");

Shouldn't this depend on CONFIG_APNE100MBIT, too?
Perhaps we shouldn't bother with the config symbol, and include this
unconditionally?

> +
>  struct net_device * __init apne_probe(int unit)
>  {
>         struct net_device *dev;
> @@ -139,6 +143,9 @@ struct net_device * __init apne_probe(int unit)
>         if ( !(AMIGAHW_PRESENT(PCMCIA)) )
>                 return ERR_PTR(-ENODEV);
>
> +        if (apne_100_mbit)
> +                isa_type = ISA_TYPE_AG100;

Likewise.

Can we enable this automatically when needed, based on the chip
detected?

+ spaces instead of TABs (scripts/checkpatch.pl is your friend).

> +
>         pr_info("Looking for PCMCIA ethernet card : ");
>
>         /* check if a card is inserted */
> @@ -590,6 +597,16 @@ static int init_pcmcia(void)
>  #endif
>         u_long offset;
>
> +#ifdef CONFIG_APNE100MBIT
> +       /* reset card (idea taken from CardReset by Artur Pogoda) */
> +       {
> +               u_char  tmp = gayle.intreq;
> +
> +               gayle.intreq = 0xff;    mdelay(1);
> +               gayle.intreq = tmp;     mdelay(300);
> +       }

Is this safe for all cards?

> +#endif
> +
>         pcmcia_reset();
>         pcmcia_program_voltage(PCMCIA_0V);
>         pcmcia_access_speed(PCMCIA_SPEED_250NS);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
