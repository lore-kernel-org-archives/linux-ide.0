From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Fri, 11 Apr 2008 02:40:43 -0700 (PDT)
Message-ID: <20080411094043.82BE311D107@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52984 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756803AbYDKJlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 05:41:45 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3B9fB1P013794
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 02:41:12 -0700
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #6 from jan.fikar@psi.ch  2008-04-11 02:40 -------
The latest results are not very good...
Bisecting and waiting for at least 24 hours leads to a different wrong result:

f435a91e66e7776f0c73fca5af3cb87c61130ed6 is first bad commit
commit f435a91e66e7776f0c73fca5af3cb87c61130ed6
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Dec 6 17:15:57 2007 +0000

    [MIPS] BCM1480: Fix interrupt routing, take 2.

    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

:040000 040000 73dbf425d802ab4d4a1c6fd4776df2b9d0086043 
0fa229550fa638511ff9f9edde20f0329d650174 M      arch

Then I tried kernel 2.6.25-rc6 and unfortunately I still see the error,
although it seems to be triggered even less often. One time I saw a single DMA
timeout in 4 days without disabling DMA. Second time after three days and last
time I saw the real problem, so a lot of timeouts, resets and disabling DMA on
hda during two days.


Is there a possibility to try only atiixp related patches instead of the
bisecting? If I need to wait let's say 5 days, bisecting would take in the
worst case two months :(


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
