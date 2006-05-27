From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata resume improvements
Date: Sat, 27 May 2006 16:12:28 -0400
Message-ID: <4478B2AC.4090508@garzik.org>
References: <20060527055533.GA5159@havoc.gtf.org> <4478B236.7000007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5776 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964956AbWE0UMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:12:31 -0400
In-Reply-To: <4478B236.7000007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> This is an example of how one might make sure the ATA bus reaches
>> bus-idle, before attempting to talk to it.
>>
>> It compiles, but is completely untested...
>>
>> Other resume improvements should work at the pci_driver::resume level as
>> this does, _not_ the SCSI->ATA->resume device level.
>>
>>
>> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
> ...
> 
> Sorry to say, but no user-visible difference from previous attempts.
> Still fails the same way, after a 30-ish second timeout on resume.

Thanks again for testing, though I think more recent of the flurry of 
patches invalidated this patch :/  Nonetheless, its useful as a data point.

	Jeff



