From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Tue, 15 Apr 2014 12:33:09 -0400
Message-ID: <20140415163309.GB30990@htj.dyndns.org>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:52167 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbaDOQdN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 12:33:13 -0400
Received: by mail-qa0-f45.google.com with SMTP id cm18so9119586qab.18
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2014 09:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>

(cc'ing Alexander)

On Mon, Apr 14, 2014 at 04:47:18PM -0500, David Milburn wrote:
> System may crash in ahci_hw_interrupt() or ahci_thread_fn() when accessing
> the interrupt status in a port's private_data if the port is actually a
> DUMMY port.
> 
> # lspci | grep ATA
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller
> 
> # systemctl status kdump (to ensure kdump service is running)
> # echo c > /proc/sysrq-trigger
> 
> <snip console output for linux-3.15-rc1>
...
> [   10.375452] BUG: unable to handle kernel NULL pointer dereference at 000000000000003c
> [   10.384217] IP: [<ffffffffa0133df0>] ahci_hw_interrupt+0x100/0x130 [libahci]
...
> [   10.559121] Call Trace:
> [   10.561849]  <IRQ> 
> [   10.563994]  [<ffffffff810c2a1e>] handle_irq_event_percpu+0x3e/0x1a0
> [   10.571309]  [<ffffffff810c2bbd>] handle_irq_event+0x3d/0x60
> [   10.577631]  [<ffffffff810c4fdd>] try_one_irq.isra.6+0x8d/0xf0
> [   10.584142]  [<ffffffff810c5313>] note_interrupt+0x173/0x1f0
> [   10.590460]  [<ffffffff810c2a8e>] handle_irq_event_percpu+0xae/0x1a0
> [   10.597554]  [<ffffffff810c2bbd>] handle_irq_event+0x3d/0x60
> [   10.603872]  [<ffffffff810c5727>] handle_edge_irq+0x77/0x130
> [   10.610199]  [<ffffffff81014b8f>] handle_irq+0xbf/0x150
> [   10.616040]  [<ffffffff8109ff4e>] ? vtime_account_idle+0xe/0x50
> [   10.622654]  [<ffffffff815fca1a>] ? atomic_notifier_call_chain+0x1a/0x20
> [   10.630140]  [<ffffffff816038cf>] do_IRQ+0x4f/0xf0
> [   10.635490]  [<ffffffff815f8aed>] common_interrupt+0x6d/0x6d
> [   10.641805]  <EOI> 
> [   10.643950]  [<ffffffff8149ca9f>] ? cpuidle_enter_state+0x4f/0xc0
> [   10.650972]  [<ffffffff8149ca98>] ? cpuidle_enter_state+0x48/0xc0
> [   10.657775]  [<ffffffff8149cb47>] cpuidle_enter+0x17/0x20
> [   10.663807]  [<ffffffff810b0070>] cpu_startup_entry+0x2c0/0x3d0
> [   10.670423]  [<ffffffff815dfcc7>] rest_init+0x77/0x80
> [   10.676065]  [<ffffffff81a60f47>] start_kernel+0x40f/0x41a
> [   10.682190]  [<ffffffff81a60941>] ? repair_env_string+0x5c/0x5c
> [   10.688799]  [<ffffffff81a60120>] ? early_idt_handlers+0x120/0x120
> [   10.695699]  [<ffffffff81a605ee>] x86_64_start_reservations+0x2a/0x2c
> [   10.702889]  [<ffffffff81a60733>] x86_64_start_kernel+0x143/0x152
...
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 6bd4f66..401924e 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1791,9 +1791,14 @@ irqreturn_t ahci_thread_fn(int irq, void *dev_instance)
>  	u32 status;
>  
>  	spin_lock_irqsave(&ap->host->lock, flags);
> -	status = pp->intr_status;
> -	if (status)
> -		pp->intr_status = 0;
> +	if (!ata_port_is_dummy(ap)) {
> +			status = pp->intr_status;
> +			if (status)
> +				pp->intr_status = 0;
> +	} else {
> +		spin_unlock_irqrestore(&ap->host->lock, flags);
> +		return IRQ_HANDLED;
> +	}
>  	spin_unlock_irqrestore(&ap->host->lock, flags);
>  
>  	spin_lock_bh(ap->lock);
> @@ -1833,8 +1838,11 @@ irqreturn_t ahci_hw_interrupt(int irq, void *dev_instance)
>  	irq_stat = readl(mmio + HOST_IRQ_STAT);
>  
>  	if (!irq_stat) {
> -		u32 status = pp->intr_status;
> +		u32 status = 0;
>  
> +		if (!ata_port_is_dummy(ap_this))
> +			status = pp->intr_status;
> +
>  		spin_unlock(&host->lock);
>  
>  		VPRINTK("EXIT\n");

I kinda really dislike that we're littering interrupt handling path
instead of ensuring that this doesn't happen for dummy ports.
Alexander, do we need to request irqs for dummy ports?  If so,
wouldn't it be better to use noop handlers than doing the above?

Thanks.

-- 
tejun
