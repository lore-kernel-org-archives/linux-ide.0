From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] sata_rcar: fix error return code in sata_rcar_probe()
Date: Sat, 1 Jul 2017 00:09:43 +0300
Message-ID: <dbc9fcd5-e57a-780e-4618-d9c6a19d7433@cogentembedded.com>
References: <20170630210806.GA9391@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35158 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbdF3VJr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 17:09:47 -0400
Received: by mail-lf0-f47.google.com with SMTP id b207so76673974lfg.2
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 14:09:46 -0700 (PDT)
In-Reply-To: <20170630210806.GA9391@embeddedgus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/01/2017 12:08 AM, Gustavo A. R. Silva wrote:

> platform_get_irq() returns an error code, but the sata_rcar driver
> ignores it and always returns -EINVAL. This is not correct, and
> prevents -EPROBE_DEFER from being propagated properly. Also,
> notice that platform_get_irq() no longer returns 0 on error.
>
> Print error message and propagate the return value of platform_get_irq
> on failure.
>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

    You forgot to collect:

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

