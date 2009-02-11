From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/6] ide: pass command to ide_map_sg()
Date: Wed, 11 Feb 2009 17:28:27 +0100
Message-ID: <200902111728.28070.bzolnier@gmail.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209231952.32406.58013.sendpatchset@localhost.localdomain> <20090211063623.GB937@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:55526 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbZBKQtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 11:49:55 -0500
In-Reply-To: <20090211063623.GB937@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 11 February 2009, Borislav Petkov wrote:
> On Tue, Feb 10, 2009 at 12:19:52AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: pass command to ide_map_sg()
> > 
> > * Set IDE_TFLAG_WRITE flag and ->rq also for ATA_CMD_PACKET
> >   commands.
> > 
> > * Pass command to ->dma_setup method and update all its
> >   implementations accordingly.
> > 
> > * Pass command instead of request to ide_build_sglist(),
> >   *_build_dmatable() and ide_map_sg().
> > 
> > While at it:
> > 
> > * Fix scc_dma_setup() documentation + use ATA_DMA_WR define.
> > 
> > * Rename sgiioc4_build_dma_table() to sgiioc4_build_dmatable(),
> >   change return value type to 'int' and drop unused 'ddir'
> >   argument.
> > 
> > * Do some minor cleanups in [tx4939]ide_dma_setup().
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Cc: Borislav Petkov <petkovbb@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[...]

[ please cut needless parts when replying, thanks ]

> > Index: b/drivers/ide/ide-floppy.c
> > ===================================================================
> > --- a/drivers/ide/ide-floppy.c
> > +++ b/drivers/ide/ide-floppy.c
> > @@ -285,8 +285,12 @@ static ide_startstop_t ide_floppy_do_req
> >  		goto out_end;
> >  	}
> >  
> > +	if (rq_data_dir(rq))
> > +		cmd->tf_flags |= IDE_TFLAG_WRITE;
> > +	cmd->rq = rq;
> > +
> >  	ide_init_sg_cmd(cmd, rq->nr_sectors);
> > -	ide_map_sg(drive, rq);
> > +	ide_map_sg(drive, cmd);
> 
> How about we push those mappings in ide_issue_pc() in the else-branch
> after we've tried setting up dma and we've failed? This way we don't
> have to do that in the ->do_request of every device and do it for all at

Sounds OK to me.

> one place instead. Only ide-cd will have to have ->ide_io_buffers for
> PIO transfers (which I was working on before bugs :))

BTW I have now a draft patch making ide-cd use ide_pio_bytes() for fs
requests (I still need to do it for non-fs requests, polish, document
and do more testing).  The hard parts (== more like mind melting ones)
were in untagling cdrom_end_request() uses and getting rid of partial
completions without making the whole transfer fail on errors...

Thanks,
Bart
