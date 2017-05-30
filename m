From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/6] ata: bf54x: cut drvdata assignment
Date: Tue, 30 May 2017 15:22:03 +0300
Message-ID: <6a7144c2-7f38-455f-a605-0ea1f3b3e579@cogentembedded.com>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34738 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdE3MWI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 08:22:08 -0400
Received: by mail-lf0-f53.google.com with SMTP id 99so48069846lfu.1
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 05:22:07 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

Hello!

On 05/30/2017 12:46 PM, Linus Walleij wrote:

> ata_host_alloc_pinfo() assigns the host pointer to the
> struct device * drvdata, do not assign it a second time.

    It's actually driver_data, not drvdata.
    Personally, I now prefer expressing the *struct* fields the C++ way:
device::driver_data. :-)

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

MBR, Sergei

