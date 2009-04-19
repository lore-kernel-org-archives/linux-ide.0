From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE	detection
Date: Sun, 19 Apr 2009 16:36:16 +0900
Message-ID: <49EAD470.50401@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-3-git-send-email-tj@kernel.org> <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com> <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com> <49E8F0A7.5040208@gmail.com> <20090418194839.GA2848@liondog.tnic> <49EA489E.6080809@gmail.com> <20090419072829.GA2906@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:8514 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZDSHgX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Apr 2009 03:36:23 -0400
Received: by ti-out-0910.google.com with SMTP id 11so994011tim.23
        for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2009 00:36:21 -0700 (PDT)
In-Reply-To: <20090419072829.GA2906@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello,

Borislav Petkov wrote:
>> No, that's checking whether the _previous_ command was REQUEST_SENSE
>> which is guaranteed to be set if drive->failed_pc is not NULL.
>> drive->pc is set to the current command at the start of
>> ide_tape_issue_pc().
> 
> Damn! Now it all falls into place nicely, thanks for clarifying that. My
> original bug analysis was simply plain wrong.
> 
> So, drive->pc means two things: the previous command - until the moment
> when it is overwritten with the upcoming command from the current
> request _and_ the current command which is being issued.

And whether the previous pc is accessible or not depends on which
command it actually was and if failed_pc is set, it's guaranteed to be
valid.

> This is all quite b0rked...

Yeah, it's all way too fragile.  :-(

-- 
tejun
