From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data
 xfer functions
Date: Fri, 11 May 2007 16:12:52 +0100
Message-ID: <20070511161252.14b61207@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
	<20070508132046.70a4d9ed@the-village.bc.nu>
	<46406C9A.4000802@gmail.com>
	<20070508134540.509f4704@the-village.bc.nu>
	<464073B1.80303@gmail.com>
	<4644192A.8090809@tw.ibm.com>
	<46441CA9.4030109@tw.ibm.com>
	<46447FB5.3040306@gmail.com>
	<20070511155504.37e12a12@the-village.bc.nu>
	<46448469.7070704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36863 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757655AbXEKPIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 11:08:44 -0400
In-Reply-To: <46448469.7070704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> > I'd say this is a non-starter. It solves nothing and means PIO in libata
> > is still basically unusable.
> 
> It doesn't solve the problem completely but still helps, FWIW.  I was

Most transfers for PIO are a single 512 byte transfer per command.

> hoping we could lock only for the last transfer (word).  Would it
> complicate ->data_xfer() too much?

I don't think so. We need to complicate it far more to add 32bit
transfers. We also only have a few ->data_xfer implementations so its
easy to propogate the chance.

Why do we need the lock on the last word transferred anyway. I'm missing
a detail here ?
