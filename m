From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 07:58:49 GMT
Message-ID: <200905130758.n4D7wnL4014055@demeter.kernel.org>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35558 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbZEMH6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 03:58:48 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4D7wnwn014056
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 07:58:49 GMT
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286





--- Comment #2 from fibre_optic@go2.pl  2009-05-13 07:58:48 ---
"Does 2.6.27.21 use DMA?"

I will check it today evening.

"Is this system equipped with on-board IDE->CF adapter,
or is it an add-on one?"

It is an additional hardware. The hardwer is connected to mother board (IDE
ifc) and CF-CARD is inserted in a slot on the hardware.

"Does this adapter support DMA at the hardware level
(some adapters don't have DMA lines)?"

Take a look belllow, is it what you need?

# hdparm  -i /dev/hda

/dev/hda:

 Model=SanDisk SDCFJ-32, FwRev=HDX 2.15, SerialNo=003213L1804H3206
 Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
 RawCHS=490/4/32, TrkSize=0, SectSize=576, ECCbytes=4
 BuffType=(2) DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=off
 CurCHS=490/4/32, CurSects=62720, LBA=yes, LBAsects=62720
 IORDY=no, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0mdma1*mdma2
 AdvancedPM=no
 Drive conforms to: Unspecified:  ATA/ATAPI-10

 * current active mode

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
