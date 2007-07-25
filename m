From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
Date: Wed, 25 Jul 2007 23:35:00 +0400
Message-ID: <46A7A5E4.4090105@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com> <46A7A17C.8090505@ru.mvista.com> <46A7A1D5.7020003@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936030AbXGYTd1@vger.kernel.org>
In-Reply-To: <46A7A1D5.7020003@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Scott Wood wrote:

>>> It doesn't buy us anything in here, but it's conceivable that someone 
>>> may want to write a driver that uses a shift in the I/O accessor 
>>> rather than an array of port offsets,

>>    It wouldn't be IDE driver then, and neither it would be libata 
>> which also does this another way this (despite pata_platform uses 
>> shifts too -- not in the accessors, so no speed loss).

> The device tree is not just for Linux.

    Yeah, and I can't wait to see some other its users. ;-)
    This doesn't mean that shift is better anyway. If everyone considers it 
better, I give up. But be warned that shift (stride) is not the only property 
characterizing register accesses -- the regs might be only accessible as 
16/32-bit quantities, for example (16-bit is a real world example -- from 
Amiga or smth of that sort, IIRC).

>>> equivalent of the cntlzw innstruction, and shift makes it clear that 
>>> the stride must be power-of-two).  Plus, using shift is consistent 
>>> with what we do on ns16550.

>>    Why the heck should we care about the UART code taling about IDE?!

> Consistency?

    We're not obliged to be consistent with every piece of the kernel code.

> -Scott

MBR, Sergei
