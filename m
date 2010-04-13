From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Tue, 13 Apr 2010 18:23:05 GMT
Message-ID: <201004131823.o3DIN5t1018540@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:56003 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0DMSXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Apr 2010 14:23:05 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3DIN5wm018542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 13 Apr 2010 18:23:05 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #19 from Marc H. Thoben <kernelbug@develz.org>  2010-04-13 18:22:58 ---
Created an attachment (id=25992)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=25992)
dmesg, debug ide-cd_mod, untainted kernel, request sense failure 2

Same as last time. Didn't touch the cdrom this time - didn't even run anything
that could possibly try to check for an inserted medium.

Borislav, is this even slightly interesting? Or rather some bug with
hald-addon-storage?

Couldn't make the kernel panic with the module being in debug mode.. about to
give up soon.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
