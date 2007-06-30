From: Jeff Garzik <jeff@garzik.org>
Subject: Re: device error via SDB FIS
Date: Sat, 30 Jun 2007 17:46:47 -0400
Message-ID: <4686CF47.5070409@garzik.org>
References: <46868E82.8010906@dschroeder.info> <4686C9A7.1070309@garzik.org> <4686CE2A.5070307@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38504 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbXF3Vqt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 17:46:49 -0400
In-Reply-To: <4686CE2A.5070307@dschroeder.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Schroeder <sec@dschroeder.info>
Cc: linux-ide@vger.kernel.org

Daniel Schroeder wrote:
> 
>>> ata3.00: exception Emask 0x0 SAct 0x2ef SErr 0x0 action 0x0
>>> ata3.00: (irq_stat 0x00020002, device error via SDB FIS)
>>> ata3.00: cmd 61/28:30:17:83:68/00:00:1f:00:00/40 tag 6 cdb 0x0 data 
>>> 20480 out
>>>         res 51/04:30:17:83:68/50:04:1f:00:00/40 Emask 0x1 (device error)
>>
>> Command 0x61 is FPDMA WRITE (NCQ WRITE).
>>
>> Error 0x04 is 'command aborted'.
>>
>> Not much the driver can do but follow what the device is telling us...
>>
>> If you disable NCQ, presumably this should go away.

> thanks for your explanation, i will monitor this drive and disable ncq 
> if it happens again


I should have added:  given your report, it sounds like the error 
handling code took appropriate action for your error.  It should 
continue transferring data (though perhaps not in NCQ mode anymore). 
HOPEFULLY all you see is a nasty message when the drive complains :)

If that is not the case, if you are seeing data transfer suddenly cease 
(or worse, data corruption) please do speak up...

	Jeff


