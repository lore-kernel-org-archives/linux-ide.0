From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Mon,  3 Mar 2008 03:40:40 -0800 (PST)
Message-ID: <20080303114040.2174C108065@picon.linux-foundation.org>
References: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750924AbYCCLlJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 06:41:09 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m23BelpK023333
	for <linux-ide@vger.kernel.org>; Mon, 3 Mar 2008 03:40:48 -0800
In-Reply-To: <bug-9904-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904





------- Comment #6 from Manfred.Knick@T-Online.de  2008-03-03 03:40 -------
(In reply to comment #4)
> ASUS M2N-SLI Deluxe with NVidia nForce 570 SLI MCP
> 
> Primary Master: Plextor PX-130A - fails to detect 80-wire
> Primary Slave:  Plextor PX-760A + succeeds

Sorry- forgot to mention:

$ uname -a
Linux mammut 2.6.24-gentoo-r3 #2 SMP Mon Mar 3 11:34:50 CET 2008 x86_64 AMD
Athlon(tm) 64 X2 Dual Core Processor 5200+ AuthenticAMD GNU/Linux


$ dmesg :

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP55: IDE controller (0x10de:0x036e rev 0xa1) at  PCI slot 0000:00:04.0
NFORCE-MCP55: not 100% native mode: will probe irqs later
NFORCE-MCP55: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-MCP55: 0000:00:04.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
NFORCE-MCP55: IDE port disabled
Probing IDE interface ide0...
hdb: PLEXTOR DVDR PX-760A, ATAPI CD/DVD-ROM drive
hda: PLEXTOR DVD-ROM PX-130A, ATAPI CD/DVD-ROM drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hda: UDMA/33 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/66 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
