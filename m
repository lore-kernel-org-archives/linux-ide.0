From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 08:18:40 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040613221840.GA31354@gondor.apana.org.au>
References: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au> <200406132001.44262.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arnor.apana.org.au ([203.14.152.115]:23564 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261234AbUFMWS4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jun 2004 18:18:56 -0400
Content-Disposition: inline
In-Reply-To: <200406132001.44262.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 08:01:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> This makes ordering of IDE devices different in Debian-2.6
> and vanilla 2.4/2.6, doesn't sound like a good thing to do.

If IDE is built-in, the ordering is exactly the same.

> Ideally ordering should be controlled by user-space. :-)

If IDE is built as a module, then the ordering is still controlled
by user space.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
