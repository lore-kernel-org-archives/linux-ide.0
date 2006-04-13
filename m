From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Fri, 14 Apr 2006 01:50:32 +0900
Message-ID: <443E8158.40302@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <1144914838.19687.18.camel@localhost.localdomain> <443E1082.6080703@gmail.com> <443E7739.9080706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.198]:62919 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751025AbWDMQuo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 12:50:44 -0400
Received: by xproxy.gmail.com with SMTP id t10so1210455wxc
        for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 09:50:43 -0700 (PDT)
In-Reply-To: <443E7739.9080706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> zhao, forrest wrote:
>>> On Tue, 2006-04-11 at 23:14 +0900, Tejun Heo wrote:
>>>
>>>> Warm unplug/plug comes at almost no cost for LLDDs implementing new EH
>>>> - adding a call to ata_eh_hotplug() at the end of ->error_handler is
>>>> enough (even this is unnecessary if it's using bmdma error_handler).
>>>> e.g. ata_piix isn't changed by hotplug patchsets at all but still
>>>> supports warm plugging (even PATA warm plugging works although it's
>>>> electronically unsafe).
>>>>
>>>> To support full hot unplug/plug, all a LLDD has to do are enabling PHY
>>>> status changed interrupt and, when PHY RDY status changes, call
>>>> ata_schedule_probe() and schedule EH.  ahci, sata_sil and sata_sil24
>>>> are converted this way and hotplugging works perfectly for those
>>>> drivers.
>>>>
>>> In order to make ata_eh_hotplug() called, LLDD have to schedule EH
>>> in its interrupt handler(i.e. invoke scsi_eh_schedule_host() directly
>>> or indirectly), but I didn't find such code in your patch set.
>>> Did I miss anything?
>>>
>> The last three patches do that.  All hotplug interrupts end up invoking
>> EH by calling ata_eh_schedule_port(ap, ATA_EH_FREEZE).
> 
> It's certainly nicer and more readable, if the LLDD calls a function
> like ata_eh_hotplug().
> 

Hi, Jeff.

Currently, a LLDD has to do the following two to schedule hotplug.

* call ata_schedule_probe(ap);
* invoke EH by calling ata_eh_schedule_port(ap, ATA_EH_FREEZE);

Calling ata_schedule_probe() can be done from interrupt handler or
inside EH.  It just has to be done before actual hotplug operation begins.

ata_schedule_probe() can be changed to include a call to
ata_eh_schedule_port() but, as can be seen from three converted drivers,
it isn't really necessary.  Scheduling hotplug is usually done by the
standard ata_eh_autopsy() function in EH after looking at the SError
register.  So, actually, all an interrupt handler has to do is just to
call in to EH if something looks weird.  Standard EH will do all the
jobs for it including scheduling hotplug operation.

Only sata_sil24 calls ata_schedule_probe() explicitly because its SError
is sort of flimsy.  And even that is not done from the interrupt
handler.  It's done by sil24_autopsy() function which is the first thing
sata_sil24 EH does on entry.

So, there really isn't much point in making ata_schedule_port() and
ata_eh_schedule_port() done in one step.  For most controllers, the
latter doesn't need to be called at all and even, when it does, there's
a good chance that it will be done from EH making scheduling EH kind of
silly, still safe though.

Hmmmm... but maybe ata_schedule_hotplug() is a better name than
ata_schedule_probe().  Or ata_eh_schedule_hotplug()?  ata_eh_hotplug()
is already taken by the function which does actual hotplug.

The reason why I chose ata_schedule_probe() was the word 'hotplug' is
currently used to mean both plugging and unplugging operations, and warm
operations too.  It means the general facility to attach and detach
devices dynamically.  So, calling it ata_schedule_hotplug() or something
similar is sort of confusing as some hotplug operations happen whether
the function is called or not.

The terms I've used are...

* hotplug	: as said above, general facility and operations to
		  dynamically add and remove devices, warm or hot.
* attach	: the action of adding a new device
* detach	: the action of removing a device
* probe		: an operation to discover new devices on a port and
		  attach them

Thanks.

-- 
tejun
