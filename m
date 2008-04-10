From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 13:21:12 -0700 (PDT)
Message-ID: <20080410202112.EDCB810805F@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48052 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755882AbYDJUVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 16:21:46 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3AKLDMI004988
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 13:21:14 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #4 from alan@lxorguk.ukuu.org.uk  2008-04-10 13:21 -------
Joyous. Is there anything useful in lspci -vvxxx ?

UDMA4 probably used to work because the old code was less careful about modes.
You can override it by hand with the libata driver and also the old driver so a
hand override exists. Not sure there is much you can do about the CRC errors
though.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
