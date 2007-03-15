From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 16:16:35 -0400
Message-ID: <45F9A9A3.8050800@garzik.org>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52419 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933790AbXCOUQj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 16:16:39 -0400
In-Reply-To: <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> both the reading and writing are seriously broken.  I can't tell whether
>> they end up in the wrong sectors or garbage is transferred to/from the
>> right sectors.
> 
> Does this occur regardless of which interface you use (the register
> shadow or the DMA command engine ?)

I'm curious of this as well.

	Jeff



