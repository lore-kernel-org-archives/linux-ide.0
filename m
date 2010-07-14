From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16382] driver 'pata_hpt37x' attempts to run HPT device x0006
 subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
Date: Wed, 14 Jul 2010 02:36:56 GMT
Message-ID: <201007140236.o6E2auIB032441@demeter.kernel.org>
References: <bug-16382-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:38988 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab0GNCg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 22:36:57 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6E2auOR032444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 02:36:56 GMT
In-Reply-To: <bug-16382-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16382





--- Comment #3 from Rick Stockton <rickstockton@reno-computerhelp.com>  2010-07-14 02:36:53 ---
Here's 'lscpi -vvvv':

01:0a.0 RAID bus controller: HighPoint Technologies, Inc. HPT302/302N (rev 02)
        Subsystem: HighPoint Technologies, Inc. Device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at d880 [size=4]
        Region 2: I/O ports at d800 [size=8]
        Region 3: I/O ports at d480 [size=4]
        Region 4: I/O ports at d000 [size=256]
        Expansion ROM at f9fe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pata_hpt3x2n
        Kernel modules: hpt366, pata_hpt37x, pata_hpt3x2n

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
