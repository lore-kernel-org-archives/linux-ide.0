From: "Hoka \"ME\" Tichenci" <melkin@uci.edu>
Subject: sata_nv fails to reattach drive during hotswap?
Date: Sun, 10 Dec 2006 02:24:16 -0800
Message-ID: <457BE050.9090109@uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36482 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760648AbWLJKYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Dec 2006 05:24:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061210102403.ONNH7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>
          for <linux-ide@vger.kernel.org>; Sun, 10 Dec 2006 05:24:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm currently using an Asus A8N-SLI Premium which offers 8 ports (4
each) through a SI3114 and CK804 chipset. I have a generic istar/athena
4 in 3 SATA hot swap cage thats worked for very well with my Areca array
on another system. When booting, it detects the drive just fine
connected to the sata_nv controller. When I detach the drive, it also
cleanly removes the device node. The problem is reattaching a drive
(turning the power back on), libata will apparently detect the new
drive, but then the port will "fail to respond" about twice before the
link is determined. After this stage EH is complete, but the drive is
nowhere to be found. udevmonitor --env shows nothing after the removal
of the block device, it does not exist under /dev/sd*, and does not show
up anywhere that I can find. I've tried multiple kernels, all have the
same results. When I use the si3114 controller, hotswapping works
exactly as desired. I have a post on the gentoo forums about the issue,
but I will also append on the important bits:
http://forums.gentoo.org/viewtopic-t-523012.html

Any help, ideas, suggestions, questions, and pointers are appreciated.

--hoka

Kernels attempted:
Gentoo-sources 2.6.19-r1
Gentoo-hardened-sources 2.6.18
2.6.19-rc6-mm2
2.6.19-git12

lspci:
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller
(rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 RAID bus controller: nVidia Corporation CK804 Serial ATA
Controller (rev f3)
00:08.0 RAID bus controller: nVidia Corporation CK804 Serial ATA
Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
05:07.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX
5200] (rev a1)
05:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)

A sample of the kernel log showing the problem:
ata5: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
ata5: soft resetting port
ata5: SATA link down (SStatus 0 SControl 300)
ata5: failed to recover some devices, retrying in 5 secs
ata5: hard resetting port
ata5: SATA link down (SStatus 0 SControl 300)
ata5: failed to recover some devices, retrying in 5 secs
ata5: hard resetting port
ata5: SATA link down (SStatus 0 SControl 300)
ata5.00: disabled
ata5: EH complete
ata5.00: detaching (SCSI 4:0:0:0)
PM: Removing info for scsi:4:0:0:0
PM: Removing info for No Bus:target4:0:0
ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata5: port is slow to respond, please be patient
ata5: port failed to respond (30 secs)
ata5: soft resetting port
ata5: port is slow to respond, please be patient
ata5: port failed to respond (30 secs)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5: EH complete
