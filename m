From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/18] misc generic ide stuff
Date: Sat, 14 Jun 2008 19:29:00 +0200
Message-ID: <200806141929.00459.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:10415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYFNRrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 13:47:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3007218fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 10:46:58 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Thursday 12 June 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are some generic ide conversion patches. The first 12 are what i thought
> you suggested :) concerning prepping the ide-cd code for the generic layer. The
> remaining 6 are what i've done so far wrt removing ide_atapi_pc from the ide
> drivers. It is obvious that this is not trivial and I basically tiptoe around the

Thanks.

I applied patches #1-2, #5-12 and #14-15.

I skipped patches #3-4, #13 and #16-18 for now
(more details in replies to corresponding mails).

> landmines in the IRQ handler and request issue paths :). This raises also
> several questions:
> 
> 1. ide-cd uses the cdrom_info struct for e.g. dma status notification, the other
> ide drivers use it per packet command in pc->flags. Well the last are kinda too
> much to carry for _each_ command and i'm thinking maybe put all that in the
> ide_drive_t and make it generic enough to fit all drivers. This way
> pc->callback() can also be harboured there. One concern might be when a flag is
> strictly per packet command which could be put somewhere else (maybe in the
> struct request since it already has members when it is used as a packet
> command).

Some pc->flags describe device's properties and thus should be moved to
ide_drive_t (->dev_flags) while some other correspond to the queued command
and moving them to ide_drive_t would be a bad idea IMO.

For ATA commands I was planning to put taskfile flags into rq->special field
(well, I actually implemented it in draft patch and it looks OK) so maybe we
can do something similar for packet commands.
 
> 2. Can all that pc->xferred, pc->b_count, pc->errors and pc->cur_pos accounting
> be safely mapped to a rq? I see some discrepancies like is pc->buf_size ==
> rq->data_len, what about pc->req_xfer? I'll have a more detailed look at those
> when i have more spare time later.

If you ask if they can be mapped 'directly' then the answer is: "probably no"
but if the question is whether it is possible to do it after some changes then
the answer is: "probably yes". :)

[ However it may be necessary to convert ATAPI drivers to use scatterlists
  instead of open-coded ->bio walking for PIO transfers first. ]

Thanks,
Bart
