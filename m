From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: don't enable port irq before handler is
 registered
Date: Wed, 16 Mar 2011 10:04:53 +0100
Message-ID: <20110316090453.GA31832@htj.dyndns.org>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
 <4D7EB9EB.8030807@gmail.com>
 <1300162840.2118.4.camel@kero>
 <20110315071937.GB8635@htj.dyndns.org>
 <1300200509.10827.27.camel@sakura.staff.proxad.net>
 <1300201422.10827.39.camel@sakura.staff.proxad.net>
 <20110315151931.GA17376@htj.dyndns.org>
 <1300224158.10827.52.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38975 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab1CPJE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2011 05:04:59 -0400
Received: by fxm17 with SMTP id 17so1430750fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2011 02:04:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300224158.10827.52.camel@sakura.staff.proxad.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

On Tue, Mar 15, 2011 at 10:22:38PM +0100, Maxime Bizon wrote:
> 
> From: Maxime Bizon <mbizon@freebox.fr>
> 
> The ahci_pmp_attach() & ahci_pmp_detach() unmask port irq, but they
> are also called during port initialization, before ahci host irq
> handler is registered. On ce4100 platform, this sometimes triggers
> "irq 4: nobody cared" message when loading driver.
> 
> Fixed this by not touching the register if the port is in frozen
> state, and mark all uninitialized port as frozen.
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

 Acked-by: Tejun Heo <tj@kernel.org>

But just one nit.

> -	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +
> +	/*
> +	 * This may be called while we are still initializing the ahci
> +	 * host, and interrupt handler is not yet registered at that
> +	 * time. So don't mess with irq mask register unless the port
> +	 * is actually enabled.
> +	 */

Can you augment the comment so that it indicates that hardware IRQ
mask shouldn't be modified while the port is frozen and pp->intr_mask
will be restored when the port is thawed and note that the port starts
frozen?

Thanks.

-- 
tejun
