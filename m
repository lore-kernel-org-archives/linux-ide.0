From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Tue, 14 Oct 2008 01:37:15 -0700 (PDT)
Message-ID: <20081014083715.AFB83108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57376 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479AbYJNIhS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 04:37:18 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9E8bFcV015146
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 01:37:16 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #5 from valerio.p@libero.it  2008-10-14 01:37 -------
Created an attachment (id=18299)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=18299&action=view)
my custom config quite different from the debian one

config-2.6.27 it's my custom config with some drivers compiled statically 
(i.e: SATA and ext3), many unnecessary modules removed to speed up 
compilation and other options to fit better my architecture (core duo 2 
64bit).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
