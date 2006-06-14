From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] new Power Management for libata
Date: Wed, 14 Jun 2006 22:46:13 +0900
Message-ID: <44901325.7050902@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com> <448F659A.5010606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:58630 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964930AbWFNNqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 09:46:40 -0400
Received: by py-out-1112.google.com with SMTP id i49so362212pye
        for <linux-ide@vger.kernel.org>; Wed, 14 Jun 2006 06:46:40 -0700 (PDT)
In-Reply-To: <448F659A.5010606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This patchset implements new Power Management for libata.  Currently,
>> only controller-wide suspend and resume are supported.  No per-device
>> power management yet.  Both memsleep and disksleep work on supported
>> controllers.
> 
> I suppose this is just an RFC?

Well, not really.

> We don't want to lose to SCSI device suspend, so merging that would be a 
> regression AFAICS?  While we're still married to the SCSI layer, we need 
> to do suspend through sd.c and similar paths.
> 
> I also wonder if any developers or users make use of the ability to 
> suspend/resume individual pieces of hardware, as is (somewhat) supported 
> in ata_piix in 2.6.17-rcX.

At first I thought about implementing that and asked Pavel about how to 
discern between partial PM and system-wide PM so that libata can do 
things bus-wide on system-wide PM event.  Pavel's response was...

"> And, one more things.  As written in the first mail, for libata, it
 > > would be nice to know if a device suspend is due to runtime PM event
 > > (per-device) or system wide suspend.  What do you think about this? 
  If
 > > you agree, what method do you recommend to determine that?

Currently, runtime pm is unsupported/broken; so any request can be
thought as system pm.
								Pavel"

So, I determined to ignore per-device PM for the time being.  I think I 
can still implement it but I'm a bit skeptical about its usefulness.  I 
personally haven't seen any user of partial power management using sysfs 
interface.  IIRC, dynamic power management on IDE disks from userspace 
is done by issuing STANDBY using raw command interface.

What do you think?

-- 
tejun
