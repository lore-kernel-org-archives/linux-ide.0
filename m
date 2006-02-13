From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: add per-device max_sectors
Date: Sun, 12 Feb 2006 23:58:07 -0500
Message-ID: <43F011DF.6020203@pobox.com>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:27871 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751621AbWBME6W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 23:58:22 -0500
In-Reply-To: <43EFD73D.4070207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>>
>> applied 3-4, though note that the Axboe code mentioned in the comment 
>> is now in the kernel, so lba48 can be fixed properly.
>>
> 
> Care to tell me which commit it was?  I don't really understand the 
> comment.

max_sectors was artificially clipped by the driver due to a system 
inadequacy:  if it truly built commands of 65,536 sectors, then for a 
full queue, I/O in flight would lock down way too much system memory. 
Hence, 1024, 2048, 4096 is an arbitrary figure chosen to balance large 
per-command data size (desireable) and pinned memory (minimize).

The solution was to separate max_sectors -- the maximum we should attach 
to each command -- with max_hw_sectors, the absolute hardware limit. 
The system will tune max_sectors up and down, within the max_hw_sectors 
limit.

Search the kernel changelog for max_hw_sectors.

	Jeff



