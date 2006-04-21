From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Fri, 21 Apr 2006 10:34:37 +0900
Message-ID: <444836AD.1030801@gmail.com>
References: <114476330353-git-send-email-htejun@gmail.com> <1145512872.3417.47.camel@forrest26.sh.intel.com> <20060420071141.GD25726@htj.dyndns.org> <44473BC1.2070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:45239 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932205AbWDUBea (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 21:34:30 -0400
Received: by nz-out-0102.google.com with SMTP id n1so344859nzf
        for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 18:34:29 -0700 (PDT)
In-Reply-To: <44473BC1.2070900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> On Thu, Apr 20, 2006 at 02:01:12PM +0800, zhao, forrest wrote:
>>> Hi, Tejun
>>>
>>> When testing hotplug and reading your patches, I thought an interrupt
>>> lost might occur on AHCI in the following case:
>>>
>>> 1 system boot up with SATA disk A attached to port 1 and disk B attached
>>> to port 2
>>> 2 disk B at port 2 is hot-unplugged
>>> 3 ata_eh_revive() will execute several round of soft-reset/hard-reset as
>>> we observed in dmesg
>>> 4 now imagine ata_eh_revive() start to execute the last round of
>>> hard-reset, so the code path comes into ata_do_reset(), then into
>>> ahci_hardreset()
>>> 5 disk B is hot-plugged to port 2, and an interrupt is triggered
>>> 6 CPU respond to this interrupt when code path execute between
>>> ahci_start_engine(); in ahci_hardreset() and
>>> ap->flags &= ~ATA_FLAG_FROZEN; in ata_do_reset();
>>> 7 then this interrupt is lost since no EH is scheduled to handle it.
>>>
>>> I think invoking ata_eh_schedule_port() in ahci_postreset() can fix
>>> the problem, is it right?
>>
>> Hello, Forrest.
>>
>> Yes, you're right.  The problem is that we cannot tell whether such
>> interrupts are due to the reset or some other events.  The goal was to
>> make sure existing devices are okay on EH completion.  If new devices
>> get connected during EH, we might lose the event, which IMHO is okay.
>>
>> Maybe this can be solved by merging EH and probe into one.  Probing
>> and EH revive are pretty similar in the first place.  I'll think about
> 
> Speaking to hotplug specifically, on hardware with plug irqs, it needs 
> to do something like
> 
>     * receive hotplug interrupt
>     * hang out for a while, eating hotplug interrupt events
>       (debounce)
>     * revalidate device
>     * issue unplug and/or plug to SCSI layer

I see.  I'll pay more attention to the debouncing.

>> that.  But I still think it's okay to lose hotplug interrupt during
>> EH.  All the user has to do is simply replug the device or issue
>> manual scan.
> 
> If losing the hotplug interrupt requires the user to do that, no that's 
> definitely not OK...  for a hotplug interrupt during EH, you want to 
> stop what you're doing at the nearest opportunity, and start all over 
> again revalidating the device.  If its a different device, all the 
> accumulated state is flushed.
> 

Hmmm... Well, I initially thought that's a tradeoff libata can take. 
It's a quite small window.  Such events are lost iff the user plugs a 
new device inbetween autopsy completion and reset completion.  ie. while 
EH is actively spitting out messages.

I've been thinking about this since yesterday (except for the time I've 
played HOMM5 demo), and it seems that achieving completely reliable 
device detection can be achieved relatively easily by combining EH 
revive and probing.  And with SError.X bit check at the end, PM should 
be able to do reliable detection, too.

PM is requiring more changes than I initially thought and merging 
probing and EH reviving would take some time too.  And, of course, HOMM5 
demo is out.  So, I don't think I can make it this week.  But on the 
bright side, SCSI part of EH seems to be agreed on and although EH and 
hotplug are a little bit flakey, libata generic PM support really works 
on my working tree!

Thanks.

-- 
tejun
