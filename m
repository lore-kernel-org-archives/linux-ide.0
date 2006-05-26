From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/14] libata-hp-prep: update ata_scsi_find_dev() and
 friends
Date: Fri, 26 May 2006 03:07:10 -0400
Message-ID: <4476A91E.2040900@pobox.com>
References: <11480445841836-git-send-email-htejun@gmail.com> <446DDE41.9040900@pobox.com> <44731B68.6050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60099 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751328AbWEZHHZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 03:07:25 -0400
In-Reply-To: <44731B68.6050803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Separate out ata_find_dev() and __ata_scsi_find_dev() from
>>> ata_scsi_find_dev().  ata_find_dev() checks ATA_FLAG_SLAVE_POSS for
>>> id==1 case, so all three functions return NULL if id==1 is specified
>>> for !SLAVE_POSS port.  These will be used by later hotplug
>>> implementation.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ACK with future comment:
>>
>> Once we have a better way to sequence simplex + master/slave + normal 
>> SATA, libata-scsi should move to exporting one Scsi_Host per 
>> controller, with each physical ATA bus being a scsi channel.
> 
> I think the 'better way' would be implemented after we move to new block 
> infrastructure (libstorage).  libstroage will probably deal with the 
> mentioned command scheduling with queue grouping and associated 
> scheduling mechanism, and SCSI mapping will be done by SATL.  Although 
> mapping port id to channel fits better, I'm not sure whether the 
> conversion would be worthwhile at that point. It wouldn't make any 
> functional difference but the change would be visible to userspace.
> 
> If we're gonna do that, how about piggybacking ataX -> ataX-1 change 
> with/around it?  It also is a user-visible change and the magnitude of 
> affect on user space would be similar.

Sure...

	Jeff



