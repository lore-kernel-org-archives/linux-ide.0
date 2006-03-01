From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] rate-limit libata-scsi status/error message
Date: Wed, 01 Mar 2006 15:43:07 -0500
Message-ID: <4406075B.5050904@pobox.com>
References: <20060217213733.36040150.rdunlap@xenotime.net> <43F72B70.5040107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26599 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751176AbWCAUnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 15:43:10 -0500
In-Reply-To: <43F72B70.5040107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Randy.Dunlap wrote:
> 
>> From: Randy Dunlap <rdunlap@xenotime.net>
>>
>> Rate-limit a translated ATA status/error message.
>> I have a kernel log that is 2/3 full of these messages
>> due to a CD/DVD drive being empty.
> 
> ...
> 
>> -    printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
>> -           "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
>> -           *sk, *asc, *ascq);
>> +    if (printk_ratelimit())
>> +        printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
>> +            "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n",
>> +            id, drv_stat, drv_err, *sk, *asc, *ascq);
> 
> 
> That message shouldn't even be enabled for non DEBUG cases.
> I suspect Jeff will remove it for 2.6.17..

Kinda sorta:  ATAPI errors are still shaking out, in a big way.  Under 
ATA, almost any error should be reported.  Under ATAPI, certain classes 
of errors are quite normal, and should not fill the logs with spam.

The proper fix is to avoid reporting errors for those few ATAPI cases 
that occur in normal operation, rather than ratelimiting all libata 
error messages.

IOW don't report an error, when it isn't really an error...

	Jeff



