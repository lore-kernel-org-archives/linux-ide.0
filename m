From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Sun, 18 Mar 2007 18:57:57 +0800
Message-ID: <45FD1B35.2090607@tw.ibm.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu> <45FAC6FC.4020105@tw.ibm.com> <45FADD53.5030500@mail.utexas.edu> <45FB71EA.7070602@tw.ibm.com> <45FC952C.1040708@mail.utexas.edu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:53976 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbXCRK6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 06:58:19 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2IAueFc020159
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 06:56:40 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2IAwID2038660
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 04:58:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2IAwHjn010643
	for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 04:58:18 -0600
In-Reply-To: <45FC952C.1040708@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Albert Lee wrote:
> 
>> Vlad Codrea wrote:
>>  
>>
>>> Albert Lee wrote:
>>>
>>>    
>>>
>>>> ata2: protocol 7 task_state 4   <=== The device interrupts to
>>>> receive CDB
>>>> ata2: protocol 7 task_state 4 (dev_stat 0x58)  <== Good, DRQ seen. CDB
>>>> sent.
>>>> ata2: protocol 7 task_state 2   <=== interrupt. We expect DMA complete.
>>>> ata2: protocol 7 task_state 2 (dev_stat 0x58) <== What? DRQ set? No
>>>> good.
>>>> ata2: protocol 7 task_state 3 (dev_stat 0x58) <== HSM violation.
>>>> (BMDMA stat 0x5) <=== Interrupted, DMA active.
>>>>
>>>> Still no clue why the device wrongly sets DRQ here for a DMA
>>>> transfer...
>>>> Possibilities:
>>>> 1. HSM sent all CDB to the device, but the device is waiting for more
>>>> CDB data?
>>>> 2. HSM asked the drive to do ATAPI DMA, but the drive is doing PIO?
>>>>
>>>> Hi Vlad,
>>>>
>>>> Could you please turn off ATAPI DMA and see if the drive works under
>>>> PIO,
>>>> thanks.
>>>>
>>>> -- 
>>>> albert
>>>>
>>>> (This is not a patch. Please edit drivers/ata/libata-core.c as below.)
>>>>
>>>> int ata_check_atapi_dma(struct ata_queued_cmd *qc)
>>>> {
>>>>     struct ata_port *ap = qc->ap;
>>>>     int rc = 0; /* Assume ATAPI DMA is OK by default */
>>>>
>>>>     if (ap->ops->check_atapi_dma)
>>>>         rc = ap->ops->check_atapi_dma(qc);
>>>>
>>>>  rc = 1; (<==== Please add "rc = 1;" here to turn off ATAPI DMA. )
>>>>
>>>>     return rc;
>>>> }
>>>>         
>>>
>>> Hi,
>>>
>>> After adding "rc = 1;", the drive now appears as /dev/sr0. I've attached
>>> an annotated dmesg: the first part contains the messages immediately
>>> after booting. The second part contains messages after I inserted a CD
>>> and ran  "mount /dev/sr0 /root/cdrom". The third part contains messages
>>> after I ran "cp -r /root/cdrom /root/cdrom_copy". I separated the parts
>>> by adding lines containing "#####".
>>>
>>> The recursive copy fails after about 10 seconds, even though a few files
>>> are copied.
>>>
>>>     
>>
>>
>> Ok, as Tejun said, PIO looks better than DMA, but still has problems.
>> Two problems seen:
>>
>>  
>>
>>> ata2: protocol 5 task_state 4
>>> ata2: protocol 5 task_state 4 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 2
>>> ata2: protocol 5 task_state 2
>>> ata2: protocol 5 task_state 2 (dev_stat 0x50)
>>>     
>>
>>
>> 1. The drive interrups when it is still BSY.
>>
>>  
>>
>>> ata2: protocol 5 task_state 4
>>> ata2: protocol 5 task_state 4 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x50)
>>> ata2: protocol 5 task_state 2 (dev_stat 0x50)
>>> ata2: protocol 5 task_state 4
>>> ata2: protocol 5 task_state 4 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 1
>>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>>> ata2.00: 59392 bytes trailing data
>>> ata2: protocol 5 task_state 2
>>> ata2: protocol 5 task_state 2
>>> ata2: protocol 5 task_state 2 (dev_stat 0x58)
>>> ata2: protocol 5 task_state 3 (dev_stat 0x58)
>>> ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
>>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>> ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data
>>> 79872 in
>>>          res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x2 (HSM
>>> violation)
>>>     
>>
>>
>> 2. The drive wants to transfer more data than expected.
>>    Libata transfers some of the trailing data. But when the drive asks
>>    to tranfer even more trailing data, libata forces it to stop by HSM
>> violation.
>>
>>  
>>
>>> ata2: soft resetting port
>>> ata2: port is slow to respond, please be patient (Status 0xd8)
>>> ata2: port failed to respond (30 secs, Status 0xd8)
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ATA: abnormal status 0xD8 on port 0x177
>>> ata2.00: qc timeout (cmd 0xa1)
>>> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> ata2.00: revalidation failed (errno=-5)
>>> ata2: failed to recover some devices, retrying in 5 secs
>>>     
>>
>>
>> 3. After the HSM violation, the drive stays BSY after the EH resets it.
>>    It seems doesn't like the recovery actions and totally lost.
>>
>> Could you please try the attached patch (together with the previous
>> debug patches).
>> This patch let the drive transfer all of the trailing data it wants to.
>>
>> The data transferred might be junk. So, please also verify the files
>> copied.
>> (e.g. If the file copied from the CD is *.gz file, please do gunzip
>> -tv foo.gz.)
>>
>> -- 
>> albert
>>
>> --- linux-2.6.20.3/drivers/ata/libata-core.c    2007-03-14
>> 02:27:08.000000000 +0800
>> +++ linux-2.6.20.3-mod/drivers/ata/libata-core.c    2007-03-17
>> 12:16:36.000000000 +0800
>> @@ -4143,8 +4143,8 @@ static void __atapi_pio_bytes(struct ata
>>      unsigned char *buf;
>>      unsigned int offset, count;
>>  
>> -    if (qc->curbytes + bytes >= qc->nbytes)
>> -        ap->hsm_task_state = HSM_ST_LAST;
>> +    //if (qc->curbytes + bytes >= qc->nbytes)
>> +    //    ap->hsm_task_state = HSM_ST_LAST;
>>  
>>  next_sg:
>>      if (unlikely(qc->cursg >= qc->n_elem)) {
>> @@ -4166,7 +4166,7 @@ next_sg:
>>          for (i = 0; i < words; i++)
>>              ap->ops->data_xfer(qc->dev, (unsigned char*)pad_buf, 2,
>> do_write);
>>  
>> -        ap->hsm_task_state = HSM_ST_LAST;
>> +        //ap->hsm_task_state = HSM_ST_LAST;
>>          return;
>>      }
>>  
>>   
> 
> 
> Hi,
> 
> Attached is the dmesg after applying the patch to transfer all trailing
> data. There are three lines that appear repeatedly for about 1 minute
> while the CD keeps spinning:
> 
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> 
> The recursive copy eventually fails after copying a few files.
> 
> Thanks,
> Vlad
> 
> 
> ------------------------------------------------------------------------
> 
> Linux version 2.6.20.2 (root@debian) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP PREEMPT Mon Mar 12 05:24:53 CDT 2007
> BIOS-provided physical RAM map:
> sanitize start
> sanitize end
> copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
> copy_e820_map() type is E820_RAM
> copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
> copy_e820_map() start: 00000000000f0400 size: 000000000000fc00 end: 0000000000100000 type: 2
> copy_e820_map() start: 0000000000100000 size: 0000000005f00000 end: 0000000006000000 type: 1
> copy_e820_map() type is E820_RAM
> copy_e820_map() start: 00000000ffff0400 size: 000000000000fc00 end: 0000000100000000 type: 2
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0400 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000006000000 (usable)
>  BIOS-e820: 00000000ffff0400 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 96MB LOWMEM available.
> Entering add_active_range(0, 0, 24576) 0 entries of 256 used
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->    24576
>   HighMem     24576 ->    24576
> early_node_map[1] active PFN ranges
>     0:        0 ->    24576
> On node 0 totalpages: 24576
>   DMA zone: 32 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 4064 pages, LIFO batch:0
>   Normal zone: 160 pages used for memmap
>   Normal zone: 20320 pages, LIFO batch:3
>   HighMem zone: 0 pages used for memmap
> DMI not present or invalid.
> Allocating PCI resources starting at 10000000 (gap: 06000000:f9ff0400)
> Detected 232.124 MHz processor.
> Built 1 zonelists.  Total pages: 24384
> Kernel command line: root=/dev/sda2 ro 
> Local APIC disabled by BIOS -- you can enable it with "lapic"
> mapped APIC to ffffd000 (010c9000)
> Enabling fast FPU save and restore... done.
> Initializing CPU#0
> PID hash table entries: 512 (order: 9, 2048 bytes)
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 90960k/98304k available (1471k kernel code, 6888k reserved, 540k data, 256k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfff54000 - 0xfffff000   ( 684 kB)
>     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>     vmalloc : 0xc6800000 - 0xff7fe000   ( 911 MB)
>     lowmem  : 0xc0000000 - 0xc6000000   (  96 MB)
>       .init : 0xc02fd000 - 0xc033d000   ( 256 kB)
>       .data : 0xc026fd35 - 0xc02f6fb4   ( 540 kB)
>       .text : 0xc0100000 - 0xc026fd35   (1471 kB)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 465.03 BogoMIPS (lpj=930069)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Capability LSM initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> Freeing SMP alternatives: 10k freed
> CPU0: Intel Pentium II (Deschutes) stepping 00
> SMP motherboard not detected.
> Local APIC not detected. Using dummy APIC emulation.
> Brought up 1 CPUs
> PM: Adding info for No Bus:platform
> Time: 21:44:12  Date: 02/13/107
> NET: Registered protocol family 16
> PM: Adding info for No Bus:vtcon0
> EISA bus registered
> PCI: PCI BIOS revision 2.10 entry at 0xfda13, last bus=0
> PCI: Using configuration type 1
> Setting up standard PCI resources
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f68e0
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb27c, dseg 0x400
> PM: Adding info for No Bus:pnp0
> PM: Adding info for pnp:00:00
> PM: Adding info for pnp:00:01
> PM: Adding info for pnp:00:02
> PM: Adding info for pnp:00:03
> PM: Adding info for pnp:00:04
> PM: Adding info for pnp:00:05
> PM: Adding info for pnp:00:06
> PM: Adding info for pnp:00:07
> PM: Adding info for pnp:00:08
> PM: Adding info for pnp:00:09
> PM: Adding info for pnp:00:0a
> PM: Adding info for pnp:00:0b
> PM: Adding info for pnp:00:10
> PnPBIOS: Unknown tag '0x82', length '6'.
> PM: Adding info for pnp:00:11
> PnPBIOS: Unknown tag '0x82', length '4'.
> PM: Adding info for pnp:00:15
> PM: Adding info for pnp:00:16
> PM: Adding info for pnp:00:18
> PM: Adding info for pnp:00:1a
> PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PM: Adding info for No Bus:pci0000:00
> Boot video device is 0000:00:02.0
> PCI quirk: region 8000-803f claimed by PIIX4 ACPI
> PCI quirk: region 2180-218f claimed by PIIX4 SMB
> PIIX4 devres B PIO at 0530-0537
> PIIX4 devres C PIO at 0388-038b
> PIIX4 devres G PIO at 0f00-0f07
> PM: Adding info for pci:0000:00:00.0
> PM: Adding info for pci:0000:00:02.0
> PM: Adding info for pci:0000:00:04.0
> PM: Adding info for pci:0000:00:04.1
> PM: Adding info for pci:0000:00:07.0
> PM: Adding info for pci:0000:00:07.1
> PM: Adding info for pci:0000:00:07.2
> PM: Adding info for pci:0000:00:07.3
> PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> pnp: the driver 'system' has been registered
> pnp: match found with the PnP device '00:04' and the driver 'system'
> pnp: 00:04: ioport range 0x401-0x407 has been reserved
> pnp: match found with the PnP device '00:05' and the driver 'system'
> pnp: match found with the PnP device '00:0a' and the driver 'system'
> pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
> pnp: 00:0a: ioport range 0x2180-0x218f has been reserved
> PM: Adding info for No Bus:mem
> PM: Adding info for No Bus:kmem
> PM: Adding info for No Bus:null
> PM: Adding info for No Bus:port
> PM: Adding info for No Bus:zero
> PM: Adding info for No Bus:full
> PM: Adding info for No Bus:random
> PM: Adding info for No Bus:urandom
> PM: Adding info for No Bus:kmsg
> PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
> PCI: Bus 1, cardbus bridge: 0000:00:04.0
>   IO window: 00001000-000010ff
>   IO window: 00001400-000014ff
>   PREFETCH window: 10000000-13ffffff
>   MEM window: 14000000-17ffffff
> PCI: Bus 5, cardbus bridge: 0000:00:04.1
>   IO window: 00001800-000018ff
>   IO window: 00001c00-00001cff
>   PREFETCH window: 18000000-1bffffff
>   MEM window: 1c000000-1fffffff
> PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
> PCI: setting IRQ 11 as level-triggered
> PCI: Assigned IRQ 11 for device 0000:00:04.0
> PCI: Enabling device 0000:00:04.1 (0000 -> 0003)
> PCI: Assigned IRQ 11 for device 0000:00:04.1
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 49152 bytes)
> TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
> TCP: Hash tables configured (established 4096 bind 2048)
> TCP reno registered
> checking if image is initramfs... it is
> Freeing initrd memory: 3441k freed
> PM: Adding info for platform:pcspkr
> audit: initializing netlink socket (disabled)
> audit(1173822255.424:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Limiting direct PCI/PCI transfers.
> PM: Adding info for platform:vesafb.0
> PM: Adding info for No Bus:pnp1
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> PM: Adding info for No Bus:tty
> PM: Adding info for No Bus:console
> PM: Adding info for No Bus:ptmx
> PM: Adding info for No Bus:tty0
> PM: Adding info for No Bus:vcs
> PM: Adding info for No Bus:vcsa
> PM: Adding info for No Bus:tty1
> PM: Adding info for No Bus:tty2
-- snip --
> PM: Adding info for No Bus:ttypf
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> PM: Adding info for platform:serial8250
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> PM: Adding info for No Bus:ttyS0
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> PM: Adding info for No Bus:ttyS1
> serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
> PM: Adding info for No Bus:ttyS2
> PM: Adding info for No Bus:ttyS3
> pnp: the driver 'serial' has been registered
> pnp: match found with the PnP device '00:0b' and the driver 'serial'
> PM: Removing info for No Bus:ttyS0
> 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> PM: Adding info for No Bus:ttyS0
> PM: Adding info for No Bus:isa
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> pnp: the driver 'i8042 kbd' has been registered
> pnp: match found with the PnP device '00:06' and the driver 'i8042 kbd'
> pnp: the driver 'i8042 aux' has been registered
> pnp: match found with the PnP device '00:16' and the driver 'i8042 aux'
> PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
> PM: Adding info for platform:i8042
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> PM: Adding info for serio:serio0
> PM: Adding info for serio:serio1
> PM: Adding info for No Bus:psaux
> mice: PS/2 mouse device common for all mice
> PM: Adding info for platform:eisa.0
> EISA: Probing bus 0 at eisa.0
> PM: Removing info for platform:eisa.0
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Using IPI Shortcut mode
>   Magic number: 15:868:752
>   hash matches device ttyS3
> Time: tsc clocksource has been installed.
> Freeing unused kernel memory: 256k freed
> PM: Adding info for No Bus:vcs1
> PM: Adding info for No Bus:vcsa1
> input: AT Translated Set 2 keyboard as /class/input/input0
> SCSI subsystem initialized
> libata version 2.00 loaded.
> ata_piix 0000:00:07.1: version 2.00ac7
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFCF0 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFCF8 irq 15
> scsi0 : ata_piix
> PM: Adding info for No Bus:host0
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> USB Universal Host Controller Interface driver v3.0
> ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/33
> scsi1 : ata_piix
> PM: Adding info for No Bus:host1
> ata2.00: ATAPI, max MWDMA2, CDB intr
> ata2.00: configured for MWDMA2
> PM: Adding info for No Bus:target0:0:0
> scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
> PM: Adding info for scsi:0:0:0:0
> PM: Adding info for No Bus:target1:0:0
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x25)
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>          res 58/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)

This is the first problem.
It's weird to see HSM violation here, without any debug task_state trace.
In your previous log, it was detected correctly with debug task_state trace.

ata2.00: ATAPI, max MWDMA2, CDB intr
ata2.00: configured for MWDMA2
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
PM: Adding info for No Bus:target1:0:0
ata2: protocol 5 task_state 4
ata2: protocol 5 task_state 4 (dev_stat 0x58)
ata2: protocol 5 task_state 1
ata2: protocol 5 task_state 1 (dev_stat 0x58)
ata2: protocol 5 task_state 2
ata2: protocol 5 task_state 2 (dev_stat 0x50)
scsi 1:0:0:0: CD-ROM            TORiSAN  DVD-ROM DRD-N216 1.08 PQ: 0 ANSI: 5


> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ata2.00: qc timeout (cmd 0xa1)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
-- snip -- 

> 
> ##### Inserted CD and ran "mount /dev/sr0 /root/cdrom" #####
> 

-- snip --
The mount trace looks ok. No problems here.

> 
> ##### Ran "cp -r /root/cdrom /root/cdrom_copy" #####
> 
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 124928 in
>          res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ata2.00: qc timeout (cmd 0xa1)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ata2.00: qc timeout (cmd 0xa1)

This is the second problem. The device firmware/state machine stopped
working suddenly. The INTRQ was not cleared even after the device status
register was read. And the device status was struck to 0x58.
Let the device transfer the trailing data without limitation didn't help.

Vlad, could you please apply the attached debug patch. The patch
1. adds your TORiSAM drive to the DMA blacklist
   (so, we don't need to the check_atapi_dma() change this time)
2. adds more debug trace
Hopefully we can have some clue for the 1st (HSM violation) problem.

For the 2nd problem, could you please try change the medium and copy
the data from another known to be good CD? It might be the medium that
caused the device firmware malfunction.

Thanks.
--
albert

diff -Nrup linux-2.6.20.3/drivers/ata/libata-core.c linux-2.6.20.3-mod/drivers/ata/libata-core.c
--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/libata-core.c	2007-03-18 17:52:59.000000000 +0800
@@ -3296,6 +3296,7 @@ static const struct ata_blacklist_entry 
 	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
 	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
 	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
@@ -4371,8 +4372,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+	if (ap->id == 2)
+		printk(KERN_ERR "ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5091,8 +5093,14 @@ inline unsigned int ata_host_intr (struc
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+	if (ap->id == 2) {
+		printk(KERN_ERR "ata%u: protocol %d task_state %d\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state);
+
+		host_stat = ap->ops->bmdma_status(ap);
+		printk(KERN_ERR "ata%u: host_stat 0x%X\n", ap->id, host_stat);
+		
+	}
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
diff -Nrup linux-2.6.20.3/drivers/ata/libata-scsi.c linux-2.6.20.3-mod/drivers/ata/libata-scsi.c
--- linux-2.6.20.3/drivers/ata/libata-scsi.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/libata-scsi.c	2007-03-18 17:59:41.000000000 +0800
@@ -2729,17 +2729,17 @@ static inline ata_xlat_func_t ata_get_xl
 static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 				     struct scsi_cmnd *cmd)
 {
-#ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
 	u8 *scsicmd = cmd->cmnd;
 
-	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
-		ap->id,
-		scsidev->channel, scsidev->id, scsidev->lun,
-		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
-		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
-		scsicmd[8]);
-#endif
+	if (ap->id == 2) {
+		printk(KERN_ERR "CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		       ap->id,
+		       scsidev->channel, scsidev->id, scsidev->lun,
+		       scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+		       scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+		       scsicmd[8]);
+	}
 }
 
 static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,


