From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 19:44:41 +0200
Message-ID: <4F8EFD89.2080603@fold.natur.cuni.cz>
References: <4F8DD4DC.4050503@teksavvy.com> <4F8DD708.8050502@teksavvy.com> <4F8DD834.5070000@teksavvy.com> <4F8DDA53.206@teksavvy.com> <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com> <4F8EF57E.4070603@fold.natur.cuni.cz> <4F8EF9F7.5040202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:36501 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751730Ab2DRRop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 13:44:45 -0400
In-Reply-To: <4F8EF9F7.5040202@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>



Jeff Garzik wrote:
> On 04/18/2012 01:10 PM, Martin Mokrejs wrote:
>> Fix: I got my 3TB disk detected by this single command:
>>
>> # echo on>   /sys/devices/pci0000:00/0000:00:1f.2/ata6/power/control
>> #
>>
>> This is a Dell Vostro 3550 with A09 BIOS. Same happend with 3.4-rc3 kernel.
>>
>> I can do some more testing if you want me to.
>> Best,
>> Martin
> 
> 
> Can you test this one-line patch from Lin Ming?  Hopefully there is zero sysfs twiddling required with this one...
> 
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -294,6 +294,7 @@ int ata_tport_add(struct device *parent,
>      device_enable_async_suspend(dev);
>      pm_runtime_set_active(dev);
>      pm_runtime_enable(dev);
> +    pm_runtime_forbid(dev);
> 
>      transport_add_device(dev);
>      transport_configure_device(dev);

Works! (the src tree has some pcieh patches so can re-test in a while on vanilla kernel
sources if you want me to confirm that). Just too many patches to try. ;-)

[cut]
[   19.629276] EXT3-fs (sda5): using internal journal
[   19.894238] Adding 4998972k swap on /dev/sda6.  Priority:-1 extents:1 across:4998972k 
[   25.615229] r8169 0000:05:00.0: eth0: unable to load firmware patch rtl_nic/rtl8168e-2.fw (-2)
[   25.638382] r8169 0000:05:00.0: eth0: link down
[   25.638413] r8169 0000:05:00.0: eth0: link down
[   27.396716] r8169 0000:05:00.0: eth0: link up
[   31.405068] microcode: CPU0 updated to revision 0x25, date = 2011-10-11
[   31.405417] microcode: CPU1 updated to revision 0x25, date = 2011-10-11
[   31.405747] microcode: CPU2 updated to revision 0x25, date = 2011-10-11
[   31.406086] microcode: CPU3 updated to revision 0x25, date = 2011-10-11
[   31.566473] [drm] Changing LVDS panel from (+hsync, -vsync) to (-hsync, -vsync)
[   33.296080] r8169 0000:05:00.0: eth0: link down
[   35.674572] r8169 0000:05:00.0: eth0: link up
[   41.896276] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
[   41.896285] ata6: irq_stat 0x00400040, connection status changed
[   41.896293] ata6: SError: { PHYRdyChg CommWake DevExch }
[   41.896313] ata6: hard resetting link
[   42.639279] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   42.681085] ata6.00: ATA-8: WDC WD10TPVT-00HT5T0, 01.01A01, max UDMA/133
[   42.681096] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[   42.686541] ata6.00: configured for UDMA/133
[   42.686560] ata6: EH complete
[   42.686706] scsi 5:0:0:0: Direct-Access     ATA      WDC WD10TPVT-00H 01.0 PQ: 0 ANSI: 5
[   42.686833] sd 5:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[   42.686959] sd 5:0:0:0: [sdc] Write Protect is off
[   42.686961] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   42.686992] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   42.687000] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   42.696794]  sdc: sdc1
[   42.697115] sd 5:0:0:0: [sdc] Attached SCSI disk
[   56.259694] [drm] Changing LVDS panel from (-hsync, -vsync) to (+hsync, -vsync)
[   61.127682] ata1.00: configured for UDMA/133
[   61.127685] ata1: EH complete
[   61.277874] ata6.00: configured for UDMA/133
[   61.277878] ata6: EH complete
[   98.163139] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action 0xe frozen
[   98.163148] ata6: irq_stat 0x00400040, connection status changed
[   98.163156] ata6: SError: { PHYRdyChg 10B8B DevExch }
[   98.163173] ata6: hard resetting link
[   98.905476] ata6: SATA link down (SStatus 0 SControl 300)
[  103.898017] ata6: hard resetting link
[  104.247521] ata6: SATA link down (SStatus 0 SControl 300)
[  104.247540] ata6: limiting SATA link speed to 1.5 Gbps
[  109.240197] ata6: hard resetting link
[  109.589549] ata6: SATA link down (SStatus 0 SControl 310)
[  109.589568] ata6.00: disabled
[  109.609519] ata6: EH complete
[  109.609543] ata6.00: detaching (SCSI 5:0:0:0)
[  109.610027] sd 5:0:0:0: [sdc] Synchronizing SCSI cache
[  109.610058] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  109.610062] sd 5:0:0:0: [sdc] Stopping disk
[  109.610070] sd 5:0:0:0: [sdc] START_STOP FAILED
[  109.610072] sd 5:0:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  140.043217] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
[  140.043226] ata6: irq_stat 0x00400040, connection status changed
[  140.043234] ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  140.043253] ata6: limiting SATA link speed to 1.5 Gbps
[  140.043261] ata6: hard resetting link
[  141.322298] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  141.332583] ata6.00: ATA-8: ST3000DM001-9YN166, CC4C, max UDMA/133
[  141.332593] ata6.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[  141.333407] ata6.00: configured for UDMA/133
[  141.352233] ata6: EH complete
[  141.352384] scsi 5:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[  141.352518] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[  141.352521] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[  141.352540] sd 5:0:0:0: Attached scsi generic sg3 type 0
[  141.352575] sd 5:0:0:0: [sdc] Write Protect is off
[  141.352578] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  141.352601] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  141.400394]  sdc: sdc1
[  141.400833] sd 5:0:0:0: [sdc] Attached SCSI disk

Martin
