From: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd question
Date: Thu, 3 Mar 2005 17:15:54 +0100
Message-ID: <20050303161554.GJ19505@suse.de>
References: <001901c51ffd$1518a210$aeb91942@400sc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ns.virtualhost.dk ([195.184.98.160]:31139 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261156AbVCCQQG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2005 11:16:06 -0500
Content-Disposition: inline
In-Reply-To: <001901c51ffd$1518a210$aeb91942@400sc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart Hayes <stuarthayes@austin.rr.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Stuart_Hayes@Dell.com

On Thu, Mar 03 2005, Stuart Hayes wrote:
> I sent in this patch a few weeks ago, and never saw a response... I was 
> wondering if there was a problem with it, or if I need to supply more 
> info...?  This patch is against 2.6.11-rc3.  It makes sure that when 
> ide_atapi_error() tries to end a failing ATAPI request after 2 reset 
> attempts by calling drive->driver->end_request(), it will really be ended.  
> Right now, a request that has a non-null rq->bio will not get ended, nor 
> will rq->errors get cleared, so it will get retried forever with no more 
> reset attempts.

Indeed a problem. Would be nice to switch the ->end_request() to be byte
based like SCSI, would make it cleaner.

But do you really need the !nsectors check? If ->data_len is 0, there
should not be a need to pass a non-zero sector count.

> My fingers are crossed that this patch won't be mangled... I seem to have 
> a problem with that...

No such luck, it's mangled :). Looks like tabs turned to a single space.
Maybe you have better luck with attaching the file.

-- 
Jens Axboe

