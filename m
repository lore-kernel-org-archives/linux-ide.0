From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes 2/4] libata: beef up iterators
Date: Wed, 29 Oct 2008 21:25:19 -0400
Message-ID: <49090CFF.80101@rtr.ca>
References: <49041323.9020309@kernel.org> <4904135B.4040901@kernel.org> <49068E9F.1040308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58810 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbYJ3BZV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Oct 2008 21:25:21 -0400
In-Reply-To: <49068E9F.1040308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> There currently are the following loop constructs.
>>
>> * __ata_port_for_each_link() for all available links
>> * ata_port_for_each_link() for edge links
>> * ata_link_for_each_dev() for all devices
>> * ata_link_for_each_dev_reverse() for all devices in reverse order
>>
>> Now there's a need for loop construct which is similar to
>> __ata_port_for_each_link() but iterates over PMP links before the host
>> link.  Instead of adding another one with long name, do the following
>> cleanup.
>>
>> * Implement and export ata_link_next() and ata_dev_next() which take
>>   @mode parameter and can be used to build custom loop.
>> * Implement ata_for_each_link() and ata_for_each_dev() which take
>>   looping mode explicitly.
>>
>> The following iteration modes are implemented.
>>
>> * ATA_LITER_EDGE        : loop over edge links
>> * ATA_LITER_HOST_FIRST        : loop over all links, host link first
>> * ATA_LITER_PMP_FIRST        : loop over all links, PMP links first
>>
>> * ATA_DITER_ENABLED        : loop over enabled devices
>> * ATA_DITER_ENABLED_REVERSE    : loop over enabled devices in reverse 
>> order
>> * ATA_DITER_ALL            : loop over all devices
>> * ATA_DITER_ALL_REVERSE        : loop over all devices in reverse order
>>
>> This change removes exlicit device enabledness checks from many loops
>> and makes it clear which ones are iterated over in which direction.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> ---
>>  drivers/ata/ahci.c           |    8 -
>>  drivers/ata/ata_generic.c    |    5 -
>>  drivers/ata/libata-acpi.c    |   19 +---
>>  drivers/ata/libata-core.c    |  183 
>> ++++++++++++++++++++++++++++---------------
>>  drivers/ata/libata-eh.c      |   84 ++++++++-----------
>>  drivers/ata/libata-pmp.c     |   22 ++---
>>  drivers/ata/libata-scsi.c    |   22 ++---
>>  drivers/ata/pata_it821x.c    |   34 +++----
>>  drivers/ata/pata_ixp4xx_cf.c |   14 +--
>>  drivers/ata/pata_legacy.c    |   17 +--
>>  drivers/ata/pata_pdc2027x.c  |   27 ++----
>>  drivers/ata/pata_platform.c  |   14 +--
>>  drivers/ata/pata_rz1000.c    |   16 +--
>>  drivers/ata/sata_sil.c       |    2  include/linux/libata.h       |   
>> 50 +++++++----
>>  15 files changed, 279 insertions(+), 238 deletions(-)
> 
> ACK... for 2.6.29.  I think this is too much change for -rc2.  It's a 
> good idea though.
> 
> Also, it could use more documentation than just the commit message... 
> something that programmers can easily refer to (header file comment?)
..

Yeah.  Especially a reminder of what "LITER" and "DITER" stand for!  :)

Cheers
