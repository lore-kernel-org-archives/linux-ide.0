From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: hard resetting port
Date: Wed, 14 Nov 2007 11:11:37 -0500
Message-ID: <473B1E39.8090800@rtr.ca>
References: <473AC34B.8000709@wpkg.org> <473B13D6.3080202@rtr.ca> <473B1617.4010102@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4339 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545AbXKNQLj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 11:11:39 -0500
In-Reply-To: <473B1617.4010102@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
> Mark Lord schrieb:
>> Tomasz Chmielewski wrote:
>>> This are the log entries I saw as I started e2fsck on a 5-disk Linux 
>>> RAID-5 array; all disks connected to a sata_mv controller:
>>>
>>> ata6.00: exception Emask 0x1 SAct 0x0 SErr 0x100000 action 0x6 frozen
>>> ata6.00: edma_err 0x00000084, EDMA self-disable
>> ..
>>
>> Translation:
>> "The port had a link CRC error, which caused it to drop out of 
>> host-queuing mode."
> 
> Is there an online Kernelish-English dictionary anywhere? ;)
..

Unfortunately not.

At some point, we *really* need to convice {Tejun,Jeff} that libata
messages should be simpler, fewer, and more human readable by default,
with perhaps a sysfs flag to re-enable the {Tejun,Jeff}-speak versions.

Cheers
