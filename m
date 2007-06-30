From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: device error via SDB FIS
Date: Sat, 30 Jun 2007 23:42:02 +0200
Message-ID: <4686CE2A.5070307@dschroeder.info>
References: <46868E82.8010906@dschroeder.info> <4686C9A7.1070309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:59360 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbXF3VmF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 17:42:05 -0400
In-Reply-To: <4686C9A7.1070309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


>> ata3.00: exception Emask 0x0 SAct 0x2ef SErr 0x0 action 0x0
>> ata3.00: (irq_stat 0x00020002, device error via SDB FIS)
>> ata3.00: cmd 61/28:30:17:83:68/00:00:1f:00:00/40 tag 6 cdb 0x0 data 
>> 20480 out
>>         res 51/04:30:17:83:68/50:04:1f:00:00/40 Emask 0x1 (device error)
> 
> Command 0x61 is FPDMA WRITE (NCQ WRITE).
> 
> Error 0x04 is 'command aborted'.
> 
> Not much the driver can do but follow what the device is telling us...
> 
> If you disable NCQ, presumably this should go away.
> 
>     Jeff
> 
> 
> 

thanks for your explanation, i will monitor this drive and disable ncq 
if it happens again

daniel
