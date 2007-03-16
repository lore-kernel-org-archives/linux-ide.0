From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 11:21:40 -0400
Message-ID: <45FAB604.5070801@garzik.org>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk> <45F9A9A3.8050800@garzik.org> <45FA29C6.4070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59521 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbXCPPVq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:21:46 -0400
In-Reply-To: <45FA29C6.4070601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Oh well, I never got around to get the ADMA mode working.  The sunix
> driver is TF/quasi-BMDMA based (w/o CONTROL register so I'm pretty sure
> they have some problem with LBA48).  The docs[1] I have only have
> register description and nothing about the programming model.  Me being


Does this missing reference "[1]" coincide with the docs list I posted 
yesterday?  Do you have all the docs I listed?

	Jeff


