From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Date: Fri, 17 Oct 2008 18:46:34 +0200
Message-ID: <200810171846.35109.bzolnier@gmail.com>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp> <20081017141310.GA14999@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:4659 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbYJQQuX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 12:50:23 -0400
Received: by gv-out-0910.google.com with SMTP id e6so206114gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 17 Oct 2008 09:50:21 -0700 (PDT)
In-Reply-To: <20081017141310.GA14999@linux-mips.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

On Friday 17 October 2008, Ralf Baechle wrote:
> On Fri, Oct 17, 2008 at 11:08:25PM +0900, Atsushi Nemoto wrote:
> 
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> > 
> > This controller has standard ATA taskfile registers and DMA
> > command/status registers, but the register layout is swapped on big
> > endian.  There are some other endian issue and some special registers
> > which requires many custom dma_ops/tp_ops routines and build_dmatable.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > ---
> > This patch is against current linux-mips tree.
> > 
> > Changes since v3:
> > * more consistent symbol naming
> > * handle only DMA mode in set_dma_mode
> > * rename tx4939ide_read_and_clear_dma_status to tx4939ide_clear_dma_status
> > * use standard ide_read_sff_dma_status in LE mode
> > * remove CS5530 workaround from tx4939ide_build_dmatable
> > * use ide_host_alloc/ide_host_register instead of ide_host_alloc
> > * fold tx4939ide_insw_swap into tx4939ide_input_data_swap
> > * more informative printk
> > * whitespace cleanups and spelling fixes
> > 
> >  drivers/ide/Kconfig          |    6 +
> >  drivers/ide/mips/Makefile    |    1 +
> >  drivers/ide/mips/tx4939ide.c |  755 ++++++++++++++++++++++++++++++++++++++++++
> 
> Btw, I don't think architecture specific subdirectories in subsystems are
> generally usefull.  Just as in this example this IDE controller happens
> only to be in use on a particular MIPS-based SOC but there is nothing
> really architecture specific in most such devices.

I fully agree with you.

I was going to remove arch/bus specific subdirs in .29 but since the change
should be really straightforward and we're ahead of the merge schedule for
.28 I think we may as well do it now...

I'll prepare corresponding IDE git pull request next week.

Thanks,
Bart
