From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Wed, 30 Jul 2008 15:56:49 -0700 (PDT)
Message-ID: <20080730225649.09B2C108038@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752535AbYG3W5U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 18:57:20 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6UMunmT008899
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 15:56:50 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943


tj@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |greg@kroah.com




------- Comment #12 from tj@kernel.org  2008-07-30 15:56 -------
Cc'ing Greg.  Gustavo is reporting that the kernel falls into an infinite loop
during shutdown if ahci is compiled as module (built-in works fine) and calls
sd shutdown indefinitely.  Does anything ring a bell?  Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
