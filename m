From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Fri, 10 Oct 2008 13:52:47 -0700 (PDT)
Message-ID: <20081010205247.6EACD108047@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46798 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758386AbYJJUxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 16:53:17 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9AKqlgl003705
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 13:52:48 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




------- Comment #1 from alan@lxorguk.ukuu.org.uk  2008-10-10 13:52 -------
Well delkin_cb doesn't really support suspend/resume so no suprise whatsoever.
pata_ninja32 does so it might be more useful to investigate why the delkin
driver is slower for you. < 1MB/sec sounds like the Delkin is selecting PIO0
not PIO4


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
