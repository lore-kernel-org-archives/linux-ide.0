From: "Paul" <paul@kbs.net.au>
Subject: working sata raid - which controller?
Date: Thu, 12 Aug 2004 15:56:01 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <026f01c48031$0c121140$cf01a8c0@internal.kbs.net.au>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408102148.57602.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.kbs.net.au ([203.220.32.149]:3200 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S268414AbUHLF4D
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Aug 2004 01:56:03 -0400
Received: from [202.136.32.26] (helo=PRIVOLI)
	by relay01.kbs.net.au with smtp (Exim 3.36 #2)
	id 1Bv8ZF-0003V3-00
	for linux-ide@vger.kernel.org; Thu, 12 Aug 2004 15:56:01 +1000
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi Guys,

We are purchasing a new test server and I need to know which controllers are
sata raid based and are hardware raid and not software raid. We currently
use promise fast trak tx4's and have found in linux there is no mirroring
support and it does not actively mirror data between the two disks.

00:09.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3319
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3319
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

There is a function in win32 land you can run to "synch" the drives but we
can't find an equivalent in linux and would prefer hardware. Cost is not a
problem.

Thanks

