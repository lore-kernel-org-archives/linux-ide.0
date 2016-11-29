From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Tue, 29 Nov 2016 15:12:31 -0500
Message-ID: <CAP8WD_ZxS0TMzHB+=3Gohw39+S2hQbm-pucuYPYK6JUhFWVd5A@mail.gmail.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com> <20161129194158.GB4959@htj.duckdns.org>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36780 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbcK2UMw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 15:12:52 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so13151456ywb.3
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 12:12:52 -0800 (PST)
In-Reply-To: <20161129194158.GB4959@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello Tejun,

On Tue, Nov 29, 2016 at 2:41 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Matthew.
>
> (cc'ing Bartlomiej)
>
> On Tue, Nov 29, 2016 at 12:53:02PM -0500, Matthew Whitehead wrote:
>> If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
>> common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
>> and also their associated interrupts (14,15,11,10,8,12).
>>
>> Unfortunately, on such systems those interrupt lines are at a premium because there is no
>> PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
>> a list of ports to skip allocating.
>>
>> modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160

>
> Can you please give a concrete example of a machine and situation
> where this would be useful?
>


Sure, my regression testing i486 system has this problem. It only has
an EISA bus, no PCI. I had to apply the patch to be able to put even
2-3 cards in it. It had run out of IRQs.

This testing helped uncover a long time kernel bug that now has a patch.

http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=fc0e81b2bea0ebceb71889b61d2240856141c9ee

Please check the linux-kernel mailing list thread "What exactly do
32-bit x86 exceptions push on the stack in the CS slot?" for more
details.

https://lkml.org/lkml/2016/11/19/308

- Matthew
