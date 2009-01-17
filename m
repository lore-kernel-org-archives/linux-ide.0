From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sat, 17 Jan 2009 03:26:52 -0800 (PST)
Message-ID: <20090117112652.98289108043@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51794 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751184AbZAQL0y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2009 06:26:54 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0HBQqHh032056
	for <linux-ide@vger.kernel.org>; Sat, 17 Jan 2009 03:26:53 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #33 from manoet.ita@gmail.com  2009-01-17 03:26 -------
Robert, you were right!
I have installed NVIDIA driver in 2.6.27.7 kernel patched with Borislav's patch
and when I have started gnome, soundjuicer started to play the cd!
I've noticed that is slower than Windows Media Player and there are some errors
during the reproduction, but it's a great success for me.
Thanks Borislav, Robert and Bartlomiej!


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
