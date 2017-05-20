From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4 v2] ARM: dts: add Gemini PATA/SATA support
Date: Sat, 20 May 2017 10:27:41 +0200
Message-ID: <CACRpkdbubStWj+K0eORLXRfZCWAVHs4aC5yDaUzPCPkWLcenoA@mail.gmail.com>
References: <20170519230600.16782-1-linus.walleij@linaro.org> <20170519230600.16782-4-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35004 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdETI1n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 May 2017 04:27:43 -0400
Received: by mail-io0-f181.google.com with SMTP id f102so58649989ioi.2
        for <linux-ide@vger.kernel.org>; Sat, 20 May 2017 01:27:43 -0700 (PDT)
In-Reply-To: <20170519230600.16782-4-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

On Sat, May 20, 2017 at 1:06 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The NAS4229B and SQ201 Gemini systems have a PATA controller
> which is linked to a SATA bridge in the SoC. Enable both
> platforms to use the PATA/SATA devices.
>
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Cut the timings

(...)

> +               ata@63400000 {
(...)
> +                       /* PIO timings assume 33 MHz bus speed */
> +                       faraday,pio-active-time = <10>, <10>, <10>, <3>, <3>;
> +                       faraday,pio-recovery-time = <10>, <3>, <1>, <3>, <1>;
(...)

OK I forgot to cut the timings on the second instance, sorry.
I have removed them now so they are not there when I send this
to the ARM SoC tree.

Yours,
Linus Walleij
