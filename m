From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to  userland
Date: Thu, 21 Apr 2011 19:31:50 +0200
Message-ID: <4DB06A06.7030208@fusionio.com>
References: <20110421170826.GC15988@htj.dyndns.org> <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, Neil Brown <neilb@suse.de>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>
List-Id: linux-ide@vger.kernel.org

On 2011-04-21 19:25, Linus Torvalds wrote:
> Should I take these as patches, or through Jens/David/Who?
> 
> I'll happily take them as patches, but I'd also like to hear
> confirmation from the people who saw the lock-up that it's gone now..

I'm pulling them in now, with the elevator patch referenced in the IO
scheduler switch email. I've verified that it fixes the ide-cd bug for
me.

-- 
Jens Axboe
