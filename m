From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 32-bit IO to-do item...
Date: Thu, 09 Apr 2009 05:48:38 -0400
Message-ID: <49DDC476.3080604@garzik.org>
References: <49DD86D4.3090304@garzik.org> <20090409095415.585cc759@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47233 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763629AbZDIJsm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 05:48:42 -0400
In-Reply-To: <20090409095415.585cc759@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Thu, 09 Apr 2009 01:25:40 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan,
>>
>> I keep meaning to mention this (and get it into the mail archive)... 
>> The 32-bit IO patch was incomplete, because it rendered 
>> ATA_IOC_[GS]ET_IO32 handling in ata_sas_scsi_ioctl() -- our base ioctl 
>> handler -- incorrect.
>>
>> Previously, it simply ensured the ioctls reflected hardcoded 16-bit I/O. 
>>   Now, behavior no longer matches what the ioctls report.
>>
>> At a minimum, drivers probably need to set an "I'm using 32bit I/O" 
>> flag, that the ioctl then reads, replacing ata_sas_scsi_ioctl()'s 
>> assumption that val==0.
> 
> Put onto my TODO list. I missed the fact you were even faking that
> rather bogus ioctl (what for example does a PIO over DMA device claim ??)

Probably as a result of a questionable choice to create new named 
constants ATA_IOC_* as a replacement for existing constants HDIO_*  I 
did that to avoid including linux/hdreg.h -- something we quickly wound 
up doing anyway.

I'd say pio-over-dma returns '1', so as to imply '0' meaning boring, 
slow, legacy compatible 16-bit I/O.  But it's a good question....

	Jeff


