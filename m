From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: request to revert libata-convert-to-block-tagging patches
Date: Mon, 10 Nov 2008 08:03:45 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811100800420.3468@nehalem.linux-foundation.org>
References: <4917C449.2080504@kernel.org> <20081110120533.GB26778@kernel.dk> <491835FF.1060403@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754833AbYKJQEc@vger.kernel.org>
In-Reply-To: <491835FF.1060403@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Mon, 10 Nov 2008, Tejun Heo wrote:
>
> I'm just a little bit nervous because libata always has had this tag 0 
> for non-NCQ commands assumption and this conversion changes that, so I 
> was hoping to update blk-tag such that such assumption can be guaranteed 
> first and then convert libata to be on the safe side.  Some controllers 
> use completely different command mechanism for different protocols and 
> it's much safer and more deterministic if same tag can be guaranteed.

Yeah, I think that's a good argument. Even when controllers expect tags, 
it's certainyl quite possible that all they've ever been tested with have 
always started tag allocation from zero, so while the "start at an offset" 
thing is fairly clever for other reasons, it probably was the wrong thing 
to do.

Maybe we can just have something count "outstanding async/sync requests".

			Linus
