From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Thu, 20 Apr 2006 03:44:01 -0400
Message-ID: <44473BC1.2070900@pobox.com>
References: <114476330353-git-send-email-htejun@gmail.com> <1145512872.3417.47.camel@forrest26.sh.intel.com> <20060420071141.GD25726@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61316 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750756AbWDTHoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 03:44:18 -0400
In-Reply-To: <20060420071141.GD25726@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Thu, Apr 20, 2006 at 02:01:12PM +0800, zhao, forrest wrote:
>> Hi, Tejun
>>
>> When testing hotplug and reading your patches, I thought an interrupt
>> lost might occur on AHCI in the following case:
>>
>> 1 system boot up with SATA disk A attached to port 1 and disk B attached
>> to port 2
>> 2 disk B at port 2 is hot-unplugged
>> 3 ata_eh_revive() will execute several round of soft-reset/hard-reset as
>> we observed in dmesg
>> 4 now imagine ata_eh_revive() start to execute the last round of
>> hard-reset, so the code path comes into ata_do_reset(), then into
>> ahci_hardreset()
>> 5 disk B is hot-plugged to port 2, and an interrupt is triggered
>> 6 CPU respond to this interrupt when code path execute between
>> ahci_start_engine(); in ahci_hardreset() and
>> ap->flags &= ~ATA_FLAG_FROZEN; in ata_do_reset();
>> 7 then this interrupt is lost since no EH is scheduled to handle it.
>>
>> I think invoking ata_eh_schedule_port() in ahci_postreset() can fix
>> the problem, is it right?
> 
> Hello, Forrest.
> 
> Yes, you're right.  The problem is that we cannot tell whether such
> interrupts are due to the reset or some other events.  The goal was to
> make sure existing devices are okay on EH completion.  If new devices
> get connected during EH, we might lose the event, which IMHO is okay.
> 
> Maybe this can be solved by merging EH and probe into one.  Probing
> and EH revive are pretty similar in the first place.  I'll think about

Speaking to hotplug specifically, on hardware with plug irqs, it needs 
to do something like

	* receive hotplug interrupt
	* hang out for a while, eating hotplug interrupt events
	  (debounce)
	* revalidate device
	* issue unplug and/or plug to SCSI layer


> that.  But I still think it's okay to lose hotplug interrupt during
> EH.  All the user has to do is simply replug the device or issue
> manual scan.

If losing the hotplug interrupt requires the user to do that, no that's 
definitely not OK...  for a hotplug interrupt during EH, you want to 
stop what you're doing at the nearest opportunity, and start all over 
again revalidating the device.  If its a different device, all the 
accumulated state is flushed.

	Jeff



