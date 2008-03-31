From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10370] mount failed on ubuntu-8.04_ppc
Date: Mon, 31 Mar 2008 06:58:43 -0700 (PDT)
Message-ID: <20080331135843.50DE110803A@picon.linux-foundation.org>
References: <bug-10370-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34147 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750719AbYCaN7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2008 09:59:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2VDwh9n002243
	for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2008 06:58:44 -0700
In-Reply-To: <bug-10370-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10370


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




------- Comment #6 from bbpetkov@yahoo.de  2008-03-31 06:58 -------
You're not supposed to mount an audio cdrom since it has no filesystem on it as
your log suggests. If you want to access it, do so without mounting it. See
http://www.tldp.org/HOWTO/CDROM-HOWTO/index.html for details.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
