From: Ryan Bourgeois <rgb005@latech.edu>
Subject: Re: Highpoint & ide probing problem
Date: Wed, 15 Sep 2004 16:27:40 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4148B3CC.5010605@latech.edu>
References: <4147EDDD.8030001@smallworld.cx> <41483BB0.9090401@latech.edu> <41484A89.1030404@smallworld.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:60159 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S267558AbUIOV1n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Sep 2004 17:27:43 -0400
In-Reply-To: <41484A89.1030404@smallworld.cx>
List-Id: linux-ide@vger.kernel.org
To: Ian Leonard <ian@smallworld.cx>
Cc: linux-ide@vger.kernel.org

Alright, you don't have to worry about RAID anyway, so you're set 
there.    I assume the onboard controller is handled by the PIIXn 
(CONFIG_BLK_DEV_PIIX) driver since it's standard Intel.  The Highpoint 
controller will definately be handled by the HPT36X/37X driver 
(CONFIG_BLK_DEV_HPT366).

If your kernel is not configured with support for the above, you need to 
do so, especially the HPT driver, as generic support is unlikely to work 
properly with the Highpoint (didn't work right for my Highpoint).

Apparently Itox does not provide the manual for this mobo via their 
website, so I can't help you with BIOS settings that may be proprietary 
to that board.  None of the boards I've experience with mention "auto" 
or "enhanced mode" for SATA controllers, so I don't know what these 
settings imply for software configuration.

If it is the case that your kernel is configured as per above, then this 
definately needs to be CC'd to the list (I've done so) for other 
suggestions, as at the moment I can't think of anything.  I know, I 
dried up quickly, but my brain is offline at the moment...

Sorry I couldn't be of more help, but hey, I tried  >8)

-ryan


Ian Leonard wrote:

> Ryan Bourgeois wrote:
>
>> Need more info.  What's the motherboard?  What's the SATA chip?  I'm 
>> confused as to what your configuration is supposed to look like.  You 
>> want four PATA drive plugged only into the PATA controller?  Are you 
>> saying you dno't want to use the SATA controller at all?
>
>
> Hi Ryan,
>
> The motherboard is an Itox G4C600-R. It has a sata chip (ICH5R) and
> an HPT370/372 onboard. This gives a total of 10 possible drives (4 
> standard PATA, 4 Highpoint PATA and 2 SATA).
>
> We do not want to use the SATA at all (at the moment). We want to use 
> the 4 HPT PATA drives. We do not want raid.
>
>
>
>> Also, your unlikely to find SATA drivers for your chipset in 2.4.27.  
>> Try a 2.6 kernel.  Modern SATA is provided via libata, which looks 
>> like SCSI and smells like SCSI.  Therefore, you'll find it under SCSI 
>> low-level drivers.  Consequently, your SATA drives WILL look like 
>> SCSI drives (sda, sdb, etc, etc...).
>
>
> We need the HPT pata (on hde, hdf, hdg & hdh) because of software 
> compatibility.
>
> The problem is that the Linux driver only sees one of the HPT channels 
> (so only two disks). Which channel this is depends on how the SATA is
> configured in the bios (which we initially set to off, since we don't 
> want to use it).
>
>
>> In the possible case that your SATA chipset is HPT 3xx based (I have 
>> one of these, the Highpoint 1640 RAID controller), then that will 
>> look and play like a PATA controller.  Note that the "RAID" is 
>> software RAID, so driver support is not given for that sort of thing 
>> in Linux.  This is with a number fo very good reasons.  Use Linux's 
>> RAID solution.  You can also find that in the kernel, and you can 
>> find a howto on the internet.  When in doubt, Google!
>>
>> Hope this help some.
>
>
> Thanks.
>


