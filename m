From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Mon, 10 Nov 2008 15:15:04 -0800 (PST)
Message-ID: <20081110231504.6EB17108040@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34587 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865AbYKJXPG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 18:15:06 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAANF4Bf004508
	for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 15:15:05 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #6 from lars.winterfeld@tu-ilmenau.de  2008-11-10 15:15 -------
wanted to try it with 2.6.25.9, but include/linux/ide.h already contains a (1
<< 26) flag: IDE_HFLAG_ABUSE_SET_DMA_MODE. all others up to 1<<31 are also
used... because i do not want to break something else, i would try to store the
"use-workaround"-flag somewhere else. what would you advice?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
