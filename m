From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Fri, 20 Mar 2009 12:55:34 +0300
Message-ID: <49C36816.306@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:56136 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZCTJ50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 05:57:26 -0400
Received: by ewy24 with SMTP id 24so791388ewy.13
        for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2009 02:57:23 -0700 (PDT)
In-Reply-To: <49C2F9B5.90000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun!

First, thanks for your reply.
I want to inroduce my platform so you could get some info of it:
http://www.supermicro.com/products/system/1u/5015/sys-5015b-mt.cfm

Below ther are some comments from me.

Tejun wrote:
> This log is strange for me. It seems that system missed the point that
> the drives was going out. First it tried to reinitialize the SATA link
> for three times.
>   
>
> That's the intended behavior.  Oh PHY event, libata EH tries to revive
> the link at least for 15 secs so that transient PHY glitch doesn't
> kill your root fs.
>   
Well, I partially agree. Surely, EMI problems should not break the link 
forever but I do not agree with the algorithm. When the drive is being 
removed it gets out during millisectonds. I mean the time between loss 
of link and detection that port is not populated. So, I can imagine that 
driver could be going to retry reset one but it had to abort this action 
once it got the drive is removed at all. Not in 15 second and even not 
in 5 seconds but in 0.01 second. So, I think log should be:
ata3: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
ata3: irq_stat 0x00400040, connection status changed
ata3: SError: { HostInt PHYRdyChg 10B8B DevExch }
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: drive is out
ata3.00: disabled
ata3: EH complete

>> Then, it tried to sync caches and stop the drive when it has
>> actually lost connection with HBA.
>>     
>
> That's SCSI sd driver shutting down.  As hot unplugging is
> surprise-removal, sd's shutdown sequence arrives after the device is
> actually gone and failed immediately.
>   
Ok. So, this is notmal. We just need to inform SCSI driver first, isn't it?
>> Then disk was returned to the slot and its softreset failed. Why? I
>> suspect the drive did not fully start when the host tried to
>> establish connection to it.
>>     
>
> Yeah, it sometimes depends on the spin up time.  Sometimes some
> controllers just can't get things working for the first trial and so
> on.  The timeout mechanism is there to achieve acceptable delay even
> when devices slightly malfunction, so the timeouts are a bit
> aggressive.
>   
Well, some drives store their firmware on disk, so they cannot work with 
host until fully spinned up. I heard that drive started to spin up in 
two or more seconds after being inserted. So, what is the indended 
driver behavior? It simply performs soft resets until drive answer ot 
this, isn't it? If the drive gets ready faster it will be fewer failed 
soft resets in log, right?
>> Another thing happened when I extracted the drive from one slot and
>> pushed it back into its neigbor that was empty during linux boot up.
>> Kernel desided this slot is dummy:
>> ---
>> ahci 0000:00:1f.2: version 3.0
>> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
>> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0xb impl SATA
>> mode
>> ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part
>> PCI: Setting latency timer of device 0000:00:1f.2 to 64
>> scsi0 : ahci
>> scsi1 : ahci
>> scsi2 : ahci
>> scsi3 : ahci
>> scsi4 : ahci
>> scsi5 : ahci
>> ata1: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601100 irq 1275
>> ata2: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601180 irq 1275
>> ata3: DUMMY
>> ata4: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601280 irq 1275
>> ata5: DUMMY
>> ata6: DUMMY
>>     
>
> DUMMY ports are determined by the BIOS and dummy state is recorded in
> an ahci register.  Does your board have all six ports exposed?
>   
Yes. The board has ICH9 which supports how plug capability. And this is 
claimed by SuperMicro (its vendor).
I can say more. When I read datasheet on ICH9, I found that it has 
register named:
"14.1.31 PCS---Port Control and Status Register (SATA--D31:F2)"
As stated, it contains 6 port enables and 6 port present flags. First, 
similar to you, I thought that some ports were disabled by BIOS. Then I 
printed the contents of this register into my enclosure driver and saw 
that PCS is 8B3F. According to the datasheet that means that all 6 ports 
are enabled, but onlt 3 have connected links. If I reinstall the drive 
to neighbour slot I see the PCS changes to 873F, just according to the 
change.
So, I suppose there is some AHCI driver bug. It should not assume, that 
port is dummy if it is enabled but not present.
>   
>> So,  even if I put the drive as ata3 device kernel does nothing to start
>> it.
>>
>> Now my questions:
>> 1. Is it possible to force all ports to be potentially populated during
>> startup. I would prefer that all ICH9 SATA ports will have their own
>> fixed names, eg. /dev/sata0, ..., /dev/sata5. For now I have 3 drives
>> and they allways get names /dev/sda /dev/sdb /dev/sdc even if there is
>> some empty port as shown above. This is not convenient because enclosure
>> management is linked to physical ports, not to only populated ones.
>>     
>
> If you have exposed ports which are marked dummy by the ahci driver.
> It's a BIOS bug.  It either needs to be quirked and reported to the
> motherboard vendor.
>   
See my argues above.
>> 2. How can I remove SATA drive safely? I mean the behavior similar to
>> USB drives removing. I'd like to notify the system that i wish to remove
>> the drive. Then it performs some actions as closing all current
>> connections, stopping new connections, flushing caches etc. After all
>> that it updates indicators on backplane showing me that the drive is
>> ready to be removed. As I see, some portions of this procedure can be
>> done using hdparm -f -F -Y, but not all.
>>     
>
> echo 1 > /sys/block/sdX/device/delete
>   
Can I be sure this will stop the drive sefely (without of cached data loss)?


With best regards, Vladimir Dashevsky

