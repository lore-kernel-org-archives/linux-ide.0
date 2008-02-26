From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Wed, 27 Feb 2008 08:43:53 +1100
Message-ID: <1204062233.15052.157.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop>
	 <47C43D7F.3010005@rtr.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53706 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365AbYBZV6n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 16:58:43 -0500
In-Reply-To: <47C43D7F.3010005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>


On Tue, 2008-02-26 at 11:25 -0500, Mark Lord wrote:
> That's interesting.  Can you point us to the exact file::lines where
> this happens?  It would be good to ensure that this gets fixed.
> 
> I'm copying Fujita Tomonori on this thread now -- he's the dude who's
> trying to sort out the IOMMU mess.

As I said before, it should not be fixed.

If it's "fixed", we'll run out of iommu space all the time.

We should stop having stupid requirements instead.

Ben.


