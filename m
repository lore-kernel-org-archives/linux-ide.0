From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 08:23:39 -0400
Message-ID: <45FA8C4B.4010101@rtr.ca>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk> <45F9A9A3.8050800@garzik.org> <45FA29C6.4070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1984 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbXCPMXm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 08:23:42 -0400
In-Reply-To: <45FA29C6.4070601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bob Stewart <bob@evoria.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> IIRC, I couldn't nudge the controller into the ADMA mode.
> Is ADMA some kind of standardized programming interface?

Yes.  Or it was supposed to be.
Just for kicks, try hacking the PCI ID into pdc_adma.c
and see what happens with it there.  That driver does ADMA
for (only) READs & WRITEs, one command at a time.

Cheers
