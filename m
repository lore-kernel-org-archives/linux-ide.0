From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 08:00:54 -0700 (PDT)
Message-ID: <20080517150054.3998810805F@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57711 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165AbYEQPBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 11:01:24 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HF0sKd007466
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 08:00:55 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #5 from vladc6@yahoo.com  2008-05-17 08:00 -------
You might give libata a try by compiling a kernel with CONFIG_IDE=n.
Alternatively, try booting a distro like Fedora that defaults to libata to see
if it can access the hard drive.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
