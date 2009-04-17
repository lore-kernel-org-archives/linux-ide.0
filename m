From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE 	detection
Date: Fri, 17 Apr 2009 17:27:11 -0400
Message-ID: <49E8F42F.2090005@rtr.ca>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>	 <1239960802-31978-3-git-send-email-tj@kernel.org>	 <9ea470500904170323k2adbe63q5488c63fe368d328@mail.gmail.com>	 <49E85B6F.7080603@kernel.org> <49E85CA7.2060801@gmail.com> <9ea470500904170403n621f84det8cfec405131d893c@mail.gmail.com> <49E8F0A7.5040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60215 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbZDQV1O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 17:27:14 -0400
In-Reply-To: <49E8F0A7.5040208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: petkovbb@gmail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> Borislav Petkov wrote:
>> Honestly, I don't know. The code predates even the initial git
>> commit of the kernel so I guess nobody knows?
> 
> Heh.. maybe Mark does.
..

I may have known once -- I'm sure Gadi explained it to me,
but my memory doesn't have it any more.

>>> Yet another problem is that idetape_flush_tape_buffers() uses pc which
>>> is on stack which drive->pc ends up pointing directly to, so it won't
>>> work.  Nobody expects that the pointer it passed into an API should be
>>> accessible by the API implementation after it was done with it.
>>> That's just a silly thing to do.
>> The whole on stack passing should be passe :)
..

Nowadays, for sure.

But back then, the kernel was able to map all physical memory
at once, so lots of code did things that way.  Over time, much of
it has been "fixed" to handle newer machines with tons of RAM.

I guess you've just found more of it to modernize.  :)

Cheers
