From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ata: ftide010: fix resource printing
Date: Mon, 26 Jun 2017 00:07:11 +0200
Message-ID: <CACRpkdajE=hF-X+jh=qMe6Vc8AHPUz3=jpAFknKb_8=PQu9QQw@mail.gmail.com>
References: <20170621220115.4100076-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38271 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdFYWHN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2017 18:07:13 -0400
Received: by mail-it0-f42.google.com with SMTP id b205so30944021itg.1
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2017 15:07:13 -0700 (PDT)
In-Reply-To: <20170621220115.4100076-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 22, 2017 at 12:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> The new driver uses an incorrect format string for resource_size_t:
>
> drivers/ata/pata_ftide010.c: In function 'pata_ftide010_probe':
> drivers/ata/pata_ftide010.c:520:17: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
>
> The nicest way to print the address is to pretty-print the resource
> using %pR.
>
> Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
