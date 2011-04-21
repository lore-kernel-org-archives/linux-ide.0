From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] ide: unexport DISK_EVENT_MEDIA_CHANGE for ide-gd
 and ide-cd
Date: Thu, 21 Apr 2011 10:14:04 -0700 (PDT)
Message-ID: <20110421.101404.02262055.davem@davemloft.net>
References: <20110421170826.GC15988@htj.dyndns.org>
	<20110421170925.GD15988@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110421170925.GD15988@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: jaxboe@fusionio.com, torvalds@linux-foundation.org, hch@lst.de, neilb@suse.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kay.sievers@vrfy.org
List-Id: linux-ide@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Thu, 21 Apr 2011 19:09:25 +0200

> check_events() implementations in both ide-gd and ide-cd are
> inadequate for in-kernel event polling.  Both generate media change
> events continuously when certain conditions are met causing infinite
> event loop between the driver and userland event handler.
> 
> As disk event now supports suppression of unlisted events, simply
> de-listing DISK_EVENT_MEDIA_CHANGE from disk->events resolves the
> problem.  Internal handling around media revalidation will behave the
> same while userland will fall back to userland event polling after
> detecting the device doesn't support disk events.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Jens Axboe <jaxboe@fusionio.com>

Acked-by: David S. Miller <davem@davemloft.net>
