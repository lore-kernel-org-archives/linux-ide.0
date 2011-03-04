From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2.6.38-rc5 2/2] block: blk-flush shouldn't call
 directly into q->request_fn() __blk_run_queue()
Date: Fri, 4 Mar 2011 19:25:07 +0100
Message-ID: <20110304182507.GY20499@htj.dyndns.org>
References: <20110217111511.GQ19830@htj.dyndns.org>
 <20110217111619.GR19830@htj.dyndns.org>
 <AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com>
 <20110218094903.GF21209@htj.dyndns.org>
 <4D6E4A46.1040709@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D6E4A46.1040709@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@gmail.com>, Jan Beulich <JBeulich@novell.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Jens.

On Wed, Mar 02, 2011 at 08:46:46AM -0500, Jens Axboe wrote:
> > Right, thanks.  Jens, after you apply the two fixes for 2.6.38, I can
> > create a merge branch for for-2.6.39/core which you can pull.  Would
> > that work for you?
> 
> Thanks, that would be great. I'm applying them now.

Okay, please pull from the following branch to receive the merge
between linux-2.6-block:for-linus and :for-2.6.39/core.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-for-2.6.39-core

HEAD is e83a46bbb1d4c03defd733a64b727632a40059ad but git.korg seems a
bit slow to sync, so if you don't see the commit there, please pull
from master.korg.

 ssh://master.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-for-2.6.39-core

Thanks.

-- 
tejun
