From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Fri, 12 Jun 2009 00:49:18 GMT
Message-ID: <200906120049.n5C0nItR010478@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51111 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbZFLAtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 20:49:16 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5C0nIZw010479
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 00:49:18 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #18 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-12 00:49:17 ---
Correction: newer drive does not work fine. With 2 days uptime processes
accessing the drive freeze in an uninteruptable wait for IO. It's a buggy drive
to be sure, but in 2.6.24/26 the worst it did was spam dmesg, & back in 2.6.15
it would stop working but not cause processes to freeze in an unkillable state.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
