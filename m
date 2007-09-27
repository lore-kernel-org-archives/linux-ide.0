From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: T61 SATA error in log
Date: Thu, 27 Sep 2007 17:21:08 +1000
Message-ID: <1190877668.30275.3.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47215 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755654AbXI0HVV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 03:21:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Saw that popping up in my log today on a brand new T61 thinkpad:

[  427.712000] ata1.00: exception Emask 0x2 SAct 0x18 SErr 0x0 action 0x2 frozen
[  427.712000] ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x18 FIS=004040a1:00000024)
[  427.712000] ata1.00: cmd 61/08:18:f4:74:54/00:00:04:00:00/40 tag 3 cdb 0x0 data 4096 out
[  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
[  427.712000] ata1.00: cmd 61/08:20:84:10:81/00:00:04:00:00/40 tag 4 cdb 0x0 data 4096 out
[  427.712000]          res 40/00:28:64:e4:51/00:00:04:00:00/40 Emask 0x2 (HSM violation)
[  428.024000] ata1: soft resetting port
[  428.196000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  428.204000] ata1.00: configured for UDMA/100
[  428.204000] ata1: EH complete
[  428.204000] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
[  428.204000] sd 0:0:0:0: [sda] Write Protect is off
[  428.204000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  428.204000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Kernel recovered just fine and things seem smooth so far. Is that something I need
to worry about ?

Kernel is ubuntu gutsy's 2.6.22 and controller is:

Cheers,00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev 03) (prog-if 01 [AHCI 1.0])
        Subsystem: Lenovo Unknown device 20a7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 218
        Region 0: I/O ports at 1c50 [size=8]
        Region 1: I/O ports at 1c44 [size=4]
        Region 2: I/O ports at 1c48 [size=8]
        Region 3: I/O ports at 1c40 [size=4]
        Region 4: I/O ports at 1c20 [size=32]
        Region 5: Memory at fe226000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/2 Enable+
                Address: fee0300c  Data: 4152
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] #12 [0010]


Cheers,
Ben.


