From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Thu, 13 May 2004 17:44:38 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A3EC46.4050909@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9> <40A3E595.8000003@pobox.com><40A3E7E5.	6060403@pobox.com> <1084484186.4524.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264352AbUEMVow
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 17:44:52 -0400
In-Reply-To: <1084484186.4524.3.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>Are you willing to work 
> 
> 
> Yes I want to learn.
> 
> I figure I can learn fastest by helping.
> 
> 
>>on a separate, pre-requisite patch:
>>
>>We need to split ata_bmdma_start_{pio,mmio} into separate "setup" and 
>>"start" pieces.
>>
>>This would involve adding a "bmdma_setup" hook to struct 
>>ata_port_operations in include/linux/libata.h, and then doing a simple
>>update of all the SATA drivers, to use the default libata-core 
>>implementations.
> 
> 
> Sorry as yet I understand very little of the above.
> 
> Until corrected I will guess I should next:


> 4) Report back here for next assignment.

hehe

The above is something that applies to all of libata, and changes the 
libata API so that ATAPI is doable.

It looks something like:

1) add ->bmdma_setup hook to include/linux/libata.h
2) walk through each of drivers/scsi/*ata_*.c and make an adjustment 
like the following:

		.bmdma_start:	ata_bmdma_start_mmio,
	+	.bmdma_setup:	ata_bmdma_setup_mmio,

3) create new functions ata_bmdma_setup_{mmio,pio}.

4) move EVERYTHING except the final writeb() from ata_bmdma_start_mmio 
to ata_bmdma_setup_mmio.

5) do the same for ata_bmdma_{start,setup}_pio.

at this point, it is highly likely that sata_promise.c and sata_sx4.c 
are broken, but the other drivers should work 100%.

for bonus points,

6) fix sata_promise and sata_sx4

otherwise I can do that.



The only hardware required for this task is a SATA hard drive and SATA 
host controller.

	Jeff



