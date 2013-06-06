From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI bug: a lockup in ahci_interrupt with fbs enabled pmp
Date: Thu, 6 Jun 2013 14:47:48 -0700
Message-ID: <20130606214748.GL5045@htj.dyndns.org>
References: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33538 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FFVrv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jun 2013 17:47:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so2060309pac.1
        for <linux-ide@vger.kernel.org>; Thu, 06 Jun 2013 14:47:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAASYz_TkwEvVeKhcSedAfdxdGmRLnONnSrmhnHNAE2nfy3AABg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yu Liu <liuyu.ac@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane Huang <shane.huang@amd.com>

Cc'ing Shane.

On Thu, Jun 06, 2013 at 02:33:20PM +0800, Yu Liu wrote:
> Hi all,
> 
> I met a lockup while I was running IO test on disks connected
> with an fbs enabled pmp board and an ahci host.
> 
> looks like the reason for the lockup is as below:
>     ahci_interrert()
>         | spin_lock(&host->lock);                // get host->lock
>         | ahci_port_intr()
>             | ahci_error_intr()                  // status & PORT_IRQ_ERROR
>                 | ata_link_online()              // if fbs_enabled
>                     | sata_scr_read()
>                         | sata_pmp_scr_read()    // using pmp
>                             | ata_exec_internal()
>                                 | ata_exec_internal_sg()
>                                     | spin_lock_irqsave(ap->lock, flags);
> since ap->lock == &host->lock,
> these two spin_lock get conflict
> 
> Can someone confirm the issue? Did I miss anything?

Yeah, it's a bug.  ata_link_online() can't be called from interrupt
handlers.  Shane?  Can you please look into it?  What's the purpose of
ata_link_online() in ahci_error_intr()?

Thanks.

-- 
tejun
