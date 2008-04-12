From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Sat, 12 Apr 2008 09:53:03 -0700 (PDT)
Message-ID: <20080412165303.1C9C6108038@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40619 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753123AbYDLQxF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 12:53:05 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3CGr3tE011259
	for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 09:53:05 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #7 from marco@absence.it  2008-04-12 09:53 -------
It didn't worked. I tried a couple of patch and many boot parameters but it
still work with udma2. Moreover, hda is now shown as sda: what's happening with
libata?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
