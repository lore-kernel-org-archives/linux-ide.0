From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Fri, 18 Dec 2009 08:22:45 GMT
Message-ID: <200912180822.nBI8Mj8M000979@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47880 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZLRIWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 03:22:46 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id nBI8MjHb000980
	for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 08:22:45 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #40 from Lennart Poettering <mzxreary@0pointer.de>  2009-12-18 08:22:37 ---
(In reply to comment #35)

> Why, oh, why...  smartmontools were working just fine and could have
> been _easily_ been ported to C from C++ or enhanced into libsmartmon..

libatasmart is basically a port from C++ to C. But adds a couple fo things and
drops others. It's also kinda tiny, instead of the huge beast that
smartmonutils is.

> "Please note that I certainly don't plan to replace smartmontools.
>  libatasmart will always implement only a subset of S.M.A.R.T. If you
>  want the full set of functionality then please refer to smartmontools."
> 
> I somehow find it suspicious given how (only some) USB/ATA bridges
> support were added later to *libata*smart project...

Uh?

> First my audio, now my disks.. :(

Yes, I am out to eat your children the next time.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
