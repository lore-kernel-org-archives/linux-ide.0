From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 14:01:13 +0200
Message-ID: <463F1509.30100@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com> <463ED8B9.4060501@gmail.com> <463F0B25.40103@tw.ibm.com> <463F0DAD.5060307@gmail.com> <463F1374.1010100@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:28465 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388AbXEGMB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 08:01:29 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1520872nzf
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 05:01:28 -0700 (PDT)
In-Reply-To: <463F1374.1010100@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

Albert Lee wrote:
>> Good to know it works.  With or without nIEN, I think this change is a
>> good thing to have.  IRQ handler shouldn't interfere with polling as
>> both acquire lock during operation. 
> 
> This reminds me of a possible issue with the patch:
> Previously the polling code assumes that the interrupt handler won't interfere
> with it and the polling code runs without holding ap->lock.
> However, with the above patch, the interrupt handler might read the
> Status register when the polling code is transfering data, etc. from the port.
> Would this cause trouble to the ATA/ATAPI devices?
> 
> Should we have something like ATA_PFLAG_HSM_BUSY below, such that the interrupt
> handler won't read the Status register when HSM is busy accessing the port?

Right, I forgot about that.  Wouldn't just grabbing port lock during PIO
be simpler?  There is some downside (IRQ latency) but also there are
controllers which get upset if PIO data transfer is interrupted by IRQ
from other devices.

-- 
tejun
