Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226AC433ED
	for <linux-ide@archiver.kernel.org>; Wed, 19 May 2021 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30266108D
	for <linux-ide@archiver.kernel.org>; Wed, 19 May 2021 07:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbhESHfR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 May 2021 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbhESHfQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2021 03:35:16 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1AC06175F
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2021 00:33:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by baptiste.telenet-ops.be with bizsmtp
        id 6XZu2500L446CkP01XZuzm; Wed, 19 May 2021 09:33:55 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ljGiI-0074WD-Cy; Wed, 19 May 2021 09:33:54 +0200
Date:   Wed, 19 May 2021 09:33:54 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] sata_highbank: fix deferred probing
In-Reply-To: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
Message-ID: <alpine.DEB.2.22.394.2105190930300.1685435@ramsan.of.borg>
References: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

 	Hi Sergei,

On Sun, 14 Mar 2021, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver would fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error code upstream, still checking/overriding IRQ0 as libata regards it
> as "no IRQ" (thus polling) anyway...
>
> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

Thanks for your patch, which is now commit 4a24efa16e7db023
("sata_highbank: fix deferred probing") in block/for-next.

> --- linux-block.orig/drivers/ata/sata_highbank.c
> +++ linux-block/drivers/ata/sata_highbank.c
> @@ -469,10 +469,12 @@ static int ahci_highbank_probe(struct pl
> 	}
>
> 	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> +	if (irq < 0) {
> 		dev_err(dev, "no irq\n");

This message should not be printed in case of -EPROBE_DEFER...

> -		return -EINVAL;
> +		return irq;

... hence

     return dev_err_probe(dev, irq, "no irq\n");

Same for pata_rb532_cf.

> 	}
> +	if (!irq)
> +		return -EINVAL;
>
> 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> 	if (!hpriv) {
>
Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
