From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 16 Mar 2007 14:23:18 +0900
Message-ID: <45FA29C6.4070601@gmail.com>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>	<45F9851E.8000709@gmail.com> <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk> <45F9A9A3.8050800@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48036 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbXCPFXZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 01:23:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so590396uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 22:23:24 -0700 (PDT)
In-Reply-To: <45F9A9A3.8050800@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Alan Cox wrote:
>>> both the reading and writing are seriously broken.  I can't tell whether
>>> they end up in the wrong sectors or garbage is transferred to/from the
>>> right sectors.
>>
>> Does this occur regardless of which interface you use (the register
>> shadow or the DMA command engine ?)
> 
> I'm curious of this as well.

Oh well, I never got around to get the ADMA mode working.  The sunix
driver is TF/quasi-BMDMA based (w/o CONTROL register so I'm pretty sure
they have some problem with LBA48).  The docs[1] I have only have
register description and nothing about the programming model.  Me being
not familiar with ADMA, my try didn't go very far.  IIRC, I couldn't
nudge the controller into the ADMA mode.  Is ADMA some kind of
standardized programming interface?

Ah... another thing to note.  The sata_inic162x uses 0xFF status after
reset before it receives the first D2H Reg FIS from the device thus
making libata believe that there's no device attached to the port.  I
have no idea why they had to use 0xFF for that but they did.  :-(

It seems we'll have to consider 0xFF a valid wait state if SCR is valid
and indicates device presence.  Well, that sounds like a good idea anyway.

Thanks.

-- 
tejun
