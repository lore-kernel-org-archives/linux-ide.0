From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 13 Apr 2006 12:07:21 -0400
Message-ID: <443E7739.9080706@pobox.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <1144914838.19687.18.camel@localhost.localdomain> <443E1082.6080703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45775 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751027AbWDMQHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 12:07:36 -0400
In-Reply-To: <443E1082.6080703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> zhao, forrest wrote:
>> On Tue, 2006-04-11 at 23:14 +0900, Tejun Heo wrote:
>>
>>> Warm unplug/plug comes at almost no cost for LLDDs implementing new EH
>>> - adding a call to ata_eh_hotplug() at the end of ->error_handler is
>>> enough (even this is unnecessary if it's using bmdma error_handler).
>>> e.g. ata_piix isn't changed by hotplug patchsets at all but still
>>> supports warm plugging (even PATA warm plugging works although it's
>>> electronically unsafe).
>>>
>>> To support full hot unplug/plug, all a LLDD has to do are enabling PHY
>>> status changed interrupt and, when PHY RDY status changes, call
>>> ata_schedule_probe() and schedule EH.  ahci, sata_sil and sata_sil24
>>> are converted this way and hotplugging works perfectly for those
>>> drivers.
>>>
>> In order to make ata_eh_hotplug() called, LLDD have to schedule EH
>> in its interrupt handler(i.e. invoke scsi_eh_schedule_host() directly
>> or indirectly), but I didn't find such code in your patch set.
>> Did I miss anything?
>>
> 
> The last three patches do that.  All hotplug interrupts end up invoking
> EH by calling ata_eh_schedule_port(ap, ATA_EH_FREEZE).

It's certainly nicer and more readable, if the LLDD calls a function
like ata_eh_hotplug().

	Jeff



