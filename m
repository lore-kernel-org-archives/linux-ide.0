From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 13:52:03 +1100
Message-ID: <1203994323.15052.79.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop>  <47C36D64.6010001@rtr.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57313 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbYBZCxR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 21:53:17 -0500
In-Reply-To: <47C36D64.6010001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


> The block layer uses seg_boundary_mask to ensure that we never have
> to split them again in the LLD.
> 
> A very long time ago, when I wrote the IDE DMA code, this was not the case.

Not good enough, still, because the boundaries can change due to the
iommu merging, thus the split must be re-done.

Ben.


