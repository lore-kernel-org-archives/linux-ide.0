From: Tim Small <tim@seoss.co.uk>
Subject: Forcing a an Intel ICH9R into AHCI mode after boot
Date: Tue, 06 Apr 2010 08:53:10 +0100
Message-ID: <4BBAE866.4060903@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:38593 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab0DFInV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 04:43:21 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay1.allsecurenet.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <tim@seoss.co.uk>)
	id 1Nz3ay-0004ZN-OS
	for linux-ide@vger.kernel.org; Tue, 06 Apr 2010 07:53:13 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zebedee.buttersideup.com (Postfix) with ESMTP id A31949B778
	for <linux-ide@vger.kernel.org>; Tue,  6 Apr 2010 08:53:10 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a box (Dell Poweredge R300) which I could really do with SATA
hotplug functionality on.  The BIOS doesn't have any AHCI support (and
won't according to Dell) - and puts the ICH9R into PIIX mode, but I'd
like to try and force it into AHCI mode to see if this is a workable
solution...

I've used setpci to stick the SATA controller into AHCI mode, and the
fakephp driver to get the device rescanned by Linux, I now have an AHCI
mode pci device showing up with lspci, but when loading the ahci driver
I get:

ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: device not available because of BAR 0 [cc20:cc27]
collisions

This is what I did:

setpci -s 00:1f.2 0x90.w=0x0060
modprobe fakephp
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.0/power
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.2/power
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.5/power
echo 0 > /sys/bus/pci/slots/0000\:00\:1f.2/power
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.2/power
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.0/power
echo 1 > /sys/bus/pci/slots/0000\:00\:1f.5/power
modprobe ahci

The kernel version is 2.6.26-2 (Debian 5.0).


lspci gives:

00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6
port SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
       Subsystem: Dell Device 020f
       Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B- DisINTx-
       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin C routed to IRQ 6
       Region 0: I/O ports at cc20 [size=8]
       Region 1: I/O ports at cc10 [size=4]
       Region 2: I/O ports at cc28 [size=8]
       Region 3: I/O ports at cc14 [size=4]
       Region 4: I/O ports at cc40 [size=32]
       Region 5: Memory at 0000c800 (32-bit, non-prefetchable) [size=2K]
       Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/4 Enable-
               Address: 00000000  Data: 0000
       Capabilities: [70] Power Management version 3
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [a8] SATA HBA <?>
       Capabilities: [b0] PCIe advanced features <?>
       Kernel modules: ahci



... and I can't really work out why it thinks this...  No over-laping
stuff is showing up in /proc/ioports or the rest of the lspci output.
Here's a diff of the lspci output before/after:

-00:1f.2 IDE interface [0101]: Intel Corporation 82801IR/IO/IH
(ICH9R/DO/DH) 4 port SATA IDE Controller [8086:2920] (rev 02) (prog-if
8f [Master SecP SecO PriP PriO])
-       Subsystem: Dell PowerEdge R300 onboard SATA Controller [1028:020f]
+00:1f.2 SATA controller [0106]: Intel Corporation 82801IR/IO/IH
(ICH9R/DO/DH) 6 port SATA AHCI Controller [8086:2922] (rev 02) (prog-if
01 [AHCI 1.0])
+       Subsystem: Dell Device [1028:020f]
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B- DisINTx-
       Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0
-       Interrupt: pin C routed to IRQ 23
+       Interrupt: pin C routed to IRQ 6
       Region 0: I/O ports at bc20 [size=8]
       Region 1: I/O ports at bc10 [size=4]
       Region 2: I/O ports at bc28 [size=8]
       Region 3: I/O ports at bc14 [size=4]
-       Region 4: I/O ports at bc40 [size=16]
-       Region 5: I/O ports at bc50 [size=16]
+       Region 4: I/O ports at bc40 [size=32]
+       Region 5: Memory at 0000b800 (32-bit, non-prefetchable) [size=2K]
+       Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/4 Enable-
+               Address: 00000000  Data: 0000
       Capabilities: [70] Power Management version 3
-               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
+               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
+       Capabilities: [a8] SATA HBA <?>
       Capabilities: [b0] PCIe advanced features <?>
-       Kernel driver in use: ata_piix
-       Kernel modules: ata_piix, ata_generic, ide-pci-generic
+       Kernel modules: ahci




I know this is hacky, but it'd be nice to get it working... Any ideas?

Cheers,

Tim.
