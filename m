From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-tape: change IDE_AFLAG_IGNORE_DSC non-atomically
Date: Tue, 2 Jun 2009 15:17:52 +0200
Message-ID: <200906021517.53027.bzolnier@gmail.com>
References: <1243926308-32385-1-git-send-email-petkovbb@gmail.com> <200906021218.33787.bzolnier@gmail.com> <9ea470500906020608o14f8bc8dwaedabff70c1cb707@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:54352 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbZFBOOy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2009 10:14:54 -0400
In-Reply-To: <9ea470500906020608o14f8bc8dwaedabff70c1cb707@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 June 2009 15:08:27 Borislav Petkov wrote:
> Hi,
> 
> On Tue, Jun 2, 2009 at 12:18 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> 
> ..
> 
> >> --- a/drivers/ide/ide-tape.c
> >> +++ b/drivers/ide/ide-tape.c
> >> @@ -656,15 +656,24 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
> >>
> >>       if ((drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) == 0 &&
> >>           (rq->cmd[13] & REQ_IDETAPE_PC2) == 0)
> >> -             set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
> >> +             drive->atapi_flags |= IDE_AFLAG_IGNORE_DSC;
> >>
> >>       if (drive->dev_flags & IDE_DFLAG_POST_RESET) {
> >> -             set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
> >> +             drive->atapi_flags |= IDE_AFLAG_IGNORE_DSC;
> >>               drive->dev_flags &= ~IDE_DFLAG_POST_RESET;
> >>       }
> >>
> >> -     if (!test_and_clear_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags) &&
> >> -         (stat & ATA_DSC) == 0) {
> >> +     /*
> >> +      * This is a precaution for IDE_AFLAG_IGNORE_DSC being conditionally set
> >> +      * above. We don't need a stronger enforcement of ordering because the
> >> +      * read below cannot precede the earlier write out-of-order since it is
> >> +      * to the same location. Also, since we have the ide port locked during
> >> +      * the ->do_request(), we only have to be aware of gcc reordering stuff.
> >> +      */
> >> +     barrier();
> >
> > Are you seeing a real problem with gcc here?  No sane compiler should need
> > a barrier() here (we would probably need zillions of them in kernel if it
> > really does).
> 
> No, this is just a precaution. The asm I checked looked fine but since
> the flag is set and right afterwards checked, it will be bad if this
> somehow got reordered. I actually haven't checked whether anything like
> that would be possible, at all.

Please remove it then.
