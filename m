From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Thu, 28 Feb 2008 18:44:57 +1100
Message-ID: <1204184697.15052.379.camel@pasglop>
References: <1204062233.15052.157.camel@pasglop>
	 <20080226230701.GC17241@devserv.devel.redhat.com>
	 <1204067976.15052.185.camel@pasglop>  <20080227233540B.tomof@acm.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58946 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbYB1HqX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 02:46:23 -0500
In-Reply-To: <20080227233540B.tomof@acm.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <tomof@acm.org>
Cc: alan@redhat.com, liml@rtr.ca, jgarzik@pobox.com, htejun@gmail.com, James.Bottomley@HansenPartnership.com, linux-ide@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp


On Thu, 2008-02-28 at 16:36 +0900, FUJITA Tomonori wrote:
> > BTW. If we -still- run out of iommu space, do we have sane
> mechanisms
> > nowadays to break things up and retry ?
> 
> About SCSI, some drivers do the right thing (retrying), some assume
> that IOMMU mapping failure never happens, some just crash. I'll take
> care about it after fixing the IOMMUs.

Thanks for doing this.

Cheers,
Ben.


