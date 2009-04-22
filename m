From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [git pull] IDE fixes
Date: Wed, 22 Apr 2009 21:22:34 +0200
Message-ID: <20090422192234.GA4126@uranus.ravnborg.org>
References: <200904222048.15556.bzolnier@gmail.com> <1240427207.21848.81.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:32918 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZDVTU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2009 15:20:27 -0400
Content-Disposition: inline
In-Reply-To: <1240427207.21848.81.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 22, 2009 at 12:06:47PM -0700, Joe Perches wrote:
> On Wed, 2009-04-22 at 20:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 3aec19d..3d4e099 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -609,7 +609,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
> >  	struct request *rq = hwif->rq;
> >  	ide_expiry_t *expiry = NULL;
> >  	int dma_error = 0, dma, thislen, uptodate = 0;
> > -	int write = (rq_data_dir(rq) == WRITE) ? 1 : 0, rc, nsectors;
> > +	int write = (rq_data_dir(rq) == WRITE) ? 1 : 0, rc = 0, nsectors;
> >  	int sense = blk_sense_request(rq);
> >  	unsigned int timeout;
> >  	u16 len;
> 
> I think ide is the only subsystem to use the
> initialization style of "?:," with additional
> declarations.
> 
> Would it be better to use a more standard style?
> 
> maybe:
> 	int dma_error = 0, dma, thislen, uptodate = 0, rc = 0, nsectors;
> 	int write = ((rq_data_dir(rq) == WRITE) ? 1 : 0;

Better to move assignment after variable definition.

	Sam
