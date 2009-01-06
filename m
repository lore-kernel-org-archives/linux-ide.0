From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon,  5 Jan 2009 20:58:38 -0800 (PST)
Message-ID: <20090106045838.11F2D108043@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41301 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845AbZAFE6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 23:58:40 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n064wcvx005714
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 20:58:39 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #16 from bbpetkov@yahoo.de  2009-01-05 20:58 -------
Hi,

thanks for testing. Hmm, I can reproduce it here with kaffeine. Can you retry
playing the audio cd with kscd with "Use direct digital playback" enabled,
under Settings? 

P.S. I'll be away until Sa. and will able to look into it more seriously then.

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
