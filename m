From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: handle fragmented packet commands gracefully
Date: Fri, 26 Jun 2009 10:19:58 +0200
Message-ID: <20090626081958.GA15449@liondog.tnic>
References: <1245574527-2104-1-git-send-email-petkovbb@gmail.com> <200906221150.22992.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f206.google.com ([209.85.220.206]:43882 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbZFZIUA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jun 2009 04:20:00 -0400
Content-Disposition: inline
In-Reply-To: <200906221150.22992.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

On Mon, Jun 22, 2009 at 11:50:22AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 21 June 2009 10:55:27 Borislav Petkov wrote:
> > There are some devices in the wild that clear the DRQ bit during the
> > last word of a packet command and therefore could use a "second chance"
> > for that last word of data to be xferred instead of simply failing the
> > request. Do that by attempting to suck in those last bytes in PIO mode.
> > 
> > In addition, the ATA_ERR bit has to be cleared for we cannot be sure the
> > data is valid otherwise.
> > 
> > See http://bugzilla.kernel.org/show_bug.cgi?id=13399 for details.
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

can you pick that one too, please. I can't seem to find it on patchwork.

Thanks.

> 
> > ---
> >  drivers/ide/ide-cd.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 4a19686..8d3f7d0 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -592,9 +592,19 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
> >  			}
> >  		} else if (!blk_pc_request(rq)) {
> >  			ide_cd_request_sense_fixup(drive, cmd);
> > -			/* complain if we still have data left to transfer */
> > +
> >  			uptodate = cmd->nleft ? 0 : 1;
> > -			if (uptodate == 0)
> > +
> > +			/*
> > +			 * suck out the remaining bytes from the drive in an
> > +			 * attempt to complete the data xfer. (see BZ#13399)
> > +			 */
> > +			if (!(stat & ATA_ERR) && !uptodate && thislen) {
> > +				ide_pio_bytes(drive, cmd, write, thislen);
> > +				uptodate = cmd->nleft ? 0 : 1;
> > +			}
> > +
> > +			if (!uptodate)
> >  				rq->cmd_flags |= REQ_FAILED;
> >  		}
> >  		goto out_end;

-- 
Regards/Gruss,
    Boris.
