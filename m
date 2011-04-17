From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 32262] 2.6.38-git15+  IDE hangs boot
Date: Sun, 17 Apr 2011 13:28:53 GMT
Message-ID: <201104171328.p3HDSrdA015696@demeter1.kernel.org>
References: <bug-32262-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:50614 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1DQN2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2011 09:28:54 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3HDSs70015709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 17 Apr 2011 13:28:54 GMT
In-Reply-To: <bug-32262-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=32262





--- Comment #1 from Rafael J. Wysocki <rjw@sisk.pl>  2011-04-17 13:28:51 ---
On Sunday, April 17, 2011, Pete Clements wrote:
>   > 
>   > The following bug entry is on the current list of known regressions
>   > from 2.6.38.  Please verify if it still should be listed and let the tracking team
>   > know (either way).
>   > 
>   > 
>   > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D32262
>   > Subject		: 2.6.38-git15+  IDE hangs boot
>   > Submitter	: Pete Clements <clem@clem.clem-digital.net>
>   > Date		: 2011-03-25 15:38 (24 days old)
>   > 
>   > 
> 
> I no longer experience the problem. Don't recall when the fix was integrated
> (post git19?). (Currently at 39-rc3-git6.)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.