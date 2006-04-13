From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 13 Apr 2006 17:49:06 +0900
Message-ID: <443E1082.6080703@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <1144914838.19687.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:16655 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751214AbWDMItR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 04:49:17 -0400
Received: by wproxy.gmail.com with SMTP id i21so1422018wra
        for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 01:49:17 -0700 (PDT)
In-Reply-To: <1144914838.19687.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-04-11 at 23:14 +0900, Tejun Heo wrote:
> 
>> Warm unplug/plug comes at almost no cost for LLDDs implementing new EH
>> - adding a call to ata_eh_hotplug() at the end of ->error_handler is
>> enough (even this is unnecessary if it's using bmdma error_handler).
>> e.g. ata_piix isn't changed by hotplug patchsets at all but still
>> supports warm plugging (even PATA warm plugging works although it's
>> electronically unsafe).
>>
>> To support full hot unplug/plug, all a LLDD has to do are enabling PHY
>> status changed interrupt and, when PHY RDY status changes, call
>> ata_schedule_probe() and schedule EH.  ahci, sata_sil and sata_sil24
>> are converted this way and hotplugging works perfectly for those
>> drivers.
>>
> 
> In order to make ata_eh_hotplug() called, LLDD have to schedule EH
> in its interrupt handler(i.e. invoke scsi_eh_schedule_host() directly
> or indirectly), but I didn't find such code in your patch set.
> Did I miss anything?
> 

The last three patches do that.  All hotplug interrupts end up invoking
EH by calling ata_eh_schedule_port(ap, ATA_EH_FREEZE).

-- 
tejun
