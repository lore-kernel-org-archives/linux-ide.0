From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Tue, 15 Jun 2004 07:29:39 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040614212939.GA19812@gondor.apana.org.au>
References: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au> <200406132001.44262.bzolnier@elka.pw.edu.pl> <20040613221840.GA31354@gondor.apana.org.au> <200406141637.27492.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arnor.apana.org.au ([203.14.152.115]:38925 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264443AbUFNVaG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 17:30:06 -0400
Content-Disposition: inline
In-Reply-To: <200406141637.27492.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:37:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> I'm lost now, so what is your change exactly supposed to do?

The change is only effective when IDE is built as a module.  It allows
you the option to have the same probing order as if IDE was built-in.

Without the patch it always probes the device as soon as each PCI driver
is loaded.  And you can still do that as long as ide-generic is loaded
before the PCI drivers.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
