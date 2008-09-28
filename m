From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11659] CDROM on Laptop  Fudjitsu-siemens Amilo Xa-2528 isn't reconized
Date: Sat, 27 Sep 2008 23:13:26 -0700 (PDT)
Message-ID: <20080928061326.36C3B10805B@picon.linux-foundation.org>
References: <bug-11659-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57549 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbYI1GN4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 02:13:56 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8S6DQnl024589
	for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 23:13:27 -0700
In-Reply-To: <bug-11659-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11659


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bbpetkov@yahoo.de
             Status|NEW                         |ASSIGNED




------- Comment #3 from bbpetkov@yahoo.de  2008-09-27 23:13 -------
Hi,

can you please try three things, as Bart suggested:

0. pata_amd
1. 2.6.27-rc7
2. disabling libata

@Sergei: right, i didn't see the "irq timeout" message on a first glance.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
