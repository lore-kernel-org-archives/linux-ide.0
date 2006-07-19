From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: implement hotplug by polling
Date: Wed, 19 Jul 2006 16:57:32 -0400
Message-ID: <44BE9CBC.2000601@pobox.com>
References: <11531196481023-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10637 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030309AbWGSU5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:57:43 -0400
In-Reply-To: <11531196481023-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch implements hotplug by polling - hp-poll.  It is used for
> 
> * hotplug event detection on controllers which don't provide PHY
>   status changed interrupt.
> 
> * hotplug event detection on disabled ports after reset failure.
>   libata used to leave such ports in frozen state to protect the
>   system from malfunctioning controller/device.  With hp-poll, hotplug
>   events no such ports are watched safely by polling, such that
>   removing/replacing the malfunctioning device triggers EH retry on
>   the port.
> 
> There are three port ops for hp-poll - hp_poll_activate, hp_poll,
> hp_poll_deactivate.  Only hp_poll is mandatory for hp-poll to work.
> This patch also implements SATA standard polling callbacks which poll
> SError.N/X bits - sata_std_hp_poll_activate() and sata_std_hp_poll().
> 
> By default, hp-poll is enabled only on disabled ports.  If a LLD
> doesn't support hotplug interrupts but can poll for hotplug events, it
> should indicate it by setting ATA_FLAG_HP_POLLING which tells libata
> to turn on hp-poll by default.
> 
> Putting port into any static powersave mode or setting
> libata.hotplug_polling_interval to zero disables hp-poll.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK, there is no reason why a global poll list is needed.  Simply having 
a struct workqueue in each schedule-able entity implicitly creates such 
a list.  But regardless, this is another example of adding 
cross-controller synchronization, where none is needed.

If the worker fired per-host_set, then you could use an ata_port dynamic 
flag to indicate the poll-active ports, for the ata_hp_poll_worker() loop.

If the worker fires per-port, then no loop or mutex is needed at all. 
You could simply call the hp_poll hook.


> @@ -633,6 +637,10 @@ struct ata_port_operations {
>  	void (*error_handler) (struct ata_port *ap);
>  	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
>  
> +	void (*hp_poll_activate) (struct ata_port *ap);
> +	void (*hp_poll_deactivate) (struct ata_port *ap);
> +	int (*hp_poll) (struct ata_port *ap);
> +
>  	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
>  	void (*irq_clear) (struct ata_port *);
>  

All new hooks require at least a one-two sentence description in the 
DocBook docs, telling driver writers how to use them.

	Jeff


