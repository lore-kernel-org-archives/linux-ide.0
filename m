From: Pavel Roskin <proski@gnu.org>
Subject: libata - Toshiba Portege 300CT experience
Date: Fri, 01 Dec 2006 00:25:39 -0500
Message-ID: <1164950739.4870.20.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:24286 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1759077AbWLAFZn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 00:25:43 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.52)
	id 1Gq0u5-00087D-9r
	for linux-ide@vger.kernel.org; Fri, 01 Dec 2006 00:25:41 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1Gq0u3-0002vv-S0
	for linux-ide@vger.kernel.org; Fri, 01 Dec 2006 00:25:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

I've just tested Linux 2.6.19 on Toshiba Portege 300CT.  It's a
"half-PCI" laptop, in the sense that it has a PCI but not all essential
devices are shown by lspci.  In particular, the IDE controller is not
seen in the lspci output:

00:00.0 Host bridge: Toshiba America Info Systems CPU to PCI bridge (rev 26)
00:02.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
00:02.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
00:04.0 VGA compatible controller: Chips and Technologies F65554 (rev c2)
00:0b.0 USB Controller: NEC Corporation USB (rev 01)

First of all, I'll appreciate if the description of CONFIG_ATA_GENERIC
is changed to specify that it's a driver for PCI devices only.  What I
needed was CONFIG_PATA_LEGACY, but I didn't notice it initially because
it was experimental.

The laptop has a hard drive and a CD-ROM.  Neither is detected even with
CONFIG_PATA_LEGACY.  The problem with IDENTIFY reminds me problems I
reported earlier with an IBM laptop.  The difference is that it's the
present devices that fail to be detected, not the absent ones.  As a
result, the system only boots to initrams.

Unfortunately, the Toshiba laptop is way too slow and disk-challenged
for me to try the libata git repository on it.  But I think I'll post
the results from 2.6.19 anyway in case anyone cares.

This was captured on the serial console.

Linux version 2.6.19 (proski@ct) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubunt6
BIOS-provided physical RAM map:                                                                 
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)                                        
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)                                      
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)                                      
 BIOS-e820: 0000000000100000 - 0000000004020000 (usable)                                        
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)                                      
64MB LOWMEM available.                                                                          
Zone PFN ranges:                                                                                
  DMA             0 ->     4096                                                                 
  Normal       4096 ->    16416                                                                 
early_node_map[1] active PFN ranges                                                             
    0:        0 ->    16416                                                                     
DMI not present or invalid.                                                                     
Allocating PCI resources starting at 10000000 (gap: 04020000:fbfc0000)                          
Detected 132.636 MHz processor.                                                                 
Built 1 zonelists.  Total pages: 16288                                                          
Kernel command line: root=LABEL=ubuntu ro console=ttyS0,115200                                  
Initializing CPU#0                                                                              
PID hash table entries: 256 (order: 8, 1024 bytes)                                              
Console: colour VGA+ 80x25                                                                      
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)                                   
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)                                    
Memory: 56060k/65664k available (1701k kernel code, 9196k reserved, 532k data, 144k init, 0k hi)
virtual kernel memory layout:                                                                   
    fixmap  : 0xffffc000 - 0xfffff000   (  12 kB)                                               
    vmalloc : 0xc5000000 - 0xffffa000   ( 943 MB)                                               
    lowmem  : 0xc0000000 - 0xc4020000   (  64 MB)                                               
      .init : 0xc0332000 - 0xc0356000   ( 144 kB)                                               
      .data : 0xc02a97b1 - 0xc032e96c   ( 532 kB)                                               
      .text : 0xc0100000 - 0xc02a97b1   (1701 kB)                                               
Checking if this processor honours the WP bit even in supervisor mode... Ok.                    
Calibrating delay using timer specific routine.. 265.77 BogoMIPS (lpj=531544)                   
Mount-cache hash table entries: 512                                                             
Intel Pentium with F0 0F bug - workaround enabled.                                              
                                                                                                
CPU: Intel Pentium MMX stepping 03                                                              
Checking 'hlt' instruction... OK.                                                               
Unpacking initramfs... done                                                                     
Freeing initrd memory: 6088k freed                                                              
NET: Registered protocol family 16                                                              
PCI: Using configuration type 1                                                                 
Setting up standard PCI resources                                                               
Linux Plug and Play Support v0.97 (c) Adam Belay                                                
PnPBIOS: Scanning system for PnP BIOS support...                                                
PnPBIOS: Found PnP BIOS installation structure at 0xc00f8fc0                                    
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9df3, dseg 0x0                                   
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver                                   
SCSI subsystem initialized                                                                      
usbcore: registered new interface driver usbfs                                                  
usbcore: registered new interface driver hub                                                    
usbcore: registered new device driver usb                                                       
PCI: Probing PCI hardware                                                                       
PCI: Bus 1, cardbus bridge: 0000:00:02.0                                                        
  IO window: 00001000-000010ff                                                                  
  IO window: 00001400-000014ff                                                                  
  PREFETCH window: 10000000-11ffffff                                                            
  MEM window: 12000000-13ffffff                                                                 
PCI: Bus 5, cardbus bridge: 0000:00:02.1                                                        
  IO window: 00001800-000018ff                                                                  
  IO window: 00001c00-00001cff                                                                  
  PREFETCH window: 14000000-15ffffff                                                            
  MEM window: 16000000-17ffffff                                                                 
PCI: Enabling device 0000:00:02.0 (0004 -> 0007)                                                
PCI: Enabling device 0000:00:02.1 (0004 -> 0007)                                                
NET: Registered protocol family 2                                                               
IP route cache hash table entries: 512 (order: -1, 2048 bytes)                                  
TCP established hash table entries: 2048 (order: 1, 8192 bytes)                                 
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)                                        
TCP: Hash tables configured (established 2048 bind 1024)                                        
TCP reno registered                                                                             
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16ac)                                        
io scheduler noop registered                                                                    
io scheduler anticipatory registered (default)                                                  
isapnp: Scanning for PnP cards...                                                               
isapnp: No Plug & Play device found                                                             
Real Time Clock Driver v1.12ac                                                                  
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled                       
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A                                            
hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)                                    
ata1: PATA max PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0x0 irq 15                                        
scsi0 : pata_legacy                                                                             
ata1.00: qc timeout (cmd 0xec)                                                                  
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
ata1.00: qc timeout (cmd 0xec)                                                                  
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
ata1.00: qc timeout (cmd 0xec)                                                                  
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
ata2: PATA max PIO4 cmd 0x170 ctl 0x376 bmdma 0x0 irq 14                                        
scsi1 : pata_legacy                                                                             
ata2.00: qc timeout (cmd 0xa1)                                                                  
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
ata2.00: qc timeout (cmd 0xa1)                                                                  
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
ata2.00: qc timeout (cmd 0xa1)                                                                  
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)                                           
Yenta: CardBus bridge found at 0000:00:02.0 [0000:0000]                                         
Yenta: ISA IRQ mask 0x0000, PCI irq 11                                                          
Socket status: 30000010                                                                         
Yenta: CardBus bridge found at 0000:00:02.1 [0000:0000]                                         
Yenta: ISA IRQ mask 0x0000, PCI irq 11                                                          
Socket status: 30000006                                                                         
ohci_hcd 0000:00:0b.0: OHCI Host Controller                                                     
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1                            
ohci_hcd 0000:00:0b.0: irq 11, io mem 0xfdfff000                                                
usb usb1: configuration #1 chosen from 1 choice                                                 
hub 1-0:1.0: USB hub found                                                                      
hub 1-0:1.0: 2 ports detected                                                                   
pccard: PCMCIA card inserted into slot 0                                                        
usbcore: registered new interface driver usbhid                                                 
/home/proski/src/linux-2.6.19/drivers/usb/input/hid-core.c: v2.6:USB HID core driver            
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12                                    
serio: i8042 KBD port at 0x60,0x64 irq 1                                                        
serio: i8042 AUX port at 0x60,0x64 irq 12                                                       
mice: PS/2 mouse device common for all mice                                                     
input: PC Speaker as /class/input/input0                                                        
input: AT Translated Set 2 keyboard as /class/input/input1                                      
TCP cubic registered                                                                            
NET: Registered protocol family 1                                                               
NET: Registered protocol family 17                                                              
ieee80211: 802.11 data/management/control stack, git-1.1.13                                     
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>                 
Using IPI Shortcut mode                                                                         
Time: tsc clocksource has been installed.                                                       
Freeing unused kernel memory: 144k freed                                                        

And that's what the 2.6.19 kernel with IDE reports:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: TOSHIBA MK6409MAV, ATA DISK drive
Probing IDE interface ide1...
hdc: TOSHIBA CD-ROM XM-1502BN, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 12685680 sectors (6495 MB), CHS=13424/15/63
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 >
hdc: ATAPI 10X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20


-- 
Regards,
Pavel Roskin


