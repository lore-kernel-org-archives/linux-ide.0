From: Peter Smith <peter.smith@utsouthwestern.edu>
Subject: Promise SATAII150 TX4 cards
Date: Mon, 22 Nov 2004 09:02:47 -0600
Message-ID: <41A1FF97.908@utsouthwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swlx168.swmed.edu ([199.165.152.168]:61384 "EHLO
	swlx168.swmed.edu") by vger.kernel.org with ESMTP id S262134AbUKVPCu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Nov 2004 10:02:50 -0500
Received: from [129.112.118.137] (helo=[129.112.118.137])
	by swlx168.swmed.edu with esmtp (Exim 4.34)
	id 1CWFiJ-0007VF-Kw
	for linux-ide@vger.kernel.org; Mon, 22 Nov 2004 09:02:47 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have two of the Promise SATAII150 TX4 PCI cards [1] and have managed 
to get them to work with the v2.6.9 kernel [2].  I was able to do this 
by following some of the steps given in the thread [3] posted in a 
message sent about the same card but in chipset/motherboard form [4].  
The following are the parsed results of an 'lspci'.

02:0a.0 Unknown mass storage controller: Promise Technology, Inc. 
PDC20518 SATAII 150 IDE Controller (rev 02)
02:0d.0 Unknown mass storage controller: Promise Technology, Inc. 
PDC20518 SATAII 150 IDE Controller (rev 02)

The following are the parsed results of an 'lspci -vvn'

02:0a.0 Class 0180: 105a:3d18 (rev 02)
        Subsystem: 105a:3d18
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at e480 [size=128]
        Region 2: I/O ports at e000 [size=256]
        Region 3: Memory at f9ffd000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at f9fc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fa000000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 Class 0180: 105a:3d18 (rev 02)
        Subsystem: 105a:3d18
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (1000ns min, 4500ns max), Cache Line Size 01
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at e400 [size=128]
        Region 2: I/O ports at dc00 [size=256]
        Region 3: Memory at f9ffc000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at f9fa0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fa000000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I had to create a fully patched Fedora Core 3 kernel SRPM in order to 
enable this card.  Following is only the patch to the kernel itself.

--- linux-2.6.9/drivers/scsi/sata_promise.c       2004-10-18 
16:54:39.000000000 -0500
+++ linux-2.6.9/drivers/scsi/sata_promise.c    2004-11-22 
08:59:41.998728025 -0600
@@ -156,6 +156,8 @@
          board_2037x },
        { PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_2037x },
+       { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -408,6 +410,8 @@

         spin_lock(&host_set->lock);

+        writel(mask, mmio_base + PDC_INT_SEQMASK);
+
         for (i = 0; i < host_set->n_ports; i++) {
                VPRINTK("port %u\n", i);
                ap = host_set->ports[i];

I hope that this, at some point, can be included in the full 2.6 kernel 
tree.  I have three ports in use on the 02:0a card while I have two 
ports in use on the 02:0d card.  I've been using them since Friday 
night, 20041119.  This is, of course, only possible thanks to the very 
usable code for the Promise driver provided by Jeff Garzik and/or Red Hat.

Thanks,
Peter Smith

[1] 
http://www.promise.com/product/product_detail_eng.asp?productId=129&familyId=3
[2] http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=110048258200852&w=2
[4] http://marc.theaimsgroup.com/?t=109751325100002&r=1&w=2
