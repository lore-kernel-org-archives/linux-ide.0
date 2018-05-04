From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] ide: don't enable/disable interrupts in force
 threaded-IRQ mode
Date: Fri, 04 May 2018 13:39:17 -0400 (EDT)
Message-ID: <20180504.133917.166242157820470842.davem@davemloft.net>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-5-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-5-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:46 +0200

> The interrupts are enabled/disabled so the interrupt handler can run
> with enabled interrupts while serving the interrupt and not lose other
> interrupts especially the timer tick.
> If the system runs with force-threaded interrupts then there is no need
> to enable the interrupts.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
