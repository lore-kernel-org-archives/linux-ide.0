From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 12:42:38 +0300
Message-ID: <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
References: <20170630052210.GA19186@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36689 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdF3Jml (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 05:42:41 -0400
Received: by mail-lf0-f41.google.com with SMTP id h22so67024375lfk.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 02:42:40 -0700 (PDT)
In-Reply-To: <20170630052210.GA19186@embeddedgus>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

On 6/30/2017 8:22 AM, Gustavo A. R. Silva wrote:

> Print error message and propagate the return value of
> platform_get_irq on failure.

    You should have probably mentioned that this function no longer returns 0 
on error.

> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
