From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Mon, 02 Feb 2009 10:07:43 +1100
Message-ID: <1233529663.18767.63.camel@pasglop>
References: <1233294371.18767.23.camel@pasglop>
	 <1233313678.18767.25.camel@pasglop> <200902011744.07794.bzolnier@gmail.com>
	 <1233528552.18767.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50385 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbZBAXHt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Feb 2009 18:07:49 -0500
In-Reply-To: <1233528552.18767.62.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Mon, 2009-02-02 at 09:56 +1100, Benjamin Herrenschmidt wrote:
> > Yeah my bad, though thanks to Andreas Schwab it is fixed in -rc3.
> 
> Hrm... I was using rc3 here and had the bug. I'll dig to check it's
> really that or something else and send a patch if needed.

Ok so the test I did was just before -rc3, I just dbl checked and actual
-rc3 does indeed fix it.

I'll look at doing some of the proposed cleanups for the next merge
window.

Cheers,
Ben.


