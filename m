From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] cmd64x: fix multiword and remove single-word DMA support
Date: Mon, 23 Apr 2007 23:49:43 +0200
Message-ID: <200704232349.44067.bzolnier@gmail.com>
References: <200702080000.32852.sshtylyov@ru.mvista.com> <200704142309.04099.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbXDWWaN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so51003uga
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:12 -0700 (PDT)
In-Reply-To: <200704142309.04099.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 April 2007, Sergei Shtylyov wrote:
> Fix the multiword DMA and drop the single-word DMA support (which nobody will
> miss, I think).  In order to do it, a number of changes was necessary:
> 
> - rename program_drive_counts() to program_cycle_times(), pass to it cycle's
>   total/active times instead of the clock counts, and convert them into the
>   active/recovery clocks there instead of cmd64x_tune_pio() -- this causes
>   quantize_timing() to also move;
> 
> - contrarywise, move all the code handling the address setup timing into
>   cmd64x_tune_pio(), so that setting MWDMA mode wouldn't change address setup;
> 
> - remove from the speedproc() method the  bogus code pretending to set the DMA
>   timings by twiddling bits in the BMIDE status register, handle setting MWDMA
>   by just calling program_cycle_times(); while at it, improve the style of that
>   whole switch statement;
> 
> - stop fiddling with the DMA capable bits in the speedproc() method -- they do
>   not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
> 
> - don't set hwif->swdma_mask in the init_hwif() method anymore.
> 
> In addition to those changes, do the following:
> 
> - in cmd64x_tune_pio(), when writing to ARTTIM23 register preserve the interrupt
>   status bit, eliminate local_irq_{save|restore}() around this code as there's
>   *no* actual race with the interrupt handler, and move cmdprintk() to a more
>   fitting place -- after ide_get_best_pio_mode() call;
> 
> - make {arttim|drwtim}_regs arrays single-dimensional, indexed with drive->dn;
> 
> - rename {setup|recovery}_counts[] into more fitting {setup|recovery}_values[];
> 
> - in  the speedproc() method, get rid of the duplicate reads/writes from/to the
>   UDIDETCRx registers and of the extra variable used to store the transfer mode
>   value after filtering,  use another method of determining master/slave drive,
>   and cleanup useless parens;
> 
> - beautify cmdprintk() output here and there.
> 
> While at it, remove meaningless comment about the driver being used only on
> UltraSPARC and long non-relevant RCS tag. :-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is basically the result of merge of the former two:
> cmd64x-remove-brokem-sw-mw-dma-support.patch and
> cmd64x-add-back-mwdma-support.patch (minus the part removing the timing register
> setup form the init_chipset() method -- that's been moved to another patch).
> Has been (at last!) tested on PCI-649.

applied
