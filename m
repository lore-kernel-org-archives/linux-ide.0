From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Thu, 16 Oct 2008 06:14:27 -0700 (PDT)
Message-ID: <20081016131427.165F4108040@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57759 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013AbYJPNO3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 09:14:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GDEReN003606
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 06:14:28 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #9 from alan@lxorguk.ukuu.org.uk  2008-10-16 06:14 -------
Nice.. and I think that explains why the standard PM recovery in libata isn't
enough so I'll just go fix up pata_ninja32 to match


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
