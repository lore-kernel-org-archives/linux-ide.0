From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ata: sata_gemini: Introduce explicit IDE pin control
Date: Fri, 11 Aug 2017 10:32:37 -0700
Message-ID: <20170811173236.GC3005423@devbig577.frc2.facebook.com>
References: <20170808190714.11623-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33021 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdHKRcl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2017 13:32:41 -0400
Received: by mail-qk0-f177.google.com with SMTP id a77so24055653qkb.0
        for <linux-ide@vger.kernel.org>; Fri, 11 Aug 2017 10:32:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170808190714.11623-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>

On Tue, Aug 08, 2017 at 09:07:14PM +0200, Linus Walleij wrote:
> The IDE pins are managed by the pin controller, if we want to
> use these, we need to ask the pin controller to explicitly enable
> them as by default, these pins are used for other business and
> most users just rely on the SATA bridge.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
