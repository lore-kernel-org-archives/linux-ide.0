From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Wed, 28 Nov 2007 10:55:14 +0900
Message-ID: <474CCA82.7030000@gmail.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com> <20071120220512.46b9e975@the-village.bc.nu> <20071126120649.GC4701@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:25360 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131AbXK1Bza (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:55:30 -0500
Received: by nz-out-0506.google.com with SMTP id s18so928768nze
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:55:29 -0800 (PST)
In-Reply-To: <20071126120649.GC4701@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>>  kernel: [734344.717844] irq 21: nobody cared (try booting with the
>>> "irqpoll" option)
>>>  kernel: [734344.717866]
>> Your machine decided to emit interrupt 21 without an apparent reason.
>> Whatever caused that made the kernel shut down IRQ 21 at which point the
>> disk drives on that IRQ were no longer being serviced. Everything on IRQ
>> 21 would have died - which may be why your networking failed too.
> 
> Hmm, perhaps that 'nobody cared' message should be worded more
> strongly, and printed and KERN_CRIT?

Agreed.  Nobody cared on ATA controllers is usually very effective at
taking the whole machine down.  Is there any reason why we don't turn on
irqpoll on turned off IRQs automatically?

Thanks.

-- 
tejun
