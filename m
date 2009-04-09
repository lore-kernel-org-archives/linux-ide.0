From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 32-bit IO to-do item...
Date: Thu, 09 Apr 2009 07:03:03 -0400
Message-ID: <49DDD5E7.3080706@garzik.org>
References: <49DD86D4.3090304@garzik.org>	<20090409095415.585cc759@lxorguk.ukuu.org.uk>	<49DDC476.3080604@garzik.org> <20090409112200.4830f5c2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35199 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbZDILDI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 07:03:08 -0400
In-Reply-To: <20090409112200.4830f5c2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> I'd say pio-over-dma returns '1', so as to imply '0' meaning boring, 
>> slow, legacy compatible 16-bit I/O.  But it's a good question....
> 
> And 8bit transfers ?
> 
> The more I look at this the more I think we should just admit it was a
> dumb interface and do something different. To start with do we mean the
> controller-disk transfer is 32bit (meaningful only in some early proto
> IDE stuff), or the controller-fifo transfer is 32bit (which is
> meaningless as actually its posted)

Sure it's a dumb interface, it's a legacy ioctl...  :)  We do the best 
we can with a legacy interface.

On a more general level, sure, libata sorely lacks a control interface 
for twiddling host controller features, or even device xfer modes.

	Jeff




