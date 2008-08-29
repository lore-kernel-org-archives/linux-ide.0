From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA Cold Boot problems on >2.6.25 with NV
Date: Fri, 29 Aug 2008 08:44:16 -0600
Message-ID: <48B80B40.5060002@shaw.ca>
References: <fa.CVrJhjm3R8sjl5Z+EEIzYm7QtW0@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:21664 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYH2OoQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 10:44:16 -0400
In-Reply-To: <fa.CVrJhjm3R8sjl5Z+EEIzYm7QtW0@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

(ccing linux-ide)

Tejun, another one of these reset issues?

Konstantin Kletschke wrote:
> Hello!
> 
> 
> I found to references regarding this problem in this list. Many Maxwell
> reported this and Tejo asked if his supposed fix helps out. 
> 
> Another reference by Jeff suggests bisecting a git commit. Since I am
> very unexperienced in the git stuff I hope it is okay to start another
> initial mail about this to ask
> 
> 1.) What I should try out on the code to trace this further down
> 
> 2.) I would extend this problem on >2.6.25 version of kernel.
> 
> I have an "nForce3 250 chipset" on an Asrock K8Upgrade-NF3 Motherboard
> 
> 00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
> 00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
> 00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
> 00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
> 00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
> 00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2)
> 00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
> 00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
> 00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2)
> 00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2)
> 00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2)
> 00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
> 02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 
> While 2.6.25 works very fine I experienced this with 2.6.26_rc7 at first 
> (I skipped versions between). Cold Boot yields into the described error,
> I sadly only have real screenshots of this:
> 
> http://ludenkalle.de/sata
> 
> After a reset the Kernel was not able to do anything useful with the
> SATA interface anymore (this description is a bit vague, IIRC it stuck
> immediately around "SATA Link down..."). Only powercycling helped out,
> then it booted with SATA.
> 
> Now I have 2.6.27-rc3, same error but config netconsole enabled.
> Normal Boot:
> 
> ata1: SATA link down (SStatus 0 SControl 300)
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATA-7: SAMSUNG HD753LJ, 1AA01106, max UDMA7
> ata2.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
> ata2.00: configured for UDMA/133
> isa bounce pool size: 16 pages
> scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD753LJ  1AA0 PQ: 0 ANSI: 5
> sd 1:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sda] Write Protect is off
> sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 1:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
> sd 1:0:0:0: [sda] Write Protect is off
> sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
> sd 1:0:0:0: [sda] Attached SCSI disk
> PNP: No PS/2 controller found. Probing ports directly.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> TCP cubic registered
> NET: Registered protocol family 17
> XFS mounting filesystem sda1
> VFS: Mounted root (xfs filesystem) readonly.
> Freeing unused kernel memory: 220k freed
> 
> Cold Boot:
> 
> ata1: SATA link down (SStatus 0 SControl 300)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: COMRESET failed (errno=-16)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2: COMRESET failed (errno=-16)
> ata2: reset failed, giving up
> PNP: No PS/2 controller found. Probing ports directly.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> TCP cubic registered
> NET: Registered protocol family 17
> VFS: Cannot open root device "801" or unknown-block(8,1)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)
> 
> Hmn, thats it. Where should I poke into?
> 
> Kind Regards, Konsti
> 
> 

