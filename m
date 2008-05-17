From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Sun, 18 May 2008 02:52:28 +0900
Message-ID: <482F1B5C.2000006@gmail.com>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com> <482F16AB.1040003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:55009 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYEQRwg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 13:52:36 -0400
Received: by rv-out-0506.google.com with SMTP id l9so700463rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 10:52:36 -0700 (PDT)
In-Reply-To: <482F16AB.1040003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> I've been studying things for last two days and discovered a number of 
>> things.  I'll soon post patch series.  Thanks a lot for digging into 
>> PMP stuff.  It's great to have someone else's eyes on this stuff.
> ..
> 
> Yeah.  It really does help when two or more people totally independently
> implement a driver on top of something like that.  For the most part,
> this stuff seems to be working rather well, though.  Good job!
> 
> Gwendal has been complaining to me about undetected drives on PMP
> with sata_mv.  My patchset to fix much of that will be posted here shortly.
> 
> But apparently, even with those fixes, he *still* has troubles,
> though not as bad as before.  I'm trying to get a nice annotated trace
> from him so we can debug that further -- could be due to some of the
> stuff you are looking at too, I suppose.

Issues I've found are...

* PMP r/w timeout is too short.  It's currently 250ms.  This is from
   SIMG PMPs and was mainly to avoid longish sequential multiple timeouts
   when access PMP regs via polled commands which is not the case
   anymore and mv 4140 needs more time occasionally.

* SDB Notify is not masked during fan-out port resets if PMP hasn't been
   reset in that pass.  This causes PMP register access failure because
   SDB Notify is received while PMP register write is in progress for
   fan-out reset.  I missed this because most of my testing was before
   PMP register access was converted to IRQ driven.

* With the above two fixed, this is peripheral but this is what
   triggered the above two on initial probes.  ata_lpm_schedule() is
   called during probe right after SCSI scan is complete which schedules
   EH immediately, reliably triggering above two on certain hardware
   combinations.

* sil3124/32 and mv4140 combination for some reason can't do NCQ
   reliably.  I don't know why.  I'll blacklist it for the time being
   and contact both companies about this.

* recovered errors shouldn't trigger resets.  (this is peripheral too
   with the first two issues fixed).

I have 8 patches to address the above issues && obscure hotplug 
problems.  I'll send the patches once after more testing.

Thanks.

-- 
tejun
