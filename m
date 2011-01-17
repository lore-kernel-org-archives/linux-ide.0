From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15941] Thinkpad T61 after suspend to ram ide cdrom doesn't work
Date: Mon, 17 Jan 2011 22:20:06 GMT
Message-ID: <201101172220.p0HMK6vD014973@demeter1.kernel.org>
References: <bug-15941-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:47824 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1AQWUH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2011 17:20:07 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p0HMK6mo014975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2011 22:20:06 GMT
In-Reply-To: <bug-15941-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15941





--- Comment #12 from Ivan Volosyuk <ivan.volosyuk@gmail.com>  2011-01-17 22:19:59 ---
Do I understand you correctly, the ide_cd_mod is legacy ide driver?
On Jan 18, 2011 9:13 AM, <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=15941
>
>
>
>
>
> --- Comment #11 from Rafael J. Wysocki <rjw@sisk.pl> 2011-01-17 22:13:43
---
> IDE drivers are in a "cold maintenance" mode, so to speak, and I don't
think
> this issue is going to be fixed.
>
> Any chance to try PATA/libata instead?
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You reported the bug.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
