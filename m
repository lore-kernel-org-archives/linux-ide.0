From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/3] libata: Remove excess command issue delays
Date: Fri, 14 May 2010 22:24:37 -0400
Message-ID: <4BEE05E5.70904@garzik.org>
References: <20100505092350.586.46344.stgit@localhost.localdomain> <20100505092503.586.89942.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37179 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0EOCYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 22:24:40 -0400
Received: by gyg13 with SMTP id 13so1368019gyg.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 19:24:38 -0700 (PDT)
In-Reply-To: <20100505092503.586.89942.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 05/05/2010 05:25 AM, Alan Cox wrote:
>   /**
> + *	ata_sff_exec_command_nopost - issue ATA command to host controller
> + *	@ap: port to which command is being issued
> + *	@tf: ATA taskfile register set
> + *
> + *	Issues ATA command, with proper synchronization with interrupt
> + *	handler / other threads. This version of the helper does not protect
> + *	against any delayed writes done by the underlying fabric, it must
> + *	therefore not be used for MMIO devices unless the device handles
> + *	the 400nS command delay stall internally.
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)
> + */
> +void ata_sff_exec_command_nopost(struct ata_port *ap,
> +                                        const struct ata_taskfile *tf)
> +{
> +	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	iowrite8(tf->command, ap->ioaddr.command_addr);
> +}
> +EXPORT_SYMBOL_GPL(ata_sff_exec_command_nopost);

where did the 400ns delay go, for the 'nopost' version?

