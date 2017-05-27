From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ide: avoid warning for timings calculation
Date: Sat, 27 May 2017 23:22:55 +0300
Message-ID: <CAHp75VdWrBDN-Pb_WOLjim6ZhyN6dxwEzi_ekBNbzQ-tJuAeoQ@mail.gmail.com>
References: <20170511125214.278638-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35598 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdE0UW5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2017 16:22:57 -0400
In-Reply-To: <20170511125214.278638-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, May 11, 2017 at 3:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc-7 warns about the result of a constant multiplication used as
> a boolean:
>
> drivers/ide/ide-timings.c: In function 'ide_timing_quantize':
> drivers/ide/ide-timings.c:112:24: error: '*' in boolean context, suggest '&&' instead [-Werror=int-in-bool-context]
>   q->setup   = EZ(t->setup   * 1000,  T);
>
> This slightly rearranges the macro to simplify the code and avoid
> the warning at the same time.

>  #define ENOUGH(v, unit)                (((v) - 1) / (unit) + 1)
> -#define EZ(v, unit)            ((v) ? ENOUGH(v, unit) : 0)
> +#define EZ(v, unit)            ((v) ? ENOUGH(v * 1000, unit) : 0)

Perhaps
v -> (v) in the multiplication.

-- 
With Best Regards,
Andy Shevchenko
