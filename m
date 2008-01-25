From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Fri, 25 Jan 2008 09:01:01 -0600
Message-ID: <1201273261.3119.4.camel@localhost.localdomain>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com>
	 <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com>
	 <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com>
	 <4799270D.3010009@rtr.ca> <4799285F.3060308@gmail.com>
	 <47995EFD.8030102@rtr.ca> <479960DB.8050109@gmail.com>
	 <479965C1.3070009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:39517 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754149AbYAYPBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 10:01:05 -0500
In-Reply-To: <479965C1.3070009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

On Thu, 2008-01-24 at 23:29 -0500, Mark Lord wrote:
> Tejun Heo wrote:
> > Mark Lord wrote:
> >..
> >> Super!  You've done a great job with this stuff, Tejun!
> > 
> > Thanks but I can't really say nice things about how sata_sil24's
> > qc_defer() is implemented or how we generally handle command deferring.
> >  We really need the control at the higher level - request_queue group.
> > Oh well... I guess you guys will be talking about it over beer again
> > soon.  :-)
> ..
> 
> You too?
> 
> Another one for those beers, is a way to tell the IOMMU code about
> physical segment limitations -- so we can stop having to allocate
> PRD tables 2X as big as necessary in drivers like sata_mv.

If the IOMMU would observe the queue dma_boundary parameter, is that
enough?  (it is for the 64k PRD limit).  If so, there are already
patches in the works to solve this permanently.  If not, could we get
the requirements to see how it might be done?

James


