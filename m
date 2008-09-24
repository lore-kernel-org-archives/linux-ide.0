From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11635] strange message in dmesg for IDE HDD: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
Date: Wed, 24 Sep 2008 07:11:25 -0700 (PDT)
Message-ID: <20080924141125.7D937108058@picon.linux-foundation.org>
References: <bug-11635-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53432 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751280AbYIXOL5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 10:11:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8OEBPmT017562
	for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 07:11:26 -0700
In-Reply-To: <bug-11635-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11635





------- Comment #3 from enrique_pinos@yahoo.es  2008-09-24 07:11 -------
> 500 MB/s on disk reads?! That's totally wrong expectaion

For my personal computer (Pentium IV)

hdparm -Tt /dev/hda

/dev/hda:
 Timing cached reads:   1500 MB in  2.00 seconds = 749.31 MB/sec
 Timing buffered disk reads:  184 MB in  3.01 seconds =  61.14 MB/sec

Server I'm using its athlon 1800MHz and I got same performance as previous
server I got (k6-II @ 450MHz) I found server slow in transfers and high CPU
usage (and k6-II never warnning me for hardware limits :S) This is the reason
I'm in doubt.
Upgrading server didn't increase transfers between my PC and my server, in my
local network :(
Thanks for replies.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
