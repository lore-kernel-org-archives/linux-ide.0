From: Oltion Kola <oltion.kola@myself.com>
Subject: via 6421 hangs with 2 disks attached
Date: Sat, 21 Dec 2013 21:56:21 +0100
Message-ID: <52B60075.6030207@myself.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.gmx.net ([74.208.4.201]:51606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941Ab3LUU4q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Dec 2013 15:56:46 -0500
Received: from [192.168.1.4] ([79.106.109.154]) by mail.gmx.com (mrgmxus001)
 with ESMTPSA (Nemesis) id 0LngAj-1VHsGI27El-00hvFv for
 <linux-ide@vger.kernel.org>; Sat, 21 Dec 2013 21:56:45 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a problem with my pci sata controller with a via chipset:

When i attach 2 disks to the controller, the kernel hangs at the moment 
it detects the 2 disks. I can not attach logs as the system is 
unresponsive after that. With only one disk everything is ok.

Tested with all kernels.

This is my pci print for the card:

01:06.3 RAID bus controller: VIA Technologies, Inc. VT6421 IDE/SATA 
Controller (rev 50)
     Subsystem: VIA Technologies, Inc. VT6421 IDE/SATA Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+ INTx-
     Latency: 64
     Interrupt: pin A routed to IRQ 18
     Region 0: I/O ports at dd60
     Region 1: I/O ports at dd70
     Region 2: I/O ports at dd80
     Region 3: I/O ports at dd90
     Region 4: I/O ports at dde0
     Region 5: I/O ports at de00
     Expansion ROM at fea00000 [disabled]
     Capabilities: [e0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

I have put some information also in 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/570434 as it is an 
old bug.

Let me know if I can do anything to help.

Thanks.
