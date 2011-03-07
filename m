From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2.6.38-rc5 2/2] block: blk-flush shouldn't call  directly
 into q->request_fn() __blk_run_queue()
Date: Mon, 07 Mar 2011 09:41:04 +0100
Message-ID: <4D749A20.9080701@kernel.dk>
References: <20110217111511.GQ19830@htj.dyndns.org> <20110217111619.GR19830@htj.dyndns.org> <AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com> <20110218094903.GF21209@htj.dyndns.org> <4D6E4A46.1040709@kernel.dk> <20110304182507.GY20499@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:40352 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab1CGIlH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 03:41:07 -0500
In-Reply-To: <20110304182507.GY20499@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mike Snitzer <snitzer@gmail.com>, Jan Beulich <JBeulich@novell.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 2011-03-04 19:25, Tejun Heo wrote:
> Hello, Jens.
> 
> On Wed, Mar 02, 2011 at 08:46:46AM -0500, Jens Axboe wrote:
>>> Right, thanks.  Jens, after you apply the two fixes for 2.6.38, I can
>>> create a merge branch for for-2.6.39/core which you can pull.  Would
>>> that work for you?
>>
>> Thanks, that would be great. I'm applying them now.
> 
> Okay, please pull from the following branch to receive the merge
> between linux-2.6-block:for-linus and :for-2.6.39/core.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-for-2.6.39-core
> 
> HEAD is e83a46bbb1d4c03defd733a64b727632a40059ad but git.korg seems a
> bit slow to sync, so if you don't see the commit there, please pull
> from master.korg.
> 
>  ssh://master.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-for-2.6.39-core
> 
> Thanks.

Pulled, thanks Tejun.

-- 
Jens Axboe

