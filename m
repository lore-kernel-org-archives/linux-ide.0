From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] m68k/atari - ide: do not register interrupt if
 host->get_lock is set
Date: Thu, 06 Mar 2014 12:50:13 -0500 (EST)
Message-ID: <20140306.125013.1101350119515453300.davem@davemloft.net>
References: <1391215693-2880-2-git-send-email-schmitz@debian.org>
	<20140304.155906.221185723445733090.davem@davemloft.net>
	<540db7ba6339cc907a63fb7a615aaa7e@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <540db7ba6339cc907a63fb7a615aaa7e@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: schmitzmic@gmail.com
Cc: linux-m68k@vger.kernel.org, schmitz@debian.org, linux-ide@vger.kernel.org, geert@linux-m68k.org
List-Id: linux-ide@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>
Date: Thu, 6 Mar 2014 19:47:06 +1300

> Thanks Dave,
> 
>>> On m68k, host->get_lock is used to both lock and register the
>>> interrupt
>>> that the IDE host shares with other device drivers. Registering the
>>> IDE interrupt handler in ide-probe.c results in duplicating the
>>> interrupt registered (once via host->get lock, and also via
>>> init_irq()),
>>> and may result in IDE accepting interrupts even when another driver
>>> has
>>> locked the interrupt hardware. This opens the whole locking scheme up
>>> to races.
>>>
>>> host->get_lock is set on m68k only, so other drivers' behaviour is not
>>> changed.
>>>
>>> Signed-off-by: Michael Schmitz <schmitz@debian.org>
>>
>> It's a bit kludgy, but minimal and correct.
> 
> Would you have preferred to use a host flag instead?

I looked into that, we are out of host flags.  We'd either need to expand
the flags value to 64-bits or add another u32.

That's overkill for this.
