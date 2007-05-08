From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Tue, 08 May 2007 09:42:12 -0400
Message-ID: <46407E34.7030800@rtr.ca>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com> <20070507152856.5e817490@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3877 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967406AbXEHNmO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 May 2007 09:42:14 -0400
In-Reply-To: <20070507152856.5e817490@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com

Alan Cox wrote:
>> This reminds me of a possible issue with the patch:
>> Previously the polling code assumes that the interrupt handler won't interfere
>> with it and the polling code runs without holding ap->lock.
>> However, with the above patch, the interrupt handler might read the
>> Status register when the polling code is transfering data, etc. from the port.
>> Would this cause trouble to the ATA/ATAPI devices?
> 
> Oh yes, and also some controllers will corrupt their data stream if you
> do this during a PIO transfer of a block of ATA data.

I also believe that to be true, but don't know exactly which hardware
has that issue.

On the other hand, if we don't read the status from the IRQ handler,
then how does the IRQ get cleared ????

This whole thing is quite messy.
