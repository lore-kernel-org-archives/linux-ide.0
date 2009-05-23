From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Sat, 23 May 2009 11:48:02 GMT
Message-ID: <200905231148.n4NBm2to021258@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59170 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbZEWLsB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 May 2009 07:48:01 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4NBm2pQ021259
	for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 11:48:02 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #12 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-23 11:48:01 ---
On Thursday 21 May 2009 23:04:19 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> 
> 
> 
> --- Comment #11 from Modestas Vainius <modestas@vainius.eu>  2009-05-21 21:04:19 ---
> In both cases? Or I'm just lucky that I have not seen problems with CD/DVD
> drive as hdc yet?

In both cases -- the drive is always tuned to UDMA/66.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
