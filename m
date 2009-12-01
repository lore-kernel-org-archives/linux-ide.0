From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14708] Option remap63 for OnTrack diskmanager not work - kernel
 panic, unable to mount root filesystem
Date: Tue, 1 Dec 2009 00:28:58 GMT
Message-ID: <200912010028.nB10Swwf021262@demeter.kernel.org>
References: <bug-14708-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43425 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbZLAA2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 19:28:52 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB10SwXs021263
	for <linux-ide@vger.kernel.org>; Tue, 1 Dec 2009 00:28:58 GMT
In-Reply-To: <bug-14708-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14708





--- Comment #1 from David S. Miller <davem@davemloft.net>  2009-12-01 00:28:58 ---
From: bugzilla-daemon@bugzilla.kernel.org
Date: Tue, 1 Dec 2009 00:22:58 GMT

> http://bugzilla.kernel.org/show_bug.cgi?id=14708
> 
>            Summary: Option remap63 for OnTrack diskmanager not work -
>                     kernel panic, unable to mount root filesystem

This was intentionally removed see:

commit d708c40da83a86551556999e924e27fdc43dad71
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Sat Mar 22 16:40:22 2008 +0100

    ide: mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted

    Mark "hdx=remap" and "hdx=remap63" kernel parameters as obsoleted
    (they are layering violation and should be dealt with in the same
     way as done by libata - device-mapper should be used instead).

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
