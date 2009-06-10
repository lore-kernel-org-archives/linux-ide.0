From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Wed, 10 Jun 2009 11:15:29 GMT
Message-ID: <200906101115.n5ABFTYJ017933@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:51321 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbZFJLP1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 07:15:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5ABFTk2017937
	for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 11:15:29 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #16 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-06-10 11:15:27 ---
On Tuesday 09 June 2009 23:04:07 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> Ethan Grammatikidis <eekee57@fastmail.fm> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |eekee57@fastmail.fm
> 
> 
> 
> 
> --- Comment #14 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-09 21:04:05 ---
> Hullo. I ran into this the other day, & can report the bug is still present in
> 2.6.30-rc8.

Could it be bug #13399 instead of this one?

[ This one should really be already fixed. ]

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
