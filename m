From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] ide: don't disable interrupts during kmap_atomic()
Date: Fri, 04 May 2018 13:38:56 -0400 (EDT)
Message-ID: <20180504.133856.1141367626604511178.davem@davemloft.net>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-4-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-4-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:45 +0200

> ide_pio_bytes() disables interrupts around kmap_atomic(). This is a
> leftover from the old kmap_atomic() implementation which relied on fixed
> mapping slots, so the caller had to make sure that the same slot could not
> be reused from an interrupting context.
> 
> kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
> ("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
> removed the slot assignements, but the callers were not checked for now
> redundant interrupt disabling.
> 
> Remove the conditional interrupt disable.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
