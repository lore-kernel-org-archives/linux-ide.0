From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri, 27 Jun 2008 08:45:09 -0700 (PDT)
Message-ID: <20080627154509.E9B12108038@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35320 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604AbYF0Ppk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 11:45:40 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5RFjA0d003103
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2008 08:45:11 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #9 from tj@kernel.org  2008-06-27 08:45 -------
Can you please hook up a serial or netconsole
(Documentation/network/netconsole.txt) and do ctrl-alt-sysrq-t and post the
result?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
