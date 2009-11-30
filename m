From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14294] kernel BUG at drivers/ide/ide-disk.c:187
Date: Mon, 30 Nov 2009 20:20:03 GMT
Message-ID: <200911302020.nAUKK3le017122@demeter.kernel.org>
References: <bug-14294-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58464 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbZK3UT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 15:19:56 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAUKK32i017123
	for <linux-ide@vger.kernel.org>; Mon, 30 Nov 2009 20:20:03 GMT
In-Reply-To: <bug-14294-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14294





--- Comment #2 from Rafael J. Wysocki <rjw@sisk.pl>  2009-11-30 20:20:02 ---
On Sunday 29 November 2009, Santiago Garcia Mantinan wrote:
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14294
> 
> Hi!
> 
> Sorry for not answering before, I've been running 2.6.31 patched for all
> this time and the results are a bit dissapointing...
> 
> The first run was for almost a month and ended up with half a hang, I could
> read on the console that there had been an error on one of the disks, dma
> error, the keyboard was working, getty seemed to work but then login didn't
> show up when entering the username even though the disks led was flashing
> when I operated the console entering usernames and all that. This hang was
> not like the hangs I had before, don't know if it was due to the patch and
> the unknown operation arriving to the IDE disk, but the message that the
> patch was supposed to display was not displayed at all.
> 
> The second run is current run I believe, currently it has an uptime of 18
> days and not problem was showed over this time.
> 
> So... I'm afraid I'm not able to reproduce this and maybe the whole problem
> is hardware related, even though the machine had been running with 2.6.30 in
> a stable way, it is an old machine, so maybe it is not as healthy as I
> believed, and even though memtest doesn't show any errors there could be
> some dma problems or other weird things happening around :-(
> 
> So... I'd say you can close the bug and if I happen to find it again... I'll
> report it again.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.