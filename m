From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE 	detection
Date: Sat, 18 Apr 2009 06:12:07 +0900
Message-ID: <49E8F0A7.5040208@gmail.com>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>	 <1239960802-31978-3-git-send-email-tj@kernel.org>	 <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>	 <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:23435 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbZDQVLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 17:11:22 -0400
Received: by ti-out-0910.google.com with SMTP id 11so667911tim.23
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2009 14:11:21 -0700 (PDT)
In-Reply-To: <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello,

Borislav Petkov wrote:
> Honestly, I don't know. The code predates even the initial git
> commit of the kernel so I guess nobody knows?

Heh.. maybe Mark does.

> And yeah, such a check looks a bit too much so I won't have any
> problem with removing it. Nevertheless, we need the small fix above
> in the ->do_request callback for all other packet commands since
> ide-tape uses currently ide_queue_pc_tail() for sending those. I
> know, I know, it is ugly and we're working on it :).

Can you explain a bit more about the bug?  I'm not really following.

>> Yet another problem is that idetape_flush_tape_buffers() uses pc which
>> is on stack which drive->pc ends up pointing directly to, so it won't
>> work.  Nobody expects that the pointer it passed into an API should be
>> accessible by the API implementation after it was done with it.
>> That's just a silly thing to do.
> 
> The whole on stack passing should be passe :) soon since we're about to kill
> those ide_atapi_pc's.

Hooray.

> As I said before, this is very old code that is really rusty and
> we're trying to janitor it slowly.

Yeap, sure.

Thanks.

-- 
tejun
