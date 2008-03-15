From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Sat, 15 Mar 2008 03:11:46 -0700 (PDT)
Message-ID: <20080315101146.95DF5108064@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbYCOKLt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 06:11:49 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2FACjb2027425
	for <linux-ide@vger.kernel.org>; Sat, 15 Mar 2008 03:12:48 -0700
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #12 from qrees@poczta.fm  2008-03-15 03:11 -------
Ok, I've tested kernel 2.6.25-rc5 and it does crash (just like any other
kernel).

After the crash Num Lock and Caps Lock blink, but I don't know what does it
mean...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
