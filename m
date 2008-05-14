From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Wed, 14 May 2008 10:45:38 -0400
Message-ID: <482AFB12.3040005@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4128 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbYENOpk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 10:45:40 -0400
In-Reply-To: <482AF322.2090605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Mark Lord wrote:
>>>> Mmm.. I just plugged the same PM + drives into my sata_sil24 card here,
>>>> and that driver went bonkers when I did the same test.
>>>>
>>>> Had to reboot eventually to recover.
>>>
>>> Hmm... That can't be.  Above all, although we do manual scheduling 
>>> around sil24, the controller does its own scheduling and will happily 
>>> issue command in the right order even if the software scheduler 
>>> screws up.  Do you have the log?
>> ..
>>
>> Here's what was in /var/log/messages after I held the power button
>> for five seconds to force a poweroff and then rebooted.  I didn't make 
>> much
>> effort to learn more, as I'm already busy enough testing/debugging 
>> sata_mv.
> 
> Hmmm... Have been testing NCQ + non-NCQ heavy load test w/ deadline 
> scheduler for 30+ mins now and there's no problem at all.  I'm pretty 
> sure sata_sil24 can handle mixed (across different drives) NCQ + non-NCQ 
> workload okay.
> 
> One catch w/ sata_sil24 is that it has something called PMP DMA CS 
> errata which means that all context is lost if any error (including a 
> device one) occurs during commands are pending to more than two devices 
> behind a port, the controller's state gets completely corrupt, so when 
> something goes wrong while lots of commands are pending via PMP, it's 
> often impossible what exactly went wrong.
> 
> sil4726/3726 also has a quirk.  It has configuration device as the last 
> device and issuing random IOs it might cause unpredictable results.  So, 
> can you please re-try the test excluding the pseudo config device?
..

Yeah, I'll retest it Right Now.  :)

At the moment, I have the Sil PM plugged in, and it all behaves nicely.
The previous failure was with the Marvell PM, so I'll hook that up next
and retest with it.

Cheers

