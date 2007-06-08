From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 8 Jun 2007 16:44:43 +0100
Message-ID: <20070608164443.40ada5ca@the-village.bc.nu>
References: <466196AD.3090502@garzik.org>
	<9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com>
	<46667466.4010500@gmail.com>
	<9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com>
	<4667B347.9040900@gmail.com>
	<alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org>
	<20070607224746.GA23290@havoc.gtf.org>
	<46690D10.9040808@gmail.com>
	<20070608143136.GC25649@havoc.gtf.org>
	<20070608163804.4926e499@the-village.bc.nu>
	<20070608153513.GE25649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41132 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030659AbXFHPje (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 11:39:34 -0400
In-Reply-To: <20070608153513.GE25649@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 8 Jun 2007 11:35:13 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Fri, Jun 08, 2007 at 04:38:04PM +0100, Alan Cox wrote:
> > > See a URL I posted earlier in this thread.  With dumb ATAPI devices we
> > > actually have to wait a bit for BSY to be asserted.  Not only at reset,
> > > but also for every command
> > 
> > 400nS and the current code correctly accounts for it.
> 
> No, _far_ longer than 400nS.  2ms minimum by the spec, but,
> 
> ATADRVR. blackmagic.html and googling around shows plenty of ATAPI
> devices that don't get their shit together for 50-100ms.

400nS is commands. Reset is indeed about 150mS or so if you catch a drive
right - eg in the middle of revalidating a dodgy disk. One or two have
really weird behaviour in that they take MUCH longer to come out of reset
with no media loaded.
