From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Sat, 22 Mar 2008 21:11:10 -0700 (PDT)
Message-ID: <20080323041110.D9E1C11D108@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38186 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbYCWELO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 00:11:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2N4BAJg007177
	for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 21:11:13 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #9 from gordonfarquharson@gmail.com  2008-03-22 21:11 -------
I added "#define DEBUG" to ide-taskfile.c, but there is no additional output.
The debug messages do exist in ide_core.ko:

$ strings drivers/ide/ide-core.ko | grep feat
%s: tf: feat 0x%02x nsect 0x%02x lbal 0x%02x lbam 0x%02x lbah 0x%02x dev 0x%02x
cmd 0x%02x
$ strings drivers/ide/ide-core.ko | grep hob
%s: hob: nsect 0x%02x lbal 0x%02x lbam 0x%02x lbah 0x%02x

It appears as if ide_tf_load() is never called.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
