From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Random libata notes
Date: Sat, 11 Mar 2006 20:37:45 -0500
Message-ID: <44137B69.2080107@garzik.org>
References: <4409CF74.7030808@garzik.org> <44118B3D.9040103@gmail.com> <44118E4B.9050401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751426AbWCLBhr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 20:37:47 -0500
In-Reply-To: <44118E4B.9050401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>> Jeff Garzik wrote:
>>
>>> These are small TODO bits that I didn't want to forget...  Patches 
>>> welcome.
>>>
>>> 1) ATAPI edge case.  Due to adding the padding s/g entry, we must 
>>> adjust sg_tablesize to include ' - 1' for each driver
>>
>>
>>
>> Isn't this handled by ata_scsi_slave_config()? If the attached device 
>> is ATAPI, ata_scsi_slave_config() reduces max_hw_segments by 1. We'll 
>> need to increment it back when detaching the device though.
>>
>>>
>>> 2) ata_scsi_slave_config() hardcodes a call to
>>> blk_queue_max_phys_segments(, LIBATA_MAX_PRD), when the value passed
>>> should not be so limited on nice hardware like AHCI.
> 
> 
> And, AFAICS, we can increase max_phys_segments all we want. This limits 
> the number of segments before IOMMU mapping. The only part that's 
> affected is the driver (software) and I don't see any limitation in 
> libata PIO implementation that puts limitation on the number of sg 
> entries. Simply changing LIBATA_MAX_PRD to 65535 should do it.

We really want to accurately export the correct value for each piece of 
hardware.  It IMO isn't wise to tempt fate with a wide disparity between 
max_phys_segments, max_hw_segments, and real life...  :)

	Jeff



