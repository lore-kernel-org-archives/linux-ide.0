From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Wed, 15 Oct 2008 14:11:25 -0700 (PDT)
Message-ID: <20081015211125.989EE108040@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35789 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752300AbYJOVL4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 17:11:56 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FLBPiI011408
	for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 14:11:26 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #6 from bzolnier@gmail.com  2008-10-15 14:11 -------
Created an attachment (id=18330)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=18330&action=view)
add PM support to delkin_cb

Please try this patch against current Linus' tree (should also apply 2.6.28-rc1
once it is released).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
