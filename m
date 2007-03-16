From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 14:55:25 +0000
Message-ID: <20070316145525.6d81acbb@lxorguk.ukuu.org.uk>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
	<45F9851E.8000709@gmail.com>
	<20070315191639.7aadf9a3@lxorguk.ukuu.org.uk>
	<45F9A9A3.8050800@garzik.org>
	<45FA29C6.4070601@gmail.com>
	<45FA8C4B.4010101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52247 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933773AbXCPNwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 09:52:23 -0400
In-Reply-To: <45FA8C4B.4010101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Bob Stewart <bob@evoria.net>, linux-ide@vger.kernel.org

On Fri, 16 Mar 2007 08:23:39 -0400
Mark Lord <liml@rtr.ca> wrote:

> Tejun Heo wrote:
> > IIRC, I couldn't nudge the controller into the ADMA mode.
> > Is ADMA some kind of standardized programming interface?

ADMA is documented in the same place as the SFF PCI interface and you'll
find it on the t13 website if I remember rightly
