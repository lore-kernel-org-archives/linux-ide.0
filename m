From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Wed, 15 Oct 2008 03:29:39 -0700 (PDT)
Message-ID: <20081015102939.C6D4B108059@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37784 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbYJOKaN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 06:30:13 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FATd9M003399
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 03:29:41 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #5 from alan@lxorguk.ukuu.org.uk  2008-10-15 03:29 -------
Ok that is hopeful. It is getting stuck trying to transfer data and then fails
to recover. I've got a general test patch about to appear for cleaning up those
cases.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
