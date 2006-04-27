From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 27 Apr 2006 21:38:27 +0900
Message-ID: <4450BB43.8090801@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <44508F12.8010705@pobox.com> <4450A2C0.4090401@gmail.com> <4450AB28.2030801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:26770 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965110AbWD0MiU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 08:38:20 -0400
Received: by pproxy.gmail.com with SMTP id i49so2046381pye
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 05:38:20 -0700 (PDT)
In-Reply-To: <4450AB28.2030801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> In my working repo, hardware debouncing is done by invoking the 
>> following function in ->prereset() with the port frozen.  I'm not very 
>> sure whether debouncing user request is necessary though.
> 
> Agreed, I'm not sure either.
> 
> 
>> /**
>>  *    sata_debounce - debounce SATA phy status
[--snip--]
>>     }
>> }
> 
> hmmm, I would think something more along the lines of
> 
>     get HP irq
>     ack HP irq
>     ata_I_got_hotplug_event()
>         if test_and_clear_bit(got_hotplug)
>             start 1-second timer
> 
>     timer fires...
>     clear got_hotplug
>     handle hotplug, revalidate port
> 
> There's not much point in polling, the reason for the debounce period is 
> to throw away spurious hotplug/unplug/hotplug events the hardware throws 
> while it is figuring shit out.
> 
> Should just need a pause, following by port recovery/revalidate.
> 

The thing is that on detection of hotplug event, all the active qcs 
should be aborted and EH should be entered anyway.  The current working 
tree is much nicer to hardware compared to the previous posting.  It 
freezes the port only when really necessary.

I think I need to explain more about the whole freezing/polling thing.

I once participated in a static discharge / power fluctation test for 
SATA.  Although the serial link is convenient, pretty and definitely the 
way to go, it gets easily interfered by electromagnetic fluctations. 
Also, because the communication is packet based necessitating relatively 
complex state machine inside the link layer, controllers implementing 
such interfaces seem to exhibit various convoluted behaviors when put 
under stress.

I could see several different types of screaming interrupt lockups in 
the period of a few hours.  And we all know screaming interrupt is a 
scary thing.  This is the reason behind the whole 'freezing' stuff.

What I tried to achieve is to isolate the controller if things start to 
go south so that the machine as a whole isn't affected.  Fortunately, 
most such conditions are recoverable by some form of resetting and we 
can determine if the controller is acting sanely by watching how the 
reset goes.  If it seems okay, we turn it back on.  If it fails to come 
back after several retries, we leave the controller frozen such that the 
rest of the machine can function.

phy status change is a dangerous event.  I'm pretty sure most of 
electromagnetic interferences would trigger the event too.  Also, it's 
not like we can do anything other than resetting and recovering the 
device after such an event.  So, in new EH, phy status change is a 
freezing event.

As soon as such an event is detected, libata assumes the controller is 
lost and freezes it.  EH kicks in immediately and performs reset and, by 
doing so, it makes sure that the controller isn't trying to eat the 
machine alive.  Only after EH is sure that the controller is acting 
sanely, it thaws the port and revalidates the attached device.

So, in the above control flow, it's natural and even necessary to 
perform debouncing by polling.  So, the implementation.  It also has the 
advantage of being generic.  As most controllers generate phy related 
interrupts from SCR updates, they can use generic stat_debounce() 
instead of writing its own irq debouncing routine.

One more thing to note is that such debouncing is needed before and 
during several stages of resets anyway.  The current upstream code does 
this from sata_phy_resume() by waiting until DET assumes some other 
value than 1.  Unfortunately, this doesn't work for some controllers 
(sil24) as DET dances together with other bits.  So, we need better 
debouncing routine anyway, and as now all resets are probing resets, we 
need to debounce prior to every reset.  And, debouncing in ->prereset() 
can satisfy all the requirements.

Oh.. and this has been on my mind for some time now.  It would be nice 
if we can set up a project to certify controllers and drivers which pass 
certain set of standard static discharge / power fluctation tests.  With 
new EH, we have the framework but I'm pretty sure a lot of drivers would 
need some special case code to cope with such tests.  Equipments to 
perform such tests are not cheap, but it would be very helpful to a lot 
of people, especially server crowd and people trying to use Linux on 
consumer products.  Those static discharges and power fluctations are 
facts of life.  They do occur.  And, ATM, we're not dealing with it very 
well.  I hope we can persuade some companies to sponsor such a project.

> 
>>> I'm careful to use "revalidate", because that covers all cases:
>>>
>>>     - existing device goes away
>>>     - new device appears
>>>     - existing device "blipped", but its still there, so
>>>       we can keep talking to it.
>>>
>>
>> Yeap, all bases covered.
>>
>> I'm currently finishing up PM support.  It took a lot longer than I 
>> though but it's shaping up pretty good.  Everything is handled nicely, 
>> hotplug, EH, qc deferring (e.g. not issuing ATAPI command if commands 
>> are outstanding to more than three devices for sil24...) are all 
>> handled in generic and unified way.  Adding PM support necessitated 
>> quite a bit of changes to EH and hotplug.  Currently, major changes in 
>> my repo are...
>>
>> - boot scan, hotplug, EH all rolled up into single EH revive operation.
>> - simpler EH/irq synchronization.  EH now works on its own copy of EH 
>> info created on entry to EH.
>> - much tighter event handling (almost no EH/hotplug event/info loss 
>> except for pathological cases)
>> - fine-grained user scan request (user can request scan of specific 
>> device)
>> - ata_link abstraction for PM
> 
> that's nice
> 
> 
>> - PM support with the same level of EH/NCQ/hotplug support as host 
>> ports (sil24 and working on AHCI)
> 
> what kind of PM are you testing on?
> 

sil4726.  Silicon Image was kind enough to send a sample board to me.  :)

> 
>> Above list is what comes to my mind ATM.  I probably have forgotten a 
>> lot.  I'll make a full list when I post the next round of patches.
>>
>> Jeff, until when are you available?  I think I can post the next round 
>> in a few days (I'm pretty sure this time :).  I'm thinking of setting 
>> up a git repo and merge irq-pio there too in the order you requested.  
>> If schedule isn't too tight, it would be nice to push this thing to 
>> some branch in libata-dev.
> 
> I leave May 3rd.  So sometime between now and then.  The goal should be 
> to get #irq-pio and whatever other work you want into #upstream before I 
> leave, so that people have a nice long period for testing in -mm. 
> irq-pio will definitely want some testing, as will your work.  Its a lot 
> to throw at people all at once.
>

I think/hope I can pull something off in that time frame.  And, yeah, 
it's a LOT to throw at people and definitely needs a lot of testing.

Thanks.

-- 
tejun
