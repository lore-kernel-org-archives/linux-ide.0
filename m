From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Wed, 8 Apr 2009 05:45:44 GMT
Message-ID: <200904080545.n385jie2010597@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52796 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759944AbZDHFpp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 01:45:45 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n385jiPX010598
	for <linux-ide@vger.kernel.org>; Wed, 8 Apr 2009 05:45:44 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #17 from Borislav Petkov <bbpetkov@yahoo.de>  2009-04-08 05:45:43 ---
Hi,

yeah, the driver is quite broken but no worries, we'll fix it :).

So, on to the next thing: If my analysis isn't completely wrong, we get a
divide-by-zero error because tape->buffer_size is somehow 0. I'd like to see
what capabilities your drive reports so please apply the following combo patch
ontop of the "tmp fix 2"-patch and please send me the _whole_ dmesg this time.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
