From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libahci: Implement the workaround to fix the missing
 of edge interrupt for HOST_IRQ_STAT
Date: Mon, 11 Jan 2016 11:16:48 -0500
Message-ID: <20160111161648.GE1898@mtj.duckdns.org>
References: <1452506763-18649-1-git-send-email-stripathi@apm.com>
 <1452506763-18649-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:33720 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcAKQQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 11:16:49 -0500
Content-Disposition: inline
In-Reply-To: <1452506763-18649-2-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com

Hello,

On Mon, Jan 11, 2016 at 03:36:02PM +0530, Suman Tripathi wrote:
> Due to H/W errata, the HOST_IRQ_STAT register misses the edge interrupt
> when clearing the HOST_IRQ_STAT register and hardware reporting the
> PORT_IRQ_STAT register at the same clock cycle. As such, the
> algorithm below outlines the workaround.
> 
> 1. Read HOST_IRQ_STAT register and save the state.
> 2. Clear the HOST_IRQ_STAT register.
> 3. Read back the HOST_IRQ_STAT register.
> 4. If HOST_IRQ_STAT register equals to zero, then
>    traverse the rest of port's PORT_IRQ_STAT register
>    to check if an interrupt is triggered at that point else
>    go to step 6.
> 5. If PORT_IRQ_STAT register of rest ports is not equal to zero
>    then update the state of HOST_IRQ_STAT saved in step 1.
> 6. Handle port interrupts.
> 7. Exit
...
> +static void ahci_handle_broken_edge_irq(struct ata_host *host,
> +					u32 *irq_masked)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	unsigned int i, temp_irq_masked;
> +	struct ata_port *next_ap;
> +	void __iomem *port_mmio;
> +	int j;
> +
> +	if (!readl(mmio + HOST_IRQ_STAT)) {
> +		temp_irq_masked = *irq_masked;
> +
> +		for (i = 0; i < __sw_hweight32(hpriv->port_map);
> +		     i++) {
                     ^^^^^^
		     Doesn't this fit on the same line?

> +			if (*irq_masked & (1 << i)) {
> +				for (j = 0;
> +				     j < __sw_hweight32(hpriv->port_map);
> +				     j++) {

Heh, if (!COND) continue; can be your friend.

> +					if (i == j)
> +						continue;
> +
> +					next_ap = host->ports[j];
> +					port_mmio = ahci_port_base(next_ap);
> +					if (readl(port_mmio + PORT_IRQ_STAT))
> +						temp_irq_masked |= (1 << j);
> +				}
> +			}
> +		}
> +		*irq_masked = temp_irq_masked;
> +	}
> +
> +}

So, this is really specific to the controller.

>  static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
>  {
> +	struct ahci_host_priv *hpriv = host->private_data;
>  	unsigned int i, handled = 0;
> 
> +	/*
> +	 * For hardware with broken edge trigger latch
> +	 * the HOST_IRQ_STAT register misses the edge interrupt
> +	 * when clearing of HOST_IRQ_STAT register and hardware
> +	 * reporting the PORT_IRQ_STAT register at the
> +	 * same clock cycle.
> +	 */
> +	if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ_BROKEN)
> +		ahci_handle_broken_edge_irq(host, &irq_masked);
> +

And all it needs is doing some extra processing at the beginning of
port interrupt handling.  I think it'd be better to implement
ahci_xgene specific IRQ handler which does the special processing and
call the generic ahci_handle_port_intr().

Thanks.

-- 
tejun
