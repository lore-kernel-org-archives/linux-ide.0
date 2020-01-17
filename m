Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9297C33C9E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A878222C3
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgAQXOW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgAQXOV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 17 Jan 2020 18:14:21 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Fri, 17 Jan 2020 23:14:21 +0000
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
Message-ID: <bug-205107-11633-41xW8TZM6z@https.bugzilla.kernel.org/>
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

--- Comment #11 from Kaur Männamaa (kaurman@outlook.com) ---
(In reply to Hélder from comment #9)


> If I umount  but do not unplug the HDD, the problem does not occur.
> 

I contacted Mark Lord, the main dev behind hdparm, and he had some thoughts.
Among other things, he asked us to clarify whether just unmounting (instead of
unmounting and powering off, e.g. by using 'udisksctl power-off ...') the drive
before shutdown really solves the problem. I'm asking as 'unplugging' can be
misinterpreted and that could lead to misunderstandings. In short, does the
problem occur if you unmount the drive, and then just shut down your computer?
And don't forget to disable your script while testing :)

In my case shutting down with an unmounted drive did not solve the problem. If
it does indeed work in your case then we may have different scenarios here.
Mark had other ideas as well but I'd like to clear the unmounting part up first
to plan the next steps better.


Kaur

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
