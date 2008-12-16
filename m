From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/9] ide-atapi: remove ide_atapi_pc from the irq handler
Date: Tue, 16 Dec 2008 21:35:27 +0100
Message-ID: <200812162135.27902.bzolnier@gmail.com>
References: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49738 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYLPUiZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 15:38:25 -0500
Received: by bwz14 with SMTP id 14so4544618bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 12:38:23 -0800 (PST)
In-Reply-To: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Tuesday 16 December 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's a first attempt at removing all references to ide_atapi_pc in the ATAPI
> IRQ handler. I've moved some of the members to the drive struct and will deal
> with them later :). The next step is to add an ide_atapi_queue_pc() routine

Hmm.  I recall discussing this before and having some concerns about struct
ide_atapi_pc removal idea probably being premature...

Looking at the patchset itself -- I'm very sorry but I just cannot apply it
with all these command specific fields going into ide_drive_t:

        unsigned long pc_flags;
        int pc_req_xfer;
        int pc_buf_size;
        int pc_error;

While they may look similar to the existing pc_* fields:

        /* callback for packet commands */
        void (*pc_callback)(struct ide_drive_s *, int);

        void (*pc_update_buffers)(struct ide_drive_s *, struct ide_atapi_pc *);
        int  (*pc_io_buffers)(struct ide_drive_s *, struct ide_atapi_pc *,
                              unsigned int, int);

they are clearly not.  Existing pc_* callbacks are per-device type (they
should have been probably named drv_*) and new ones are per-command ones.

I also don't see a way for code to differentiate between pc and failed_pc.

Moreover if we would like to ever add support for multiple queued commands
(actually I think that in a very limited way ide-tape does it already with
DSC) we would have to completely revert these changes.

Re-assuming: this is one-step forward / one-step back approach and not
exactly the kind of design that we would like to advocate.

> similar to ide_cd_queue_pc() and then rewrite all functions in the drivers to
> use struct requests and local buffers instead of pc->buf and then, after that
> works reliably, finally get rid of ide_atapi_pc completely.

Why not take care of low hanging fruits first?  There is still plenty...

- ide-cd uses private struct request for REQUEST SENSE (=> ide_drive_t's)

- it should be possible to port ide-cd to use ide_{issue,transfer}_pc()
  _without_ dealing with struct ide_atapi_pc issue at all

- why not investigate the possibility of porting ide-cd to using sg-s for
  PIO transfers first -- this should get rid of ide_cd_restore_request()
  and most of other rq fields manipulations

...and this is from taking not so long look at the current driver.

Why attack the "hard" problem first (struct ide_atapi_pc one) while there
are easier ones to deal with?  It may happen that once these easier ones
are fixed we will be able to view the "hard" one from a completely different
perspective (because code's complexity will decrease a lot in the meantime
it no longer will be a "hard" problem) and apply a better solution.

Besides I'm not fully convinced that struct ide_atapi_pc has to go first in
order to port ide-cd over ide-atapi -- we can just instead port ide-cd to
use struct ide_atapi_pc (however probably only after converting the driver
to use sg-s for PIO transfers -- otherwise it becomes another "hard" problem)
and then deal with struct ide_atapi_pc for all ATAPI code (be using struct
request fields directly or by merging struct ide_atapi_pc into ide_task_t
and always using the latter structure for ATA[PI] commands -- which is the
option that I personally came to prefer lately)...

Thanks,
Bart
