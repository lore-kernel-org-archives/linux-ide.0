From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] alim15x3: move irq-restore before pci_dev_put()
Date: Fri, 04 May 2018 13:37:33 -0400 (EDT)
Message-ID: <20180504.133733.2169628934964033284.davem@davemloft.net>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-2-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:43 +0200

> init_chipset_ali15x3() initializes the chipset during init with disabled
> interrupts. There is no need to keep the interrupts disabled during
> pci_dev_put().
> Move the irq-restore before pci_dev_put() is invoked.
> 
> Side note: The same init is performed in
> drivers/ata/pata_ali.c::ali_init_chipset() without disabled interrupts.
> It looks that the same hardware is supported in the ATA land. Would it
> make sense to remove this driver since it is supported in the other
> subsystem?
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
