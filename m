From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 01/14] ide-tape: fix potential fs requests bug
Date: Sat, 9 May 2009 10:50:08 +0200
Message-ID: <20090509085008.GA5261@liondog.tnic>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-2-git-send-email-petkovbb@gmail.com> <20090509080245.GB22617@uranus.ravnborg.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:52783 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZEIIuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 04:50:13 -0400
Content-Disposition: inline
In-Reply-To: <20090509080245.GB22617@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Borislav Petkov <petkovbb@googlemail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 09, 2009 at 10:02:45AM +0200, Sam Ravnborg wrote:
> On Sat, May 09, 2009 at 09:45:21AM +0200, Borislav Petkov wrote:
> > ide-tape had a potential bug for fs requests when preparing the command
> > packet: it was writing the transfer length as a number of fixed blocks.
> > However, the block layer implies 512 byte blocks and ide-tape can have
> > other block sizes so account for that too.
> > 
> > ide-floppy does this calculation properly with the block size factor
> > (floppy->bs_factor).
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-tape.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index e166045..fc79cf4 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -586,7 +586,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
> >  				   struct ide_atapi_pc *pc, struct request *rq,
> >  				   u8 opcode)
> >  {
> > -	unsigned int length = blk_rq_sectors(rq);
> > +	unsigned int length = blk_rq_sectors(rq) / (tape->blk_size >> 9);
> 
> If tape->blk_size equals 256 or less then we get a divide-by-zero.

Yes, there is a far-fetched, potential possibility for that but here's
what the QIC 157D (http://www.qic.org/html/standards/15x.x/qic157d.pdf)
spec for streaming tapes says on block sizes:

"The Block Length specifies the current length in bytes of each logical
block described by the block descriptor for the current medium. For QIC
Streaming Tape Devices, two block sizes supported may be of either 512
or 1024 bytes per block."

Also, the driver catches invalid block sizes in
idetape_get_mode_sense_results() so I guess we should be fine.

Thanks.

-- 
Regards/Gruss,
    Boris.
