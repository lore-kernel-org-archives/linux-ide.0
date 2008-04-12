From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Sat, 12 Apr 2008 10:05:44 -0700 (PDT)
Message-ID: <20080412170544.54C8B10805F@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754177AbYDLRGP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 13:06:15 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3CH5iSV012762
	for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 10:05:45 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #8 from alan@lxorguk.ukuu.org.uk  2008-04-12 10:05 -------
If your disk controller is setup to use libata it appears as /dev/sd* if it
uses the legacy IDE drivers /dev/hd*


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
