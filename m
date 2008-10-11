From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Fri, 10 Oct 2008 17:20:51 -0700 (PDT)
Message-ID: <20081011002051.E0BF3108047@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44657 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753072AbYJKAUx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 20:20:53 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9B0KpJn015472
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 17:20:52 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #2 from bumble.bee@xs4all.nl  2008-10-10 17:20 -------
Hi Alan, I'd love to do just that. Maybe if this thing can perform in PIO mode
it won't matter that there's no DMA.
I've built a kernel and initrd for both delkin_cb and pata_ninja32.

# hdparm -t /dev/hde
/dev/hde:
 Timing buffered disk reads:   10 MB in  3.35 seconds =   2.98 MB/sec
# hdparm -t /dev/sdb
/dev/sdb:
 Timing buffered disk reads:    6 MB in  3.27 seconds =   1.84 MB/sec

The dmesg seems to indicate PIO4:
pccard: CardBus card inserted into slot 0
PCI: 0000:02:00.0 reg 10 io port: [0, 1f]
PCI: 0000:02:00.0 reg 14 32bit mmio: [0, fff]
pata_ninja32 0000:02:00.0: enabling device (0000 -> 0003)
pata_ninja32 0000:02:00.0: PCI INT A -> Link[LNKD] -> GSI 11 (level, low) ->
IRQ 11
pata_ninja32 0000:02:00.0: setting latency timer to 64
scsi2 : pata_ninja32
ata3: PATA max PIO4 irq 11
ata3.00: ATA-0: TRANSCEND, 20070831, max UDMA/66
ata3.00: 31326208 sectors, multi 0: LBA 
ata3.00: configured for PIO4
ata3.00: configured for PIO4
ata3: EH complete
scsi 2:0:0:0: Direct-Access     ATA      TRANSCEND        2007 PQ: 0 ANSI: 5

I'm afraid pata_ninja32 doesn't do much better with suspend.

After resuming, top shows me kacpi_notify using about 50% cpu, kacpid using
~42%, scsi_eh_1 about 0.3% and the rest is in "wa" state. Reads from the disk
still don't return.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
