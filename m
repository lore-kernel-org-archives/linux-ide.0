From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11635] strange message in dmesg for IDE HDD: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
Date: Wed, 24 Sep 2008 07:44:42 -0700 (PDT)
Message-ID: <20080924144442.23FC8108056@picon.linux-foundation.org>
References: <bug-11635-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59697 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751280AbYIXOpM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 10:45:12 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8OEiglf020576
	for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 07:44:43 -0700
In-Reply-To: <bug-11635-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11635





------- Comment #4 from alan@lxorguk.ukuu.org.uk  2008-09-24 07:44 -------
> Timing buffered disk reads:  184 MB in  3.01 seconds =  61.14 MB/sec

is the disk speed


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
