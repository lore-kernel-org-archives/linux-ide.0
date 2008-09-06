From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11498] Teac DV28EV stops working with ide-cd
Date: Sat,  6 Sep 2008 06:06:26 -0700 (PDT)
Message-ID: <20080906130626.3C43110805A@picon.linux-foundation.org>
References: <bug-11498-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45345 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbYIFNG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Sep 2008 09:06:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m86D6QKm028468
	for <linux-ide@vger.kernel.org>; Sat, 6 Sep 2008 06:06:27 -0700
In-Reply-To: <bug-11498-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11498





------- Comment #3 from bbpetkov@yahoo.de  2008-09-06 06:06 -------
Ok, attached is an inquisitive patch. Ben, do you care to apply it ontop of
27-rc5 and then send me the output so that we know for which packet command the
irq times out and thus see what hald is saying to the drive? 

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
