From: Wes Newell <w.newell@verizon.net>
Subject: Pata support for SIS180
Date: Sat, 11 Jun 2005 08:35:45 -0500
Message-ID: <42AAE8B1.8080607@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:48064 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261698AbVFKNcY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Jun 2005 09:32:24 -0400
Received: from [192.168.0.2] ([70.104.23.44])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IHX00CZ79LZAHMB@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Sat, 11 Jun 2005 08:32:23 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux.ide" <linux-ide@vger.kernel.org>

Can anyone tell me if/how one could add device support for the sis180 
chipset pata ports to the sis5513 module? I've tried adding this as 
others have said it works for the 965 southbridge,

if ((trueid == 0x5518) || (trueid == 0x0180)) {

 but it stll doesn't see a real sis180 on a Jetway S755MAX MB.

Here's the device info.

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

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS]
00: 39 10 80 01 07 04 20 02 00 85 04 01 00 80 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 01 ec 00 00 01 00 00 00 00 00 00 00 39 10 80 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 56 23 06 04 56 23 06 04 00 00 00 00 00 00 00 00
50: 82 20 82 00 2a 96 00 03 00 00 00 00 00 00 00 00
60: ff aa 00 00 d9 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bd 33 72 40 bd 33 72 40 00 00 00 00 00 00 00 00
90: 34 00 00 03 6f 05 00 00 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



-- 
Abit KT7-Raid (KT133) Tbred B core CPU @2400MHz (24x100FSB)
My server http://wesnewell.no-ip.com/cpu.php
Verizon server http://mysite.verizon.net/res0exft/cpu.htm

