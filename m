From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Fri, 23 May 2008 09:51:12 -0700 (PDT)
Message-ID: <20080523165112.89CA811D109@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36836 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696AbYEWQvm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 May 2008 12:51:42 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NGpC5V016757
	for <linux-ide@vger.kernel.org>; Fri, 23 May 2008 09:51:13 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #9 from juergen.kosel@gmx.de  2008-05-23 09:51 -------
Hello,

git bisect delivered the following:

912fb29a36a7269ac1c4a4df45bc0ac1d2637972 is first bad commit
commit 912fb29a36a7269ac1c4a4df45bc0ac1d2637972
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Oct 19 00:30:11 2007 +0200

    opti621: always tune PIO

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

:040000 040000 ac8b9614dad447f22ebc105dcec5e94d52434c41
95facc970da3f5821b06b859340232abc2518813 M      drivers


Which are changes of just 2 lines of code to allways enable autotune.
Either my hardware doesn't like it by construction or by agged electronic
components.


Greetings
   Juergen


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
