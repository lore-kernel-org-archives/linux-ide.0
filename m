From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4 v2] ata: Add driver for Faraday Technology FTIDE010
Date: Tue, 30 May 2017 13:28:15 +0200
Message-ID: <CACRpkdb39jqr=+Cs852y93cHRkPih8eMT=jvK3D+5bJnH36HNQ@mail.gmail.com>
References: <20170519230600.16782-1-linus.walleij@linaro.org>
 <20170519230600.16782-3-linus.walleij@linaro.org> <20170523212556.GK13222@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38390 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3L2R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 07:28:17 -0400
Received: by mail-it0-f50.google.com with SMTP id r63so39551306itc.1
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 04:28:17 -0700 (PDT)
In-Reply-To: <20170523212556.GK13222@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

On Tue, May 23, 2017 at 11:25 PM, Tejun Heo <tj@kernel.org> wrote:

> Heh, that's a lot of driver.  Looks okay to me but, Bart, can you
> please review and ack this one?

I will send a very lightly modified v3, fixing the issue I was seeing
with the drvdata.

Yours,
Linus Walleij
