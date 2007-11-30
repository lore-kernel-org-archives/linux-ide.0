From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Thu, 29 Nov 2007 18:03:22 -0600
Message-ID: <474F534A.2010500@shaw.ca>
References: <fa.hz1AWBbuhaxCXiVbvWdM1r83meE@ifi.uio.no>
 <fa.fUEfthqYoWrlov4j7OjtVSgx42g@ifi.uio.no>
 <fa.qGibmi9xfm4JHJhvn0KM4rdFM+M@ifi.uio.no>
 <fa.YcQmwdppCKfJhxSMgOb0RJPmHg8@ifi.uio.no>
 <fa.0muxGr+d7CjnQ/J5GaB+TSqouuU@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:46674 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbXK3AD1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 19:03:27 -0500
In-reply-to: <fa.0muxGr+d7CjnQ/J5GaB+TSqouuU@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Tejun Heo <htejun@gmail.com>, Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Phillip Susi wrote:
> Tejun Heo wrote:
>> Agreed.  Nobody cared on ATA controllers is usually very effective at
>> taking the whole machine down.  Is there any reason why we don't turn on
>> irqpoll on turned off IRQs automatically?
> 
> Why does a single spurious interrupt cause it to be shut down?  I can 
> see if the interrupt is stuck on and keeps interrupting constantly, but 
> if it's just the occasional spurious interrupt, why not just ignore it 
> and move on?

I'm not certain offhand, but I think there may be such a threshold. 
However, an occasional spurious interrupt isn't likely. For a 
level-triggered interrupt, an unhandled interrupt will keep interrupting 
forever since nobody knows how to clear it (until we decide to disable 
the IRQ entirely).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

