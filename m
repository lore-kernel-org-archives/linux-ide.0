From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] ata: sata_gemini: Retire custom pin control
Date: Fri, 11 Aug 2017 10:32:58 -0700
Message-ID: <20170811173257.GD3005423@devbig577.frc2.facebook.com>
References: <20170808190704.11574-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33142 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdHKRdC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2017 13:33:02 -0400
Received: by mail-qk0-f175.google.com with SMTP id a77so24061162qkb.0
        for <linux-ide@vger.kernel.org>; Fri, 11 Aug 2017 10:33:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170808190704.11574-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>

On Tue, Aug 08, 2017 at 09:07:04PM +0200, Linus Walleij wrote:
> I added a proper pin control driver for the Gemini SoC, so retire
> this custom code and rely on the pin controller to set up the pads.
> 
> The "IOMUX" which is routing signals between the ATA and SATA
> bridge inside of the chip is not about pin control and remains in
> place.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
