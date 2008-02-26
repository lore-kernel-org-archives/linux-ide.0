From: Mark Lord <liml@rtr.ca>
Subject: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 19:02:53 -0500
Message-ID: <47C3572D.1060904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3150 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757558AbYBZAAI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:00:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide>

Jeff,

We had a discussion here today about IOMMUs,
and they *never* split sg list entries -- they only ever *merge*.

And this happens only after the block layer has
already done merging while respecting q->seg_boundary_mask.

So worst case, the IOMMU may merge everything, and then in
libata we unmerge them again.  But the end result can never
exceed the max_sg_entries limit enforced by the block layer.

So.. why are we still specifying .sg_tablesize as half of
what the LLD can really handle?

This can cost a lot of memory, as using NCQ effectively multiplies
everything by 32..

Based on this information, I should be able to do this in sata_mv,
for example:

-      .sg_tablesize           = MV_MAX_SG_CT / 2,
+      .sg_tablesize           = MV_MAX_SG_CT,


???
