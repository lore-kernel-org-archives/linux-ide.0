From: Tejun Heo <tj@kernel.org>
Subject: Re: ide: Requeue request after DMA timeout
Date: Thu, 01 Apr 2010 17:26:37 +0900
Message-ID: <4BB458BD.20700@kernel.org>
References: <20100331061731.GA11480@gondor.apana.org.au> <4BB40D4C.7010204@kernel.org> <20100401043201.GA20470@gondor.apana.org.au> <4BB42795.5070008@kernel.org> <20100401055455.GA20865@gondor.apana.org.au> <4BB43C6E.3050900@kernel.org> <20100401063218.GB21284@gondor.apana.org.au> <4BB43F3B.6000801@kernel.org> <20100401075454.GA22417@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49535 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242Ab0DAI1D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2010 04:27:03 -0400
In-Reply-To: <20100401075454.GA22417@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Hello,

On 04/01/2010 04:54 PM, Herbert Xu wrote:
> On Thu, Apr 01, 2010 at 03:37:47PM +0900, Tejun Heo wrote:
>>
>> It was the asymmetry between the two paths that bothered me and made
>> me think there should be something else wrong.  So, the problem is
>> ide_dma_timeout_retry(), which is used only by ide_timer_expiry(),
>> clearing hwif->rq, right?  Then, wouldn't not clearing hwif->rq in
>> ide_dma_timeout_retry() a better solution?
> 
> I don't think that works.  We want to requeue regardless of whether
> we return ide_stopped.  If you don't clear hwif->rq and rely on the
> parent to do it then it'll only requeue when we return ide_stopped.

Yeap, which applies the same to the other failure path too.  I think
back then I repeated the same mistake I did in this thread -
ie. thinking ide_stopped indicates the state of the request.  It seems
the error path needs audit and more comprehensive fix unless I'm
mistaken yet again, which definitely is a possbility.  :-)

If you're interested in fixing the request requeueing in error path
properly, please go ahead.  If not, I'll give it a shot this in a few
days.

David, in the meantime, although I'm not quite sure the fix is
comprehensive yet, the patches definitely fix some of the issues.  So,
I have no objection to applying them.

Thanks for your patience.

-- 
tejun
