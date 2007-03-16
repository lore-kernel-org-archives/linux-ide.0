From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 11:23:04 -0400
Message-ID: <45FAB658.70408@garzik.org>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk> <45F9A9A3.8050800@garzik.org> <45FA29C6.4070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59543 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbXCPPXI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:23:08 -0400
In-Reply-To: <45FA29C6.4070601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> nudge the controller into the ADMA mode.  Is ADMA some kind of
> standardized programming interface?

Yes.  Search for "ADMA" on the linux-ata.org developer resources page: 
http://linux-ata.org/devel.html

Both PDC and NVIDIA based their stuff off of ADMA.  PDC's is closer to 
the standard, though both are pretty darn close.

	Jeff


