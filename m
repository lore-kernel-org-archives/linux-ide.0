From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Tue,  8 Jul 2008 03:01:19 -0700 (PDT)
Message-ID: <20080708100120.1A16C10800A@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59755 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900AbYGHKBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 06:01:22 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m68A1K9S028950
	for <linux-ide@vger.kernel.org>; Tue, 8 Jul 2008 03:01:21 -0700
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #3 from lars.winterfeld@tu-ilmenau.de  2008-07-08 03:01 -------
For 2.6.24 I found some config, which caused the error not to appear (see
bottom of http://gentoo-wiki.com/HARDWARE_Fujitsu-Siemens_Amilo_Xa2528 ). I
could even read from the drive. Now I'm using 2.6.25-gentoo-r6 and the error
appears again (dmesg attached above) and the device is no longer present in
/dev but the notebook boots (with a delay of 6 minutes or so).
I'm still looking at the diff of the kernel-configs. Couldn't yet find
anything, which could have caused the problem. (So it could be the fault of
"lot of fixes" ;-) If someone could tell me some options which could be related
to the problem, I would try the combinations of them and post the log-files.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
