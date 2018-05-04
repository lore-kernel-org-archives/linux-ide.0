From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4] ide: Handle irq disabling consistently
Date: Fri, 04 May 2018 13:38:23 -0400 (EDT)
Message-ID: <20180504.133823.125565697801860796.davem@davemloft.net>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-3-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-3-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:44 +0200

> ide_timer_expiry() disables interrupt at function entry when acquiring
> hwif->lock. Before disabling the device interrupt it unlocks hwif->lock,
> but interrupts stay disabled. After the call to disable_irq() interrupts
> are disabled again, which is a pointless exercise.
> 
> After the device irq handler has been invoked with interrupts disabled,
> hwif->lock is acquired again with spin_lock_irq() because the device irq
> handler might have reenabled interrupts. This is not documented and
> confusing for the casual reader.
> 
> Remove the redundant local_irq_disable() and add a comment which explains
> why hwif->lock has to be reacquired with spin_lock_irq().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
