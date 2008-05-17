From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 06:33:07 -0700 (PDT)
Message-ID: <20080517133307.2A07C10805F@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34280 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753735AbYEQNdi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 09:33:38 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HDX7Fq002562
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 06:33:08 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #3 from sshtylyov@ru.mvista.com  2008-05-17 06:33 -------
(In reply to comment #1)
> does "ide=nodma" make a difference ?

This option has been obsoleted, use hda=nodma instead.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
