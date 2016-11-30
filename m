From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 16:15:42 +0300
Message-ID: <14064826-71c3-4e1e-be0a-787a7e8fbf68@cogentembedded.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35374 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcK3NPt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 08:15:49 -0500
Received: by mail-lf0-f44.google.com with SMTP id b14so146265244lfg.2
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 05:15:49 -0800 (PST)
In-Reply-To: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Whitehead <tedheadster@gmail.com>, linux-ide@vger.kernel.org

On 11/29/2016 08:53 PM, Matthew Whitehead wrote:

> If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
> common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
> and also their associated interrupts (14,15,11,10,8,12).
>
> Unfortunately, on such systems those interrupt lines are at a premium because there is no
> PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
> a list of ports to skip allocating.
>
> modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160
>
> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>

    Also scripts/checkpatch.pl would complain about too long lines if you 
would have run the patch thru it.

MBR, Sergei

