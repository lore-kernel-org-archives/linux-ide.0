From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] m68k/atari - ide: do not register interrupt if
 host->get_lock is set
Date: Tue, 04 Mar 2014 15:59:06 -0500 (EST)
Message-ID: <20140304.155906.221185723445733090.davem@davemloft.net>
References: <1391215693-2880-1-git-send-email-schmitz@debian.org>
	<1391215693-2880-2-git-send-email-schmitz@debian.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1391215693-2880-2-git-send-email-schmitz@debian.org>
Sender: linux-m68k-owner@vger.kernel.org
To: schmitzmic@gmail.com
Cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org, linux-ide@vger.kernel.org, schmitz@debian.org
List-Id: linux-ide@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sat,  1 Feb 2014 13:48:13 +1300

> On m68k, host->get_lock is used to both lock and register the interrupt
> that the IDE host shares with other device drivers. Registering the
> IDE interrupt handler in ide-probe.c results in duplicating the
> interrupt registered (once via host->get lock, and also via init_irq()),
> and may result in IDE accepting interrupts even when another driver has
> locked the interrupt hardware. This opens the whole locking scheme up
> to races.
> 
> host->get_lock is set on m68k only, so other drivers' behaviour is not
> changed.
> 
> Signed-off-by: Michael Schmitz <schmitz@debian.org>

It's a bit kludgy, but minimal and correct.

Applied, thank you.
