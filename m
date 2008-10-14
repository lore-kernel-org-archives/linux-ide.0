From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Tue, 14 Oct 2008 01:38:37 -0700 (PDT)
Message-ID: <20081014083837.1E843108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57430 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbYJNIij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 04:38:39 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9E8cb6K015210
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 01:38:38 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #6 from valerio.p@libero.it  2008-10-14 01:38 -------
Created an attachment (id=18300)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=18300&action=view)
A config more similar than the previous to Debian stock kernel's config

config-2.6.27b it's more similar to the Debian configuration of stock kernel 
(2.6.26), I just made some changes to fit architecture and removed drivers 
obviously (IMO :) ) not related to my problem (bug 11742) like ALSA modules, 
V4L modules and so on. I have just tried to check if it worked better but it 
didn't.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
