From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide-cd: use ide_drive_t's rq in cdrom_queue_request_sense
Date: Sun, 1 Feb 2009 17:04:50 +0100
Message-ID: <200902011704.51726.bzolnier@gmail.com>
References: <1233002440-4325-1-git-send-email-petkovbb@gmail.com> <200901271607.10869.bzolnier@gmail.com> <9ea470500901270847m40264331le1092dc1589ec9de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:51302 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZBARYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:24:14 -0500
In-Reply-To: <9ea470500901270847m40264331le1092dc1589ec9de@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 27 January 2009, Borislav Petkov wrote:
> On Tue, Jan 27, 2009 at 4:07 PM, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > On Monday 26 January 2009, Borislav Petkov wrote:
> >> There should be no functionality change resulting from this patch.
> >>
> >> Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> >> ---
> >>  drivers/ide/ide-cd.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> >> index d3d5fb6..3907466 100644
> >> --- a/drivers/ide/ide-cd.c
> >> +++ b/drivers/ide/ide-cd.c
> >> @@ -207,7 +207,7 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
> >>                                     struct request *failed_command)
> >>  {
> >>       struct cdrom_info *info         = drive->driver_data;
> >> -     struct request *rq              = &info->request_sense_request;
> >> +     struct request *rq              = &drive->request_sense_rq;
> >
> > Don't we want to also remove now unused ->request_sense_request?
> 
> sure we do :)
> 
> --
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Tue, 27 Jan 2009 17:42:28 +0100
> Subject: [PATCH 1/3] ide-cd: use ide_drive_t's rq in cdrom_queue_request_sense
> 
> There should be no functionality change resulting from this patch.
> 
> Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
