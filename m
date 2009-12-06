From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Sun, 6 Dec 2009 23:18:15 GMT
Message-ID: <200912062318.nB6NIFUc025524@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56311 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934333AbZLFXSI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 18:18:08 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB6NIFEk025525
	for <linux-ide@vger.kernel.org>; Sun, 6 Dec 2009 23:18:15 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Alan Pope <alan@popey.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@popey.com




--- Comment #22 from Alan Pope <alan@popey.com>  2009-12-06 23:18:13 ---
I have commented on the Ubuntu bug, but thought I'd leave a comment here too.

I've got two Eee 900's and the bug exhibits itself on both. I have gone back
and forth from Jaunty (kernel 2.6.28) and Karmic (kernel 2.6.31). This kind of
error message appears only under 2.6.31 and 2.6.32. I don't get it on 2.6.28.

[ 113.816054] ata2: lost interrupt (Status 0x58)
[ 113.820008] ata2: drained 8192 bytes to clear DRQ.
[ 113.835302] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 113.835310] ata2.00: BMDMA stat 0x64
[ 113.835317] ata2.00: failed command: READ DMA
[ 113.835332] ata2.00: cmd c8/00:20:a7:8f:09/00:00:00:00:00/e0 tag 0 dma 16384
in
[ 113.835335] res 58/00:20:a7:8f:09/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
[ 113.835343] ata2.00: status: { DRDY DRQ }
[ 113.835393] ata2: soft resetting link

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
