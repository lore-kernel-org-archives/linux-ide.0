From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA "target mode" (or "Channel-to-Channel" comm mode)
Date: Tue, 03 Mar 2009 11:38:06 -0500
Message-ID: <49AD5CEE.4090303@pobox.com>
References: <49AD34F4.8090008@rtr.ca> <49AD3BA5.3080603@pobox.com>	 <49AD409F.6040102@rtr.ca> <1236096972.3263.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57664 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757161AbZCCQiT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 11:38:19 -0500
In-Reply-To: <1236096972.3263.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

James Bottomley wrote:
> Yes, but SG_IO began life as being entirely SCSI specific, but it's now
> the block packet infrastructure.  I don't think anyone has an objection
> to the SCSI target infrastructure becoming block target
> infrastructure ... the fields can be made optional or more generic to
> further this.  Probably it should speak a generic packet with a protocol
> identifier and let the user space sort out the details.

Agreed...

	Jeff



