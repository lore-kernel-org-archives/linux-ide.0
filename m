From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Wed, 24 Sep 2008 22:26:32 +0400
Message-ID: <48DA8658.2040107@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>	<48D57245.8060606@ru.mvista.com> <20080922.013256.128618380.anemo@mba.ocn.ne.jp> <48DA2543.4050304@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3837 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752789AbYIXSZf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Sep 2008 14:25:35 -0400
In-Reply-To: <48DA2543.4050304@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello, I  wrote:

>>>> +static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>>> +{
>>>> +    mm_tf_load(drive, task);
>>>> +    if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
>>>> +        ide_hwif_t *hwif = drive->hwif;
>>>> +        void __iomem *base = TX4939IDE_BASE(hwif);
>>>> +        /* Fix ATA100 CORE System Control Register */
>>>> +        tx4939ide_writew(tx4939ide_readw(base, TX4939IDE_Sys_Ctl) &
>>>> +                 0x07f0,
>>>> +                 base, TX4939IDE_Sys_Ctl);

>>>    Why? Doesn't page 17-4 of the datasheet say that these bits get 
>>> auto-cleared ona  write to the device/head register? Or is this to 
>>> address <CAUSION> on page 17-9?

>> Yes, that "CAUSION".  I will put it in the comment.

>   Frankly speaking, I couldn't make out much of tht passage:

> <CAUSION>
> The write to the register by the Device/Head register may cause an 
> unexpected function by write wrong
> data to the register. So please rewrite to the System Control register 
> after write to the Device/Head
> register to secure write to System Control register in ATA100 Core.

    I thought that this was related to loading the correct transfer mode for 
the selected drive. But if it's not only that, it would be quite pointless to 
also implement selectproc() method if you have to hook the tf_load() method...
    Frankly speaking, I don't understand why they didn't implement 2 timing 
registers like on TC86C001 while still implementing 2 transfer counter 
registers...

MBR, Sergei
