From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] Suspend to disk no longer works in 2.6.30.2 with an EIDE
 drive
Date: Sat, 1 Aug 2009 12:50:23 GMT
Message-ID: <200908011250.n71CoNgh007877@demeter.kernel.org>
References: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:44192 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZHAMuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 08:50:22 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71CoNcW007878
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 12:50:23 GMT
In-Reply-To: <bug-13886-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886





--- Comment #3 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-08-01 12:50:21 ---
On Saturday 01 August 2009 12:52:08 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13886
> 
> 
> 
> 
> 
> --- Comment #2 from Rafael J. Wysocki <rjw@sisk.pl>  2009-08-01 10:52:07 ---
> Caused by:
> 
> commit 295f00042aaf6b553b5f37348f89bab463d4a469
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Fri Jan 2 16:12:48 2009 +0100
> 
>     ide: don't execute the next queued command from the hard-IRQ context (v2)
> 
> First-Bad-Commit : 295f00042aaf6b553b5f37348f89bab463d4a469

Hi Rafal,

We have been through one similar case already, please see:

    http://bugzilla.kernel.org/show_bug.cgi?id=13371

s2d bisection will always point to this commit because it really broke s2d 
for the "whole" 12 days during early -rc phase.  The fix:

commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Wed Jan 14 19:19:04 2009 +0100

    ide: fix suspend regression

Last time I've spent like a week working with the reporter to find the real
bugger (in e100 networking driver, it stays unfixed after over 2 months).

I'm not going to do it again.  If the real bugger turns out to be my patch
or patch passed through me then please ping me again, till then I'm off cc:.

Also a small reminder -- I'm no longer maintainer of drivers/ide/ so please
pass everything through Dave first as he should be able to verify whether
the issue was fixed already, i.e.: there are still some outstanding bugfixes
from June needed for -stable:

    http://marc.info/?l=linux-ide&m=124910557313722&w=2

[ yes, those are fixes for a Sparc Ultra 10 specific problems reported on
  one sunny Saturday's evening and fully debugged/fixed after 2 days.. ]

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
