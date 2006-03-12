From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Random libata notes
Date: Sat, 11 Mar 2006 20:35:08 -0500
Message-ID: <44137ACC.4020508@garzik.org>
References: <4409CF74.7030808@garzik.org> <44118B3D.9040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43449 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751417AbWCLBfK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 20:35:10 -0500
In-Reply-To: <44118B3D.9040103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> These are small TODO bits that I didn't want to forget...  Patches 
>> welcome.
>>
>> 1) ATAPI edge case.  Due to adding the padding s/g entry, we must 
>> adjust sg_tablesize to include ' - 1' for each driver
> 
> 
> Isn't this handled by ata_scsi_slave_config()? If the attached device is 
> ATAPI, ata_scsi_slave_config() reduces max_hw_segments by 1. We'll need 
> to increment it back when detaching the device though.

Yes, you're right.

	Jeff


