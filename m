From: Tejun Heo <tj@kernel.org>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Sat, 04 Apr 2009 13:58:52 +0900
Message-ID: <49D6E90C.5030109@kernel.org>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com> <49D64DE0.8060400@sutus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44603 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbZDDQqQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Apr 2009 12:46:16 -0400
In-Reply-To: <49D64DE0.8060400@sutus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dustin Harrison <d.harrison@sutus.com>
Cc: Sagar Borikar <sagar.borikar@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello,

Dustin Harrison wrote:
> I also run a MIPS platform and have seen this problem in 2.6.22.  It
> stems from the Sil3512 (and possibly others) not allowing read
> access to the taskfile registers while a DMA transfer is active.
> What happens for me is that when DMA_ENABLE is true the Sil3512 (in
> my case) will disallow reads to the taskfile registers.  So any
> event that triggers a port freeze during an interrupt while DMA is
> active causes a bus error to be thrown when the ata_check_status
> call fires.

Thanks a lot for diagnosing the problem.

> I cannot reproduce this on x86.  I assume it handles the taskfile
> read error differently.

I think we just get 0xff on IO read errors.

> As a workaround I have used this patch on sata_sil.c to cover up the
> problem and stop the kernel panics.  But I don't think this is the
> best approach.
>
> --- drivers/ata/sata_sil.c.orig 2009-04-01 18:15:55.000000000 -0700
> +++ drivers/ata/sata_sil.c      2009-04-03 10:51:56.000000000 -0700
> @@ -454,6 +454,23 @@
>  err_hsm:
>        qc->err_mask |= AC_ERR_HSM;
>  freeze:
> +
> +       /* Before we do a port freeze we need to ensure DMA_ENABLE is off.
> +       * This is because the controller will not give us access to the
> taskfile
> +       * registers while a DMA is in progress and ata_qc_complete is
> the first
> +       * function executed in ata_port_freeze. ata_port_freeze will
> attempt to
> +       * access the tf registers and give us a host bus error kernel
> panic.
> +       *
> +       * This code is repeated from ata_bmdma_stop because we may not
> have a
> +       * valid qc to pass to ata_bmdma_stop.
> +       */
> +       iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENABLE,
> ap->ioaddr.bmdma_addr);
> +
> +       /* According to ata_bmdma_stop, an HDMA transition requires on
> PIO cycle.
> +        *  But we can't read a taskfile register.
> +       */
> +       ioread8(ap->ioaddr.bmdma_addr)
> +
>        ata_port_freeze(ap);

Can you please move the logic to sil_freeze() and see whether it
works?  The freeze handler is supposed to put the controller into idle
(or at least not-crazy) state, so things like this fit there.

Thanks.

-- 
tejun

