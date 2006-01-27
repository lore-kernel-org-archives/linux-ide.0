From: Kenneth Crudup <kenny@panix.com>
Subject: Two really quick questions about SATA on Linux
Date: Fri, 27 Jan 2006 01:18:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601270114550.28844@vaio.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.panix.com ([166.84.1.72]:30168 "EHLO mail1.panix.com")
	by vger.kernel.org with ESMTP id S932433AbWA0JSk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 04:18:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


  (I'd sent this before, but didn't get an answer; I did the copy to
  the linux-ide list as you'd instructed at the head of .../drivers/scsi/ahci.c
  and trying again.)

I have a Sony Vaio with both ICH6 IDE legacy (the DVD-R) and ICH6 SATA
(the hard disk):

----
# lspci -vv
<snip>

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Sony Corporation Unknown device 81b9
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 217
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Sony Corporation Unknown device 81ba
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 201
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e880 [size=4]
        Region 2: I/O ports at e800 [size=8]
        Region 3: I/O ports at e480 [size=4]
        Region 4: I/O ports at e400 [size=16]
        Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
<snip>
----

I'm running 2.6.14.5 (since .13.2) .

I can use either CONFIG_SCSI_SATA_AHCI or CONFIG_SCSI_ATA_PIIX in this
machine with no problems (I also have CONFIG_BLK_DEV_PIIX set, but that
driver only interacts with the legacy ports). Either ICH6 driver appears
to have the same thruput and usage, looking superficially.

My questions are:

- I suspect that the AHCI is the better driver to use. True?

- There is one issue with AHCI vs. ATA_PIIX - AHCI won't let my machine
  reboot under linux. I tried making CONFIG_BLK_DEV_PIIX a module and
  loading it after boot, but it doesn't seem to matter (doesn't reboot
  even with that unloaded). Have you seen that problem before? (I wonder
  if it's due to the deregistration code, which appears to shut down
  the interface?)

Any thoughts?

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Los Angeles
H: 3630 S. Sepulveda Blvd. #138, L.A., CA 90034-6809      (888) 454-8181
