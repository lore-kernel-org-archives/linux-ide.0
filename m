From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to  
 userland
Date: Thu, 21 Apr 2011 20:10:30 +0200
Message-ID: <4DB07316.5000405@fusionio.com>
References: <20110421170826.GC15988@htj.dyndns.org> <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com> <4DB06A06.7030208@fusionio.com> <4DB0714B.90701@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.fusionio.com ([64.244.102.30]:59468 "EHLO mx1.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1DUSKf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Apr 2011 14:10:35 -0400
In-Reply-To: <4DB0714B.90701@digium.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaun Ruffell <sruffell@digium.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Neil Brown <neilb@suse.de>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>

On 2011-04-21 20:02, Shaun Ruffell wrote:
> On 04/21/2011 12:31 PM, Jens Axboe wrote:
>> On 2011-04-21 19:25, Linus Torvalds wrote:
>>> Should I take these as patches, or through Jens/David/Who?
>>>
>>> I'll happily take them as patches, but I'd also like to hear
>>> confirmation from the people who saw the lock-up that it's gone now..
>>
>> I'm pulling them in now, with the elevator patch referenced in the IO
>> scheduler switch email. I've verified that it fixes the ide-cd bug for
>> me.
> 
> Jens, Tejun,
> 
> I was never seeing a lockup, just the stream of events, but I applied the
> two patches on top of mainline (584f790467 from yesterday) and do not see
> any issues on the system where I first noticed the constant events [1].
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=33342

Great, thanks for testing!

-- 
Jens Axboe

