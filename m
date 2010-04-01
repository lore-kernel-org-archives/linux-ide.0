From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 1 Apr 2010 15:54:54 +0800
Message-ID: <20100401075454.GA22417@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org> <20100401055455.GA20865@gondor.apana.org.au> <4BB43C6E.3050900@kernel.org> <20100401063218.GB21284@gondor.apana.org.au> <4BB43F3B.6000801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:60939 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796Ab0DAHzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 03:55:04 -0400
Content-Disposition: inline
In-Reply-To: <4BB43F3B.6000801@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 03:37:47PM +0900, Tejun Heo wrote:
>
> It was the asymmetry between the two paths that bothered me and made
> me think there should be something else wrong.  So, the problem is
> ide_dma_timeout_retry(), which is used only by ide_timer_expiry(),
> clearing hwif->rq, right?  Then, wouldn't not clearing hwif->rq in
> ide_dma_timeout_retry() a better solution?

I don't think that works.  We want to requeue regardless of whether
we return ide_stopped.  If you don't clear hwif->rq and rely on the
parent to do it then it'll only requeue when we return ide_stopped.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
