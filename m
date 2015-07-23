From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
Date: Thu, 23 Jul 2015 15:03:36 +0200
Message-ID: <CACRpkdYqwOymyK31rwhe7EQnSxLFrcy3PTBvCsyK1TR+J7=EQg@mail.gmail.com>
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34167 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbbGWNDh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2015 09:03:37 -0400
Received: by obre1 with SMTP id e1so153579895obr.1
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2015 06:03:36 -0700 (PDT)
In-Reply-To: <1437586416-14735-1-git-send-email-albeu@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alban Bedel <albeu@free.fr>
Cc: Linux MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Fainelli <florian@openwrt.org>, Joe Perches <joe@perches.com>, Daniel Walter <dwalter@google.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Huacai Chen <chenhc@lemote.com>, Andrew Bresticker <abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Waldemar Brodkorb <wbx@openadk.org>, James Hogan <james.hogan@imgtec.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Levente Kurusa <levex@linux.com>, abdoulaye berthe <berthe.ab@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger

On Wed, Jul 22, 2015 at 7:33 PM, Alban Bedel <albeu@free.fr> wrote:

> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However only
> the Alchemy machine really use the feature, all other machines only
> use the default wrappers.
>
> For most machine types we can just remove the custom gpio.h, as well
> as the custom wrappers if some exists. A few more fixes are need in
> a few drivers as they rely on linux/gpio.h to provides some machine
> specific definitions, or used asm/gpio.h instead of linux/gpio.h for
> the gpio API.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

This is exactly what the kernel needs. Enjoy my:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

And feel free to merge this through the MIPS tree.

Yours,
Linus Walleij
