From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 1 Apr 2010 13:54:55 +0800
Message-ID: <20100401055455.GA20865@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:47718 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752545Ab0DAFzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 01:55:06 -0400
Content-Disposition: inline
In-Reply-To: <4BB42795.5070008@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 01:56:53PM +0900, Tejun Heo wrote:
>
> OIC.  It's also cleared in ide_timer_expiry() too.  Asymmetry among
> different failure paths worries me.  e.g. looking at the code, I can't
> find how ide_error() would requeue the request either.  It looks like
> each hwif->rq = NULL in failure path should be investigated and the
> affected ones should be replaced with a function which requeues and
> clears hwif->rq.  Hmmm.... am I misunderstanding something?

I had a look at the rest of them and they seemed to be fine.

So are you OK for this patch to go in?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
