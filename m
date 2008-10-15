From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Tue, 14 Oct 2008 18:51:46 -0700 (PDT)
Message-ID: <20081015015146.E9DFC10805A@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33605 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626AbYJOBwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 21:52:23 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9F1plwx012631
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 18:51:48 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #8 from tj@kernel.org  2008-10-14 18:51 -------
Can you give a shot at ata_piix and see whether it behaves any differently?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
