From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 15:25:50 +0900
Message-ID: <4BB43C6E.3050900@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org> <20100401055455.GA20865@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55885 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337Ab0DAG0R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2010 02:26:17 -0400
In-Reply-To: <20100401055455.GA20865@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello,

On 04/01/2010 02:54 PM, Herbert Xu wrote:
> On Thu, Apr 01, 2010 at 01:56:53PM +0900, Tejun Heo wrote:
>>
>> OIC.  It's also cleared in ide_timer_expiry() too.  Asymmetry among
>> different failure paths worries me.  e.g. looking at the code, I can't
>> find how ide_error() would requeue the request either.  It looks like
>> each hwif->rq = NULL in failure path should be investigated and the
>> affected ones should be replaced with a function which requeues and
>> clears hwif->rq.  Hmmm.... am I misunderstanding something?
> 
> I had a look at the rest of them and they seemed to be fine.

In ide_timer_expiry() if drive->waiting_for_dma is false, ide_error()
is called, which in turn calls __ide_error() for fs requests.
ide_ata_error() will be called if the device is a disk.  If the
request hasn't reached the retry limit and reset is not necessary,
ide_ata_error() will return ide_stopped without requeueing the
request.  ide_timer_expiry() will clear hwif->rq without requeueing
the request and the request will be lost.  No?

> So are you OK for this patch to go in?

Yeah yeah, I think those patches are okay by themselves and am just
trying to find out whether anything similar is missing, in which case
the requeue might fit better somewhere higher in the call chain.

Thanks.

-- 
tejun
