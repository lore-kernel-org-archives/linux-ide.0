From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Tue, 15 Dec 2009 00:34:22 GMT
Message-ID: <200912150034.nBF0YMpr019380@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36385 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZLOAeW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 19:34:22 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBF0YMqY019381
	for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 00:34:22 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #35 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-12-15 00:34:20 ---
On Monday 14 December 2009 09:10:00 pm bugzilla-daemon@bugzilla.kernel.org
wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14583
> 
> 
> David Zeuthen <zeuthen@gmail.com> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |zeuthen@gmail.com
> 
> 
> 
> 
> --- Comment #34 from David Zeuthen <zeuthen@gmail.com>  2009-12-14 20:09:58 ---
> (In reply to comment #33)
> > I've been tracking a bug we've linked to this on Ubuntu, the most recent
> > replies received from affected users do indicate that it's the
> > devkit-disks-probe-ata-smart command that triggers the HSM Violations and death
> > of their SSD.
> 
> This program is a user of libatasmart. You want to look at
> 
>  http://git.0pointer.de/?p=libatasmart.git;a=summary

Slightly off-topic but WTF is this?  NIH smartmontools implementation?

Oh, I see.. 

    http://0pointer.de/blog/projects/being-smart.html

Why, oh, why...  smartmontools were working just fine and could have
been _easily_ been ported to C from C++ or enhanced into libsmartmon..

"Please note that I certainly don't plan to replace smartmontools.
 libatasmart will always implement only a subset of S.M.A.R.T. If you
 want the full set of functionality then please refer to smartmontools."

I somehow find it suspicious given how (only some) USB/ATA bridges
support were added later to *libata*smart project...

To make things worse Ubuntu is actually shipping it.  What a mess...

First my audio, now my disks.. :(
--
Bartlomiej Zolnierkiewicz

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
