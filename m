From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Fri, 10 Oct 2008 17:30:05 -0700 (PDT)
Message-ID: <20081011003006.01955108047@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35948 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753797AbYJKAaI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 20:30:08 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9B0U6Ak015763
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 17:30:07 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #3 from alan@lxorguk.ukuu.org.uk  2008-10-10 17:30 -------
What is logged in "dmesg" when this is occuring ?

The kacpi usage also seems bizarrely high but I assume you don't see that with
then card removed when resuming ?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
