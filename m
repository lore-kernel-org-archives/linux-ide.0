Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDAC7EE23
	for <linux-ide@archiver.kernel.org>; Fri,  2 Jun 2023 01:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjFBByq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Jun 2023 21:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFBByp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2023 21:54:45 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6F9D3
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 18:54:43 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 7011f348-00e8-11ee-b3cf-005056bd6ce9;
        Fri, 02 Jun 2023 04:54:41 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 04:54:40 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 26/43] pata: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZHlL4FJnrLjTCXGd@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-8-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-8-nikita.shubin@maquefel.me>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thu, Jun 01, 2023 at 08:45:31AM +0300, Nikita Shubin kirjoitti:
> - find register range from the device tree
> - get interrupts from device tree

...

>  #include <linux/ata.h>
>  #include <linux/libata.h>
>  #include <linux/platform_device.h>

> +#include <linux/mod_devicetable.h>

In all patches, can you try to put a new header inclusions to be ordered (to
some extent)?

>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/ktime.h>

With the context above a new one is logically suits this location.

-- 
With Best Regards,
Andy Shevchenko


