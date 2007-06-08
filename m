From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Fri, 8 Jun 2007 16:36:15 +0100
Message-ID: <20070608163615.3177dd9a@the-village.bc.nu>
References: <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com>
	<46667466.4010500@gmail.com>
	<9d2cd630706062322v2d73b32dp1da56f97e2069fff@mail.gmail.com>
	<4667B347.9040900@gmail.com>
	<alpine.LFD.0.98.0706071352440.4205@woody.linux-foundation.org>
	<20070607224746.GA23290@havoc.gtf.org>
	<46690D10.9040808@gmail.com>
	<20070608122750.7f8ae0e0@the-village.bc.nu>
	<46693E33.6080705@gmail.com>
	<20070608124058.7948dee1@the-village.bc.nu>
	<20070608142822.GB25649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47735 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764057AbXFHPbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 11:31:05 -0400
In-Reply-To: <20070608142822.GB25649@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 8 Jun 2007 10:28:22 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Fri, Jun 08, 2007 at 12:40:58PM +0100, Alan Cox wrote:
> > Seems best to me - we know the current code breaks a load of systems and
> > the change should not break anything but fix them all. If we ship without
> > it being changed then a load of people are stuck with broken ATA.
> 
> So you have verified that Tejun's experimental change "fixes them all"?
> 
> Proof?  Bugzilla URLs pointing to users that have ack'd this fix?

It unbreaks the IT821x, see the proposed patches I sent before for
discussion. Those are tested and do work. I've got a test case here and
its the case that the IT821x card doesn't get the magic trickery you rely
on right.

Alan


