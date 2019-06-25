Return-Path: <SRS0=oJiQ=UY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792A8C48BD5
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5943E20659
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 07:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFYHvr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:51:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34845 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYHvr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2019 03:51:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so16328267otq.2;
        Tue, 25 Jun 2019 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IT0of4vepRFiaiGL/kI6UhP5mB6tgUNxSEIofZdeFgI=;
        b=WdMUYh05/3Qh5vpPpuZeyum8b40DWyVz9zw04WY6Dzc6FcCkCQNj2Pu8ZiQAOK5J6e
         sOCTz7aoVAT8PoIucrsUKjmJZdIvH3Yzw6BURwlplLCGjR/LeRcT8sI1wyv5gl+jJSJB
         pgByWEPLIAq7oUjkN8dWQWlpHbpSvKZoFACWTFWeejZmRtPMjW3yCLD/fATFmV0At4Q5
         Lbl7cz2jB/gr/NgZ+TFZ+iwbHjl4ekX4FYsMP5msKG5Sq/qGzu65D2dvdGUZY9r7nIs0
         /kQ5EgzOHwtWcpn1Lahm4J8Dbva5Iu8Hxpkfs+mWgzwh7cogAc6IFI3moOX8BKe2gxrK
         UncQ==
X-Gm-Message-State: APjAAAXCtTNBrWLjnb5OAz/z2Q7DkeQqLCH2GCnHUugPrkl1Sv0/43cP
        KtyBPifnfekGBkUsOKQNmuEWg1TvSkIBVfmq5AU=
X-Google-Smtp-Source: APXvYqzGjLokw+kSG0wcw8HTxf3KfotHJR7Q1i0jXppM8SWF6ZPgbC6K6WcY8N0qdz0eSiDKO6NF9McCuADOhuD1AgE=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr34930471otc.250.1561449106654;
 Tue, 25 Jun 2019 00:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
 <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jun 2019 09:51:35 +0200
Message-ID: <CAMuHMdWMb2MFRN6ug3Jt3MROAs0nhYYC_RDexu876n9PBRZOiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k/atari: add platform device for Falcon IDE port
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Michael,

On Thu, Jun 20, 2019 at 10:47 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Autoloading of Falcon IDE driver modules requires converting
> these drivers to platform drivers.
>
> Add platform device for Falcon IDE interface in Atari platform
> setup code in preparation for this.
>
> Add Falcon IDE base address in Atari hardware address header.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/atari/config.c
> +++ b/arch/m68k/atari/config.c
> @@ -896,6 +896,21 @@ static void isp1160_delay(struct device *dev, int delay)
>  };
>  #endif
>
> +#if IS_ENABLED(CONFIG_PATA_FALCON)

I wouldn't bother making this depend on a config symbol, as it is
builtin hardware (EtherNEC/NAT isn't), and prevents compiling a module
later.
arch/m68k/amiga/platform.c has everything unconditional.
I know there's such a dependency for SCSI, perhaps it should be removed?

> +static const struct resource atari_falconide_rsrc[] __initconst = {
> +       {
> +               .flags = IORESOURCE_MEM,
> +               .start = FALCON_IDE_BASE,
> +               .end   = FALCON_IDE_BASE+0x40,
> +       },
> +       {
> +               .flags = IORESOURCE_IRQ,
> +               .start = IRQ_MFP_FSCSI,
> +               .end   = IRQ_MFP_FSCSI,
> +       },
> +};
> +#endif
> +
>  int __init atari_platform_init(void)
>  {
>         int rv = 0;
> @@ -939,6 +954,11 @@ int __init atari_platform_init(void)
>                         atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
>  #endif
>
> +#if IS_ENABLED(CONFIG_PATA_FALCON)
> +       if (ATARIHW_PRESENT(IDE))
> +               platform_device_register_simple("pata_falcon", -1,
> +                       atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
> +#endif
>         return rv;
>  }
>
> diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
> index 5330082..4bea923 100644
> --- a/arch/m68k/include/asm/atarihw.h
> +++ b/arch/m68k/include/asm/atarihw.h
> @@ -813,6 +813,12 @@ struct MSTE_RTC {
>  #define mste_rtc ((*(volatile struct MSTE_RTC *)MSTE_RTC_BAS))
>
>  /*
> +** Falcon IDE interface
> +*/
> +
> +#define FALCON_IDE_BASE        0xfff00000

Is it worth having this as a #define in a global header file?
You still need a hardcoded region size in config.c.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
