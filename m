From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 06:01:27 -0700 (PDT)
Message-ID: <20080410130127.DF8D5108061@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52292 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbYDJNB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 09:01:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3AD1RWk006223
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 06:01:29 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #1 from marco@absence.it  2008-04-10 06:01 -------
Created an attachment (id=15717)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=15717&action=view)
dmes and test logs

Here are some datas, reporting the first problem, executed under debian with
2.6.22 and 2.6.24 plus ubuntu 7.10 livecd using a 2.6.22 kernel.
Let me know if further testing is needed.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
