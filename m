From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 15:08:54 -0700 (PDT)
Message-ID: <20080410220854.72B3E108038@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58220 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755943AbYDJWI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 18:08:56 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3AM8sEq012477
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 15:08:56 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #6 from marco@absence.it  2008-04-10 15:08 -------
Ok, I have found this:
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg14722.html
Different CF adapter but same CF and same problem. Tomorrow I'll try to reboot
the computer passing the "libata.force=80c,udma4" parameter. I think it should
work fine then.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
