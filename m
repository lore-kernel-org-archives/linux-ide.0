From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 11:16:50 -0400
Message-ID: <46409462.3060706@garzik.org>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59012 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966249AbXEHPRJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 May 2007 11:17:09 -0400
In-Reply-To: <464073B1.80303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertl@mail.com, albertcc@tw.ibm.com, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Albert, if Jeff agrees with pushing HSM or data transfer to workqueue,
> are you interested in doing that?  The HSM is your baby after all.  :-)


It's always been my desire to do PIO from a workqueue if possible, since 
it is so slow.

	Jeff


