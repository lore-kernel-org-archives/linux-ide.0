From: Wes Newell <w.newell@verizon.net>
Subject: Re: Pata support for SIS180
Date: Mon, 13 Jun 2005 01:34:10 -0500
Message-ID: <42AD28E2.4020302@verizon.net>
References: <42AAE8B1.8080607@verizon.net> <42AC9BB9.2030304@gmx.net>
 <42ACAE15.4030001@verizon.net> <42ACFECD.7060909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:13488 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261377AbVFMGa3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jun 2005 02:30:29 -0400
Received: from [192.168.0.2] ([70.104.23.44])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0II00093TFERLPVS@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 13 Jun 2005 01:30:27 -0500 (CDT)
In-reply-to: <42ACFECD.7060909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:

> Wes Newell wrote:
>
>> Uwe Koziolek wrote:
>>
>>> Wes Newell schrieb:
>>>
>>>  
>>>
>>>> Can anyone tell me if/how one could add device support for the sis180
>>>> chipset pata ports to the sis5513 module? I've tried adding this as
>>>> others have said it works for the 965 southbridge,
>>>>
>>>> if ((trueid == 0x5518) || (trueid == 0x0180)) {
>>>>
>>>> but it stll doesn't see a real sis180 on a Jetway S755MAX MB.
>>>>   
>>>
>>>
>>>
>>>
>>> you must include the chip into the pci_device_id table
>>>
>>> static *struct* pci_device_id sis5513_pci_tbl[] = {
>>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, 
>>> PCI_ANY_ID, 0, 0, 0},
>>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, 
>>> PCI_ANY_ID, 0, 0, 0},
>>> +    { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, 
>>> PCI_ANY_ID, 0, 0, 0},
>>>     { 0, },
>>> };
>>>
>>>
>>> regards
>>> Uwe Koziolek
>>>
>>>  
>>>
>> Won't compile. I copied the sis180 line above into the code (- the + 
>> sign of course). I tried both 0x180 and 0x0180 as a trueid. Didn't 
>> matter. Keep in mind I'm not a C programmer.:-)
>>
>> This is the error I get;
>>
>>  CC      drivers/ide/pci/sis5513.o
>> drivers/ide/pci/sis5513.c:955: error: `PCI_DEVICE_ID_SI_180' 
>> undeclared here (not in a function)
>
>
> You need to add this #define to include/linux/pci_ids.h.
>
>     Jeff
>
OK, seeing some light. Added this to pci_ids.h;
#define PCI_DEVICE_ID_SI_180        0x0180
Compiles OK now. Sees controller on boot, but lost interrrupt problem. 
Disabling apic doesn't fix it. Here's where I'm at now, and I'm about to 
call it a night. Will try and get back on it tomorrow. Any thoughts?

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800JB-00FMA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
hdd: LS-120 CSMO 05 UHD Floppy, ATAPI FLOPPY drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04 { AbortedCommand }
ide1 at 0x170-0x177,0x376 on irq 15
SIS5513: IDE controller at PCI slot 0000:00:0c.0
SIS5513: chipset revision 0
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
SIS5513: Switching to 5513 register mapping
SIS5513: 100% native mode on irq 19
Probing IDE interface ide2...
hde: WDC WD800JB-00JJC0, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xe002 on irq 19
Probing IDE interface ide3...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, 
UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
hde: max request size: 128KiB
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63
hde: lost interrupt
hde: lost interrupt
hde: cache flushes supported
 /dev/ide/host2/bus0/target0/lun0:<4>hde: lost interrupt
 p1 p2 <<4>hde: lost interrupt
 p5<4>hde: lost interrupt
 p6<4>hde: lost interrupt
 p7<4>hde: lost interrupt
 p8<4>hde: lost interrupt
 p9<4>hde: lost interrupt
 p10<4>hde: lost interrupt
 p11 >
hde: lost interrupt
mice: PS/2 mouse device common for all mice

Continues to boot ok, but drive access is flacky. More lost interrupts
