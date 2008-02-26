From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Wed, 27 Feb 2008 10:16:17 +1100
Message-ID: <1204067777.15052.182.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop>
	 <47C43D7F.3010005@rtr.ca>  <47C4439E.2000606@rtr.ca>
	 <1204062649.15052.164.camel@pasglop>
	 <1204063001.3254.96.camel@localhost.localdomain>
	 <1204065001.15052.177.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54416 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760762AbYBZX22 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 18:28:28 -0500
In-Reply-To: <1204065001.15052.177.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>


> And the fact that this will totally blow fragmentation through the roof
> and cause half of the dma-map requests to fail on machines with small
> iommu has been totally ignored I suppose ?

Ok, so after checking those patches more closely, it appears that
alignment will only be enforced for devices that impose segment
boundaries, which means that normal devices can still pack. That
sounds good.

Ben.
 

