From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Sun, 19 Apr 2009 09:28:29 +0200
Message-ID: <20090419072829.GA2906@liondog.tnic>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com> <49E8F0A7.5040208@gmail.com> <20090418194839.GA2848@liondog.tnic> <49EA489E.6080809@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40905 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZDSH2f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Apr 2009 03:28:35 -0400
Received: by fxm2 with SMTP id 2so1465113fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2009 00:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49EA489E.6080809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

On Sun, Apr 19, 2009 at 06:39:42AM +0900, Tejun Heo wrote:
> Hello, Borislav.
> 
> Borislav Petkov wrote:
> > sorry for I wasn't that clear. We need the drive->pc ptr valid in order to
> > retry a packet command couple lines below in the ->do_request callback:
> > 
> >         /* Retry a failed packet command */
> >         if (drive->failed_pc && drive->pc->c[0] == REQUEST_SENSE) {
> >                 pc = drive->failed_pc;
> >                 goto out;
> >         }
> 
> No, that's checking whether the _previous_ command was REQUEST_SENSE
> which is guaranteed to be set if drive->failed_pc is not NULL.
> drive->pc is set to the current command at the start of
> ide_tape_issue_pc().

Damn! Now it all falls into place nicely, thanks for clarifying that. My
original bug analysis was simply plain wrong.

So, drive->pc means two things: the previous command - until the moment
when it is overwritten with the upcoming command from the current
request _and_ the current command which is being issued. This is all
quite b0rked...

I think your original fix is just fine, let's go with that.

-- 
Regards/Gruss,
    Boris.
