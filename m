From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 1 Apr 2010 14:32:18 +0800
Message-ID: <20100401063218.GB21284@gondor.apana.org.au>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org> <20100401055455.GA20865@gondor.apana.org.au> <4BB43C6E.3050900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:38941 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753535Ab0DAGcY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 02:32:24 -0400
Content-Disposition: inline
In-Reply-To: <4BB43C6E.3050900@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Thu, Apr 01, 2010 at 03:25:50PM +0900, Tejun Heo wrote:
>
> In ide_timer_expiry() if drive->waiting_for_dma is false, ide_error()
> is called, which in turn calls __ide_error() for fs requests.
> ide_ata_error() will be called if the device is a disk.  If the
> request hasn't reached the retry limit and reset is not necessary,
> ide_ata_error() will return ide_stopped without requeueing the
> request.  ide_timer_expiry() will clear hwif->rq without requeueing
> the request and the request will be lost.  No?

It shouldn't be lost in that case because of the rq_in_flight
thing that you added will catch it and requeue.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
