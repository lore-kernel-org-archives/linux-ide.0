From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix HPA handling regression
Date: Fri, 28 Sep 2007 21:03:29 -0400
Message-ID: <46FDA461.9080804@garzik.org>
References: <20070926180222.10a96afe@the-village.bc.nu> <46FD0231.2020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46913 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbXI2BDf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 21:03:35 -0400
In-Reply-To: <46FD0231.2020002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, akpm@osdl.org

Tejun Heo wrote:
> Alan Cox wrote:
>> Restore the support for handling drives that report one sector too many
>> (ie SCSI not ATA style). This worked before the HPA update but was
>> removed in that process
>>
>> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 
>> diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.23rc8-mm1/include/linux/libata.h linux-2.6.23rc8-mm1/include/linux/libata.h
>> --- linux.vanilla-2.6.23rc8-mm1/include/linux/libata.h	2007-09-26 16:46:57.844875296 +0100
>> +++ linux-2.6.23rc8-mm1/include/linux/libata.h	2007-09-26 17:11:56.215088400 +0100
>> @@ -315,7 +315,8 @@
>>  	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
>>  	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
>>  	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
>> -	ATA_HORKAGE_DRQ		= (1 << 5),	/* Device forgets to clear DRQ on error */
>> +	ATA_HORKAGE_HPA_SIZE	= (1 << 5), 	/* Reports native size off by one */
>> +	ATA_HORKAGE_DRQ		= (1 << 6),	/* Device forgets to clear DRQ on error */
>>  
>>  	/* DMA mask for user DMA control: User visible values do not
>>  	   renumber */
> 
> But Jeff might not like adding new constant and shifting the existing
> one at the same time.

That's definitely annoying and unnecessary patch noise...

	Jeff


