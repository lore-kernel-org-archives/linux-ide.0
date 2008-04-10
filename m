From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 13:35:10 -0700 (PDT)
Message-ID: <20080410203510.44FC6108061@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38725 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910AbYDJUfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 16:35:12 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3AKZArL005885
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 13:35:11 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #5 from marco@absence.it  2008-04-10 13:35 -------
Created an attachment (id=15726)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=15726&action=view)
lspci output

Sorry, I forgot about the lspci output.
How the override can be done? It's a specific module parameter?
I removed the second HD a couple of days ago and I'm using just the CF.

BTW, thank you for your help!


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
