From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 20:32:55 +0200
Message-ID: <4F8F08D7.6050809@fold.natur.cuni.cz>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com> <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com> <4F8EF57E.4070603@fold.natur.cuni.cz> <4F8EF9F7.5040202@pobox.com> <4F8EFD89.2080603@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:32853 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751532Ab2DRSc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 14:32:58 -0400
In-Reply-To: <4F8EFD89.2080603@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Martin Mokrejs wrote:
> 
> 
> Jeff Garzik wrote:
>> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>>> Fix: I got my 3TB disk detected by this single command:
>>>
>>> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/control
>>> #
>>>
>>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc3 kernel.
>>>
>>> I can do some more testing if you want me to.
>>> Best,
>>> Martin
>>
>>
>> Can you test this one-line patch from Lin Ming?  Hopefully there is zero sysfs twiddling required with this one...
>>
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>      device_enable_async_suspend(dev);
>>      pm_runtime_set_active(dev);
>>      pm_runtime_enable(dev);
>> +    pm_runtime_forbid(dev);
>>
>>      transport_add_device(dev);
>>      transport_configure_device(dev);


There is one more minor issue. I cannot get my disk re-dectected at 3Gbps. Here is when I plugged it in
for the very first time after bootup (plain 3.4-rc3 with the above one-line fix):

[  146.876489] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
[  146.876499] ata6: irq_stat 0x00400040, connection status changed
[  146.876508] ata6: SError: { PHYRdyChg CommWake DevExch }
[  146.876527] ata6: hard resetting link
[  147.619956] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  147.869349] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[  147.869360] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  147.870126] ata6.00: configured for UDMA/133
[  147.870131] ata6: EH complete
[  147.870220] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[  147.870391] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  147.870393] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[  147.870396] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  147.870434] sd 5:0:0:0: [sdc] Write Protect is off
[  147.870436] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  147.870460] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  147.904848]  sdc: sdc1
[  147.905196] sd 5:0:0:0: [sdc] Attached SCSI disk


Here is what happens on re-plug of the device. It is a 3.5" drive and the line
[  617.838013] ata6: hard resetting link
happens too early. I can hear the drive is still spinning up, it can't be ready yet.
I think the delay should be increased.


[  617.837966] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
[  617.837976] ata6: irq_stat 0x00400040, connection status changed
[  617.837984] ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  617.838004] ata6: limiting SATA link speed to 1.5 Gbps
[  617.838013] ata6: hard resetting link
[  623.610941] ata6: link is slow to respond, please be patient (ready=0)
[  627.864604] ata6: COMRESET failed (errno=-16)
[  627.864615] ata6: hard resetting link
[  629.931538] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  629.932355] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[  629.932365] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  629.933170] ata6.00: configured for UDMA/133
[  629.951629] ata6: EH complete
[  629.951700] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[  629.951816] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  629.951819] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[  629.951842] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  629.951875] sd 5:0:0:0: [sdc] Write Protect is off
[  629.951877] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  629.951901] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  629.995970]  sdc: sdc1
[  629.996359] sd 5:0:0:0: [sdc] Attached SCSI disk


Martin

