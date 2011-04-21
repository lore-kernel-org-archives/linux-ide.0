From: Shaun Ruffell <sruffell@digium.com>
Subject: Re: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to  userland
Date: Thu, 21 Apr 2011 13:02:51 -0500
Message-ID: <4DB0714B.90701@digium.com>
References: <20110421170826.GC15988@htj.dyndns.org> <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com> <4DB06A06.7030208@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DB06A06.7030208@fusionio.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Neil Brown <neilb@suse.de>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>
List-Id: linux-ide@vger.kernel.org

On 04/21/2011 12:31 PM, Jens Axboe wrote:
> On 2011-04-21 19:25, Linus Torvalds wrote:
>> Should I take these as patches, or through Jens/David/Who?
>>
>> I'll happily take them as patches, but I'd also like to hear
>> confirmation from the people who saw the lock-up that it's gone now..
> 
> I'm pulling them in now, with the elevator patch referenced in the IO
> scheduler switch email. I've verified that it fixes the ide-cd bug for
> me.

Jens, Tejun,

I was never seeing a lockup, just the stream of events, but I applied the
two patches on top of mainline (584f790467 from yesterday) and do not see
any issues on the system where I first noticed the constant events [1].

[1] https://bugzilla.kernel.org/show_bug.cgi?id=33342

So,
Tested-by: Shaun Ruffell <sruffell@digium.com> 

Thanks,
Shaun
