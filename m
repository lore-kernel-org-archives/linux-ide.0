From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15445] pata_jmicron incorrectly downgrades CompactFlash to
 UDMA/33
Date: Fri, 5 Mar 2010 17:53:53 GMT
Message-ID: <201003051753.o25HrrQ2026037@demeter.kernel.org>
References: <bug-15445-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59768 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286Ab0CERxy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 12:53:54 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o25HrrW0026038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 5 Mar 2010 17:53:53 GMT
In-Reply-To: <bug-15445-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=15445





--- Comment #2 from Solomon Peachy <pizza@shaftnet.org>  2010-03-05 17:53:49 ---
the problem with libata.force= is that the id of the port/device change each
time the card is inserted/removed.. I suppose I can set it globally and
override the settings for the hard disk and DVD drive...

I'll see if I can get this to work; it's not ideal, but better than nothing.

(meanwhile, I also have a problem in that a suspend/resume cycle b0rks the
pciehp subsystem, but that's another matter...)

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
