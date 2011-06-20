From: Marc MERLIN <marc@merlins.org>
Subject: Does Intel Sandy Bridge MB Sata support port multipliers?
Date: Sun, 19 Jun 2011 21:51:38 -0700
Message-ID: <20110620045138.GB21438@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:34741 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1FTEvl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 00:51:41 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.72 #1)
	id 1QYWSY-0003Gu-Aw
	for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2011 21:51:38 -0700
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I had a system with a sil 3132, and a PMP which worked fine.

I upgraded the system and was hoping to use onboard sata (it's a Sandy
Bridge lga1155).
When I plug my PMP into that, the other drives are not detected.

Where do I find the list of SATA drivers that support PMP.
Are newer intel MBs with onboard SATA supposed to work?

dmesg says:
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 20 (level, low) -> IRQ 20
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
(...)

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
