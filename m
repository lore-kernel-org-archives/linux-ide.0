From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Tue, 29 Nov 2016 14:41:58 -0500
Message-ID: <20161129194158.GB4959@htj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33145 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbcK2TmF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 14:42:05 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so13060576ywg.0
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 11:42:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Whitehead <tedheadster@gmail.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello, Matthew.

(cc'ing Bartlomiej)

On Tue, Nov 29, 2016 at 12:53:02PM -0500, Matthew Whitehead wrote:
> If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
> common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
> and also their associated interrupts (14,15,11,10,8,12).
> 
> Unfortunately, on such systems those interrupt lines are at a premium because there is no
> PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
> a list of ports to skip allocating.
> 
> modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160

Can you please give a concrete example of a machine and situation
where this would be useful?

Thanks.

-- 
tejun
