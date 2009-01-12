From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon, 12 Jan 2009 11:19:02 -0800 (PST)
Message-ID: <20090112191902.92E4010800D@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39894 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135AbZALTTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 14:19:04 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0CJJ2wa027357
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 11:19:03 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #18 from linux@youmustbejoking.demon.co.uk  2009-01-12 11:19 -------
Plain 2.6.27.10 gives the warn_on_slowpath backtrace (as documented for
2.6.28).

With patches from comment nos. 5 & 13:

ide_build_sglist: Uninitialized none, cmd: 0x28
none: dev hdd: type=1, flags=10484
  sector 64, nr/cnr 8/8
  bio ffff88002d797240, biotail ffff88002d797240, buffer ffff88002c179000, data
0000000000000000, len 4096
ide_build_sglist: Uninitialized none, cmd: 0xbe
none: dev hdd: type=b, flags=104c8
  sector 18446744073709551615, nr/cnr 0/0
  bio 0000000000000000, biotail 0000000000000000, buffer 0000000000000000, data
ffff88002d62e000, len 2336


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
