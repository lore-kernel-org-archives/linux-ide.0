From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: add back MWDMA support
Date: Fri, 2 Mar 2007 23:03:32 +0100
Message-ID: <200703022303.32864.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702282352.41128.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:44788 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030611AbXCBWUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 17:20:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1443580nfa
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 14:20:09 -0800 (PST)
In-Reply-To: <200702282352.41128.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Wednesday 28 February 2007, Sergei Shtylyov wrote:
> Add back the multiword DMA support (I think nobody will miss single-word DMA).
> In order to do it, a number of changes had to be done:
> 
> - rename program_drive_counts() to program_cycle_times(), pass to it cycle's
>   total/active times instead of the clock counts, and convert them into the
>   active/recovery clocks there instead of cmd64x_tune_pio() -- this causes
>   quantize_timing() to also move;
> 
> - contrarywise, move all the code handling the address setup timing into
>   cmd64x_tune_pio(), so that setting MWDMA mode wouldn't change address setup;
> 
> - add MWDMA cases to the speedproc() method and handle them by just calling
>   program_cycle_times();
> 
> - set hwif->mdwma_mask in the init_hwif() method.
> 
> In addition to those changes, do the following:
> 
> - when writing to ARTTIM23 register for the secondary channel, preserve the
>   interrupt status bit; eliminate the local_irq_{save|restore}() around this
>   code as there is *no* actual race with interrupt handler;
> 
> - make {arttim|drwtim}_regs[] single-dimensional, indexed with drive->dn;
> 
> - rename {setup|recovery}_counts[] into more fitting {setup|recovery}_values[];
> 
> While at it, also do remove:
> 
> - needless and misplaced timing registers initialization in the init_chipset()
>   method;
> 
> - meaningless register "aliases";
> 
> - meaningless comment about the driver being used only on SPARC Ultra. :-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

looks fine, applied

> ---
> Warning: this has only been compile-tested, as usual, so *needs* real testing.
> 
> Note that this implementation doesn't take care of properly merging MWDMA and
> PIO timings which share the same registers (well, that's not done by the most
> IDE drivers anyway).
> 
> Still have no idea about why PPC needs to explicitly disable UltraDMA on the
> primary channel -- it should be disabled by default...

No idea, probably looking at cmd64x driver version from the time that this
quirk was introduced would give some answers...

Thanks,
Bart
