From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 10:08:15 -0700 (PDT)
Message-ID: <20080517170815.456C0108035@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47194 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbYEQRIR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 13:08:17 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HH8FlR015115
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 10:08:16 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #7 from devzero@web.de  2008-05-17 10:08 -------

>> does "ide=nodma" make a difference ?

> This option has been obsoleted, use hda=nodma instead.

so if this is obsoleted, why does Documentation/kernel-parameters.txt still
mention that ?


        ide=            [HW] (E)IDE subsystem
                        Format: ide=nodma or ide=doubler
                        See Documentation/ide/ide.txt.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
