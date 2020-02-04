Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15752C35247
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6A52086A
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 01:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBDBlB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgBDBlB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 3 Feb 2020 20:41:01 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Tue, 04 Feb 2020 01:41:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: kaurman@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-4628UQGPgW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205107-11633@https.bugzilla.kernel.org/>
References: <bug-205107-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205107

--- Comment #16 from Kaur Männamaa (kaurman@outlook.com) ---
Did some additional testing & asked Mark's opinion and here's what we found.

First, I must say that one's ears do not seem to be a trustworthy source of
information. I tested with another drive where accessing SMART data was not a
problem and found that on many occasions the count didn't actually increase
although I would have presumed so judging by what I heard.

Now, as for what is actually going on, it is Mark's view that the kernel is
probably not to blame here. Rather systemd or one of its services acting up,
for example, which is where you started from...

It is worth pointing out, however that Mark found the presence of the bug to be
dependent on whether the drive had been previously mounted. This is something
that differs from your observations, unless I'm mistaken.

True, it appears that you didn't test with a drive that had never been mounted
after connecting but rather with one that you had unmounted. Who knows, maybe
even that can make a difference but that's just speculation by me at the
moment. 

Do note, however, what I said about relying on your ears. IF you have based
some of your recent reporting on what you heard instead of checking the actual
count then this is something to consider.

If, on the other hand, you have checked the count and can still confirm that
the bug doesn't care if the drive has been previously mounted or not then you
are probably seeing something similar to what I'm seeing on my system, i.e
shutting down without ever mounting does not seem to make a difference (meaning
the problem is present *sometimes*). Yet, the kernel still seems to do what is
expected (at least according to the basic tests Mark helped to arrange). I.e
the drive does get flagged for start & stop management by the kernel, as it
should.


What I ran into was similar to what is described here:
https://www.toradex.com/community/questions/22373/udisk-unable-to-detach-device-after-unmount.html

In other words, I started the system, connected the drive and tried to unmount
(if mounted) & power-off manually but did not always succeed as for powering
off. If that happens, shutdown always results in the count increasing, which
makes sense, after all.

The scenario described in the report I linked to cannot be the problem in my
case, as the material is old and the packages, including the kernel, I use are
newer. It does indicate, however, that the problem as such has been noticed
before. I have some thoughts on what could be happening in my case but I
haven't had the time to test my hypothesis yet. I will let you know should I
find anything relevant.

K

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
