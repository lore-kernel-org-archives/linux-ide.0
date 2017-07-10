From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix gemini Kconfig dependencies
Date: Mon, 10 Jul 2017 13:43:22 -0400
Message-ID: <20170710174321.GC1305447@devbig577.frc2.facebook.com>
References: <20170710085120.1984293-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36610 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754632AbdGJRn0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jul 2017 13:43:26 -0400
Content-Disposition: inline
In-Reply-To: <20170710085120.1984293-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 10, 2017 at 10:51:02AM +0200, Arnd Bergmann wrote:
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

Applied to libata/for-4.13-fixes.

Thanks.

-- 
tejun
