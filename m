From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Tue, 08 May 2007 09:36:33 -0400
Message-ID: <46407CE1.8020607@rtr.ca>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com> <20070507121845.5d7cd1f8@the-village.bc.nu> <463F0E43.5090608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3818 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966462AbXEHNgf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 May 2007 09:36:35 -0400
In-Reply-To: <463F0E43.5090608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com

Tejun Heo wrote:
> Alan Cox wrote:
>>> Yeap, this is how IDE deals with polling commands but I'm not sure how
>>> it's supposed to work with PCI IRQ sharing.  Bartlomiej, can you
>>> enlighten me here?
>> Simple answer: Badly. If you've got the IRQ shared it mucks up the
>> behaviour of the other device especially when its doing PIO.
> 
> OIC, I've been thinking I must be missing something but it's just
> supposed to work that way.  Doesn't sound too attractive.  :-(

Yeah.  It's ugly -- designed for use at boot time only, really.

As I've said a few times here, the IDE Subsystem was designed/implemented
*pre-hotplug*, and though it does work well most of the time,
the world has moved on.

Cheers
