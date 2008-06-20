From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri, 20 Jun 2008 16:30:11 -0700 (PDT)
Message-ID: <20080620233011.4288F108045@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60741 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755494AbYFTXak (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 19:30:40 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5KNUBvT006983
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 16:30:12 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #1 from htejun@gmail.com  2008-06-20 16:30 -------
Please provide more information.  What kind of machine is this?  What do you
mean by "compiled as module" - if ahci is built into the kernel, it's okay? 
Also, please attach kernel boot log.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
