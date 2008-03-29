From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Sat, 29 Mar 2008 06:36:37 -0700 (PDT)
Message-ID: <20080329133637.2DAB5108039@picon.linux-foundation.org>
References: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37800 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751249AbYC2NhG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 09:37:06 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2TDabvc030018
	for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 06:36:38 -0700
In-Reply-To: <bug-9904-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904





------- Comment #10 from jtsn@gmx.de  2008-03-29 06:36 -------
With libata the problem also occurs:

scsi3 : pata_ali
scsi4 : pata_ali
ata4: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata5: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
ata4.00: ATA-7: HDT722525DLAT80, V44OA70A, max UDMA/133
ata4.00: 488397168 sectors, multi 16: LBA48 
ata4.01: ATA-5: ST340016A, 3.10, max UDMA/100
ata4.01: 78165360 sectors, multi 16: LBA 
ata4.00: configured for UDMA/133
ata4.01: configured for UDMA/100
ata5.00: ATAPI: MATSHITADVD-RAM SW-9576S, AY0J, max UDMA/66
ata5.01: ATAPI: ASUS    DVD-E616A, 1.08, max UDMA/100
ata5.01: limited to UDMA/33 due to 40-wire cable
ata5.00: configured for UDMA/66
ata5.01: configured for UDMA/33

/dev/sr1:

ATAPI CD-ROM, with removable media
        Model Number:       ASUS    DVD-E616A                       
        Serial Number:      
        Firmware Revision:  1.08    
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(cannot be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=227ns  IORDY flow control=120ns


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
