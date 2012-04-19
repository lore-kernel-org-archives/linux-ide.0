From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 19 Apr 2012 20:22:26 +0200
Message-ID: <4F9057E2.6020503@fold.natur.cuni.cz>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com>  <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com>  <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>  <4F8EF57E.4070603@fold.natur.cuni.cz> <4F8EF9F7.5040202@pobox.com>  <4F8EFD89.2080603@fold.natur.cuni.cz> <4F8F08D7.6050809@fold.natur.cuni.cz>  <CAF1ivSYqzjv10F+sdYkR_jdTZvzKP1=_ZwgNDj2njnmb6uaenA@mail.gmail.com> <1334823362.11188.172.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:38919 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755754Ab2DSSWa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Apr 2012 14:22:30 -0400
In-Reply-To: <1334823362.11188.172.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Gwendal Grignou <gwendal@google.com>, Grant Grundler <grundler@google.com>

Hi Lin,

Lin Ming wrote:
> On Thu, Apr 19, 2012 at 2:32 AM, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz> wrote:
>> Martin Mokrejs wrote:
>>>
>>>
>>> Jeff Garzik wrote:
>>>> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>>>>> Fix: I got my 3TB disk detected by this single command:
>>>>>
>>>>> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/control
>>>>> #
>>>>>
>>>>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc3 kernel.
>>>>>
>>>>> I can do some more testing if you want me to.
>>>>> Best,
>>>>> Martin
>>>>
>>>>
>>>> Can you test this one-line patch from Lin Ming?  Hopefully there is zero sysfs twiddling required with this one...
>>>>
>>>> --- a/drivers/ata/libata-transport.c
>>>> +++ b/drivers/ata/libata-transport.c
>>>> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>>>>      device_enable_async_suspend(dev);
>>>>      pm_runtime_set_active(dev);
>>>>      pm_runtime_enable(dev);
>>>> +    pm_runtime_forbid(dev);
>>>>
>>>>      transport_add_device(dev);
>>>>      transport_configure_device(dev);
>>
>>
>> There is one more minor issue. I cannot get my disk re-dectected at 3Gbps. Here is when I plugged it in
>> for the very first time after bootup (plain 3.4-rc3 with the above one-line fix):
> 
> I did bisect and found that this is a really old regression introduced
> in 2.6.37-rc1 with below commit.
> 
> commit d9027470b88631d0956ac37cdadfdeb9cdcf2c99
> Author: Gwendal Grignou <gwendal@google.com>
> Date:   Tue May 25 12:31:38 2010 -0700
> 
>     [libata] Add ATA transport class
> 
>     This is a scheleton for libata transport class.
>     All information is read only, exporting information from libata:
>     - ata_port class: one per ATA port
>     - ata_link class: one per ATA port or 15 for SATA Port Multiplier
>     - ata_device class: up to 2 for PATA link, usually one for SATA.
> 
>     Signed-off-by: Gwendal Grignou <gwendal@google.com>
>     Reviewed-by: Grant Grundler <grundler@google.com>
>     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> 
> 
> Here is the patch to fix it.
> 
> Gwendal and Grant,
> 
> Would you help to review it?
> 
> 
>>From f696daec7ff63e9b3697e8f7ef8f985152667965 Mon Sep 17 00:00:00 2001
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Thu, 19 Apr 2012 15:45:51 +0800
> Subject: [PATCH] libata: clear error mask of old error history
> 
> The old error history was cleared in ata_ering_clear().
> It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not cleared.
> So ata_ering_map() still iterates the old error history.
> 
> This causes problem, for example, wrong probe trials count were returned in
> ata_eh_schedule_probe(), which in turn causes SATA link speed to be slowed down
> to 1.5Gbps.
> 
> Reported-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/ata/libata-eh.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c61316e..4c6f49b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -419,9 +419,10 @@ int ata_ering_map(struct ata_ering *ering,
>  	return rc;
>  }
>  
> -int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
> +static int ata_ering_clear_cb(struct ata_ering_entry *ent, void *void_arg)
>  {
>  	ent->eflags |= ATA_EFLAG_OLD_ER;
> +	ent->err_mask = 0;
>  	return 0;
>  }
>  

Confirming this patch fixed my problem. If you would like to improve something, add
some 1.5Gbp to 3.0Gbps re-negotiation. As you can see belo, I was desperate and plugged
in the cable just when kernel lowered the speed to 1.5Gbps. It seems it cannot re-negotiate
to go back up again. Tested 3.4-rc3 with some patches for pciehp from Yinghai, SATA
hotplug fix (lin Min), and for some reason have still reverted patch
486b10b9f43500741cd63a878d0ef23cd87fc66d (just for completeness).


I plugged in the cable.

[   75.818463] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
[   75.818472] ata6: irq_stat 0x00400040, connection status changed
[   75.818481] ata6: SError: { PHYRdyChg CommWake DevExch }
[   75.818500] ata6: hard resetting link
[   76.557738] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   76.558554] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[   76.558564] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   76.559365] ata6.00: configured for UDMA/133
[   76.577645] ata6: EH complete
[   76.577802] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[   76.577926] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[   76.577929] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[   76.577949] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   76.577983] sd 5:0:0:0: [sdc] Write Protect is off
[   76.577986] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   76.578010] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   76.618312]  sdc: sdc1
[   76.618641] sd 5:0:0:0: [sdc] Attached SCSI disk

Unplugged the cable.

[   80.966608] ata6: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
[   80.966617] ata6: irq_stat 0x00400040, connection status changed
[   80.966625] ata6: SError: { HostInt PHYRdyChg 10B8B DevExch }
[   80.966643] ata6: hard resetting link
[   81.710063] ata6: SATA link down (SStatus 0 SControl 300)
[   84.575097] ata6: hard resetting link
[   84.915290] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   84.916778] ata6.00: configured for UDMA/133
[   84.935231] ata6: EH complete
[   90.042553] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
[   90.042562] ata6: irq_stat 0x00400040, connection status changed
[   90.042570] ata6: SError: { PHYRdyChg 10B8B DevExch }
[   90.042587] ata6: hard resetting link
[   90.786545] ata6: SATA link down (SStatus 0 SControl 300)
[   95.779093] ata6: hard resetting link
[   96.128574] ata6: SATA link down (SStatus 0 SControl 300)
[   96.128593] ata6: limiting SATA link speed to 1.5 Gbps

I plugged in the cable before the "SCSI" was disabled.

[   98.697321] ata6: hard resetting link
[   99.044242] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   99.045842] ata6.00: configured for UDMA/133
[   99.064156] ata6: EH complete
[  141.857958] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)

I unounted the disk and unplugged the cable.

[  150.645109] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
[  150.645119] ata6: irq_stat 0x00400040, connection status changed
[  150.645127] ata6: SError: { PHYRdyChg 10B8B DevExch }
[  150.645144] ata6: hard resetting link
[  151.386278] ata6: SATA link down (SStatus 0 SControl 310)
[  156.378946] ata6: hard resetting link
[  156.728320] ata6: SATA link down (SStatus 0 SControl 310)
[  161.720864] ata6: hard resetting link
[  162.070361] ata6: SATA link down (SStatus 0 SControl 310)
[  162.070380] ata6.00: disabled
[  162.090321] ata6: EH complete
[  162.090345] ata6.00: detaching (SCSI 5:0:0:0)
[  162.090801] sd 5:0:0:0: [sdc] Synchronizing SCSI cache
[  162.090834] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  162.090837] sd 5:0:0:0: [sdc] Stopping disk
[  162.090843] sd 5:0:0:0: [sdc] START_STOP FAILED
[  162.090844] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

I plugged in the cable.

[  169.586995] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
[  169.587005] ata6: irq_stat 0x00400040, connection status changed
[  169.587012] ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  169.587032] ata6: hard resetting link
[  170.328067] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  170.328913] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[  170.328923] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  170.329731] ata6.00: configured for UDMA/133
[  170.347972] ata6: EH complete
[  170.348131] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[  170.348243] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  170.348246] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[  170.348272] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  170.348300] sd 5:0:0:0: [sdc] Write Protect is off
[  170.348302] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  170.348324] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  170.390492]  sdc: sdc1
[  170.390860] sd 5:0:0:0: [sdc] Attached SCSI disk

Unplugged the cable.

[  180.819680] ata6: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
[  180.819689] ata6: irq_stat 0x00400040, connection status changed
[  180.819697] ata6: SError: { HostInt PHYRdyChg 10B8B DevExch }
[  180.819714] ata6: hard resetting link
[  181.561332] ata6: SATA link down (SStatus 0 SControl 300)
[  186.553880] ata6: hard resetting link
[  186.903376] ata6: SATA link down (SStatus 0 SControl 300)
[  186.903395] ata6: limiting SATA link speed to 1.5 Gbps
[  191.896050] ata6: hard resetting link
[  192.245416] ata6: SATA link down (SStatus 0 SControl 310)
[  192.245434] ata6.00: disabled
[  192.265374] ata6: EH complete
[  192.265398] ata6.00: detaching (SCSI 5:0:0:0)
[  192.265878] sd 5:0:0:0: [sdc] Synchronizing SCSI cache
[  192.265906] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  192.265909] sd 5:0:0:0: [sdc] Stopping disk
[  192.265916] sd 5:0:0:0: [sdc] START_STOP FAILED
[  192.265917] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

I plugged in the cable.

[  194.436542] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
[  194.436551] ata6: irq_stat 0x00400040, connection status changed
[  194.436559] ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  194.436578] ata6: hard resetting link
[  195.181045] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  195.181795] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[  195.181805] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  195.182571] ata6.00: configured for UDMA/133
[  195.200953] ata6: EH complete
[  195.201110] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[  195.201243] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  195.201246] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[  195.201270] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  195.201314] sd 5:0:0:0: [sdc] Write Protect is off
[  195.201317] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  195.201344] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  195.239595]  sdc: sdc1
[  195.240020] sd 5:0:0:0: [sdc] Attached SCSI disk



