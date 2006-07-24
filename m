From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/6] libata-pmp-prep: implement ops->qc_defer()
Date: Mon, 24 Jul 2006 15:21:11 +0900
Message-ID: <44C466D7.5000900@gmail.com>
References: <11523378783771-git-send-email-htejun@gmail.com> <44BE96CA.30008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:13594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751164AbWGXJ4k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:40 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506052pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:06 -0700 (PDT)
In-Reply-To: <44BE96CA.30008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Controllers which support PMP have various restrictions on which
>> combinations of commands are allowed to what number of devices
>> concurrently.  This patch implements ops->qc_defer() which determines
>> whether a qc can be issued at the moment or should be deferred.
>>
>> If the function returns ATA_DEFER_LINK, the qc will be deferred until
>> a qc completes on the link.  If ATA_DEFER_PORT, until a qc completes
>> on any link.  The defer conditions are advisory and in general
>> ATA_DEFER_LINK can be considered as lower priority deferring than
>> ATA_DEFER_PORT.
>>
>> ops->qc_defer() replaces fixed ata_scmd_need_defer().  For standard
>> NCQ/non-NCQ exclusion, ata_std_qc_defer() is implemented.  ahci and
>> sata_sil24 are converted to use ata_std_qc_defer().
>>
>> ops->qc_defer() is heavier than the original mechanism because full qc
>> is prepped before determining to defer it, but various information is
>> needed to determine defer conditinos and fully translating a qc is the
>> only way to supply such information in generic manner.
>>
>> IMHO, this shouldn't cause any noticeable performance issues as
>>
>> * for most cases deferring occurs rarely (except for NCQ-aware
>>   cmd-switching PMP)
>> * translation itself isn't that expensive
>> * once deferred the command won't be repeated until another command
>>   completes which usually is a very long time cpu-wise.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK patches 1-4.
> 
> For this patch (#5), I would much rather prefer to update ->qc_issue() 
> or ->qc_prep() to return a DEFER return value.  That matches more 
> closely other APIs in Linux.

Will do.

-- 
tejun

