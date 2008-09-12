From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11540] hda lost irq on boot
Date: Fri, 12 Sep 2008 05:40:10 -0700 (PDT)
Message-ID: <20080912124010.D56FE108058@picon.linux-foundation.org>
References: <bug-11540-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60594 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093AbYILMkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Sep 2008 08:40:42 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8CCeBRe013110
	for <linux-ide@vger.kernel.org>; Fri, 12 Sep 2008 05:40:12 -0700
In-Reply-To: <bug-11540-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11540





------- Comment #3 from Andreas.Matthus@tu-dresden.de  2008-09-12 05:40 -------
on 2.6.27-rc6 is the error too: The system come not up. Every few minutes I got
the message
hda lost interrupt
- that is all.

By using bootparameter noapic the system run, but the scsi-card (substantila in
the kernel) was not founded.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
