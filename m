From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] ata: Add DT bindings for the Gemini SATA bridge
Date: Mon, 8 May 2017 22:33:15 +0200
Message-ID: <CACRpkdYz9Oka0SGJDTr=y4EN-VfggbuKY2s5X43oXg1dgjh1nw@mail.gmail.com>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
 <20170506121053.11554-2-linus.walleij@linaro.org> <3791456.ZibJefW5cI@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35405 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbdEHUdR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2017 16:33:17 -0400
Received: by mail-io0-f177.google.com with SMTP id f102so57481875ioi.2
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2017 13:33:17 -0700 (PDT)
In-Reply-To: <3791456.ZibJefW5cI@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, openwrt-devel@openwrt.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

On Mon, May 8, 2017 at 12:49 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Saturday, May 06, 2017 02:10:51 PM Linus Walleij wrote:

>> +  Mode 3: ata0 master <-> sata0
>> +          ata1 slave  <-> sata1
>
> ata0 slave?
>
>> +          ata1 master and slave interfaces brought out
>> +               on IDE pads

Of course. Thanks for reading close, much appreciated!

Yours,
Linus Walleij
