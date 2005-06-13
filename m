From: Wes Newell <w.newell@verizon.net>
Subject: Re: Pata support for SIS180
Date: Mon, 13 Jun 2005 12:19:09 -0500
Message-ID: <42ADC00D.90603@verizon.net>
References: <42AAE8B1.8080607@verizon.net> <42AC9BB9.2030304@gmx.net>
 <42ACAE15.4030001@verizon.net> <42ACFECD.7060909@pobox.com>
 <42AD28E2.4020302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:18833 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261814AbVFMRT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jun 2005 13:19:26 -0400
Received: from [192.168.0.2] ([70.104.23.44])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0II100JYD9GEDD70@vms044.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 13 Jun 2005 12:19:26 -0500 (CDT)
In-reply-to: <42AD28E2.4020302@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell wrote:

> Jeff Garzik wrote:
>
>> Wes Newell wrote:
>>
>>> Uwe Koziolek wrote:
>>>
>>>> Wes Newell schrieb:
>>>>
>>>>  
>>>>
>>>>> Can anyone tell me if/how one could add device support for the sis180
>>>>> chipset pata ports to the sis5513 module? I've tried adding this as
>>>>> others have said it works for the 965 southbridge,
>>>>>
>>>>> if ((trueid == 0x5518) || (trueid == 0x0180)) {
>>>>>
>>>>> but it stll doesn't see a real sis180 on a Jetway S755MAX MB.
>>>>>   
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> you must include the chip into the pci_device_id table
>>>>
>>>> static *struct* pci_device_id sis5513_pci_tbl[] = {
>>>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, 
>>>> PCI_ANY_ID, 0, 0, 0},
>>>>     { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, 
>>>> PCI_ANY_ID, 0, 0, 0},
>>>> +    { PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, 
>>>> PCI_ANY_ID, 0, 0, 0},
>>>>     { 0, },
>>>> };
>>>>
>>>>
>>>> regards
>>>> Uwe Koziolek
>>>>
>>>>  
>>>>
>>> Won't compile. I copied the sis180 line above into the code (- the + 
>>> sign of course). I tried both 0x180 and 0x0180 as a trueid. Didn't 
>>> matter. Keep in mind I'm not a C programmer.:-)
>>>
>>> This is the error I get;
>>>
>>>  CC      drivers/ide/pci/sis5513.o
>>> drivers/ide/pci/sis5513.c:955: error: `PCI_DEVICE_ID_SI_180' 
>>> undeclared here (not in a function)
>>
>>
>>
>> You need to add this #define to include/linux/pci_ids.h.
>>
>>     Jeff
>>
> OK, seeing some light. Added this to pci_ids.h;
> #define PCI_DEVICE_ID_SI_180        0x0180
> Compiles OK now. Sees controller on boot, but lost interrrupt problem. 
> Disabling apic doesn't fix it. Here's where I'm at now, and I'm about 
> to call it a night. Will try and get back on it tomorrow. Any thoughts?
>
> SIS5513: IDE controller at PCI slot 0000:00:0c.0
> SIS5513: chipset revision 0
> SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
> SIS5513: Switching to 5513 register mapping
> SIS5513: 100% native mode on irq 19

This part concerns me.  Is the 5513 register mapping really what we 
want? I think this may not be right, From what i can tell from the code 
(keeping in mind I'm not a C programmer), it defaults to this if it 
doesn't find what it wants in this part of sis5513.c

                /* Check for 5513 compability mapping
                 * We must use this, else the port enabled code will fail,
                 * as it expects the enablebits at 0x4a.
                 */
                if ((idemisc & 0x40000000) == 0) {
                    pci_write_config_dword(dev, 0x54, idemisc | 0x40000000);
                    printk(KERN_INFO "SIS5513: Switching to 5513 
register mapping\n");
       
But is whatever this is doing right?

> Probing IDE interface ide2...
> hde: WDC WD800JB-00JJC0, ATA DISK drive
> ide2 at 0xdc00-0xdc07,0xe002 on irq 19

And are these addresses right? I'm not sure, that's region 0 of the chispet.

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS] (prog-if 85)
        Subsystem: Silicon Integrated Systems [SiS] RAID bus controller 
180 SATA/PATA  [SiS]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=8]
        Region 3: I/O ports at e800 [size=4]
        Region 4: I/O ports at ec00 [size=16]
        Region 5: I/O ports at <unassigned>
        Expansion ROM at <unassigned> [disabled] [size=64K]

> Probing IDE interface ide3...
> hda: max request size: 128KiB
> hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, 
> UDMA(100)
> hda: cache flushes supported
> /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
> hde: max request size: 128KiB
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63
> hde: lost interrupt
> hde: lost interrupt
> hde: cache flushes supported
> /dev/ide/host2/bus0/target0/lun0:<4>hde: lost interrupt
> p1 p2 <<4>hde: lost interrupt
> p5<4>hde: lost interrupt
> p6<4>hde: lost interrupt
> p7<4>hde: lost interrupt
> p8<4>hde: lost interrupt
> p9<4>hde: lost interrupt
> p10<4>hde: lost interrupt
> p11 >
> hde: lost interrupt
> mice: PS/2 mouse device common for all mice
>
> Continues to boot ok, but drive access is flacky. More lost interrupts
>
I also disabled the ethernet controller (sharing interrupt) and that 
didn't work either. Still getting lost interrrupts and I'm stumped. 
Where do you think I should go from here?  And hell isn't an option.:-)

