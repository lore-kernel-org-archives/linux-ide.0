From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ata: fix gemini Kconfig dependencies
Date: Tue, 11 Jul 2017 16:29:19 +0200
Message-ID: <CACRpkdb4b6WDtHeA7AwtopwH29cCx3c_ae7eUUBF3Zh57nyQNA@mail.gmail.com>
References: <20170710085120.1984293-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:35152 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932653AbdGKO3V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2017 10:29:21 -0400
Received: by mail-it0-f52.google.com with SMTP id v202so64825466itb.0
        for <linux-ide@vger.kernel.org>; Tue, 11 Jul 2017 07:29:21 -0700 (PDT)
In-Reply-To: <20170710085120.1984293-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jul 10, 2017 at 10:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> We cannot build the new ftide010 code without also building the faraday
> sata bridge driver:
>
> drivers/ata/pata_ftide010.o: In function `pata_ftide010_probe':
> pata_ftide010.c:(.text+0x2b8): undefined reference to `gemini_sata_bridge_get'
> pata_ftide010.c:(.text+0x32c): undefined reference to `gemini_sata_get_muxmode'
> pata_ftide010.c:(.text+0x358): undefined reference to `gemini_sata_bridge_enabled'
> drivers/ata/pata_ftide010.o: In function `pata_ftide010_gemini_port_stop':
> pata_ftide010.c:(.text+0x520): undefined reference to `gemini_sata_stop_bridge'
> drivers/ata/pata_ftide010.o: In function `pata_ftide010_gemini_port_start':
> pata_ftide010.c:(.text+0x5bc): undefined reference to `gemini_sata_start_bridge'
>
> This adjusts the Kconfig dependencies accordingly.
>
> Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

My intention was definately to have the bridge driver as a separate add-on
as I suspect some systems use the PATA driver without the SATA bridge.

But we can definately deal with that when those users appear.

Yours,
Linus Walleij
