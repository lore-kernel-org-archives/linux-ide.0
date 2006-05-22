From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Random libata comments...
Date: Mon, 22 May 2006 19:55:10 -0400
Message-ID: <44724F5E.1050007@garzik.org>
References: <447248B9.6040304@garzik.org> <44724D4E.5010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39843 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751303AbWEVXzM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 19:55:12 -0400
In-Reply-To: <44724D4E.5010506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>>
>> * I agree with others that using the "ata_drive_probe_reset" can lead 
>> to confusion on the uses of the word "drive".  Replacing that with 
>> "do" or something else would be nice.
> 
> Will do.
> 
>> * As the ata_drive_probe_reset argument list continues to grow, I lean 
>> more and more towards moving all those function pointers to struct 
>> ata_port_operations.  One of the problems with the drivers/ide layer 
>> IMO is that the list of all hooks used is not immediately clear upon 
>> first read, whereas with libata it is clear -- with the notable 
>> exception of ata_drive_probe_reset().
> 
> ->error_handler() takes over all of ata_drive_probe_reset() after 
> hotplug patchset and all ->probe_reset() related stuff are killed.  The 
> same applies to ->error_handler() though.  I agree with you that the 
> arguments are ugly, but also there are already too many non-essential 
> operations in ata_port_operations.  I was hoping something can be done 
> to resolve both issues.
> 
> I'm okay with moving reset ops into ata_port_operations but we need to 
> do more than that, IMHO.

For one example of that, BMDMA-specific operations need to be moved out 
of ata_port_operations, to a BMDMA-driver-specific API.  Ultimately 
libata should be a high level ->qc_issue/ata_qc_complete() style API 
exclusively.

	Jeff



