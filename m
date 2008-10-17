From: Artem Bokhan <aptem@ngs.ru>
Subject: sata_mv, io stucks
Date: Fri, 17 Oct 2008 19:25:45 +0700
Message-ID: <48F88449.1000704@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1.ngs.ru ([195.93.186.195]:45295 "EHLO smtpout1.ngs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468AbYJQMcT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Oct 2008 08:32:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

I try to simulate random reads  with "sysbench --test=fileio 
--num-threads=16 --max-requests=9999999 --max-time=60 --init-rng=on 
--file-num=16 --file-fsync-freq=0 --file-test-mode=rndrd 
--file-total-size=30G run"

Two marvell controllers, 16 disks, software raid10, IO stucks on 
different disks, kernel 2.6.26.5.
With default ubuntu's 8.04 2.6.24 kernel the problem can not be repeated


[  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 
0x6 frozen
[  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 tag 0 
ncq 4096 out
[  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  289.851774] ata11.00: status: { DRDY }
[  289.851834] ata11: hard resetting link
[  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  290.749239] ata11.00: max_sectors limited to 256 for NCQ
[  290.809189] ata11.00: max_sectors limited to 256 for NCQ
[  290.809194] ata11.00: configured for UDMA/133
[  290.809200] ata11: EH complete
[  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware sectors 
(1000205 MB)
[  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
[  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA


lspci:

05:01.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at d8200000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at 3000 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=05:01.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-

05:02.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at d8300000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at 3400 [size=256]
        Region 3: [virtual] Memory at d8800000 (32-bit, 
non-prefetchable) [size=4M]
        [virtual] Expansion ROM at d9000000 [disabled] [size=4M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=05:02.0 64bit+ 133MHz+ SCD- USC- DC=simple 
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-

