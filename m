Return-Path: <SRS0=bdUt=X7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1F9C4360C
	for <linux-ide@archiver.kernel.org>; Sun,  6 Oct 2019 23:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336DC20862
	for <linux-ide@archiver.kernel.org>; Sun,  6 Oct 2019 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJFXS2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfJFXS2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 6 Oct 2019 19:18:28 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] New: No HDD spindown/parking on shutdown
Date:   Sun, 06 Oct 2019 23:18:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: helder.armando@hotmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-205107-11633@https.bugzilla.kernel.org/>
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

            Bug ID: 205107
           Summary: No HDD spindown/parking on shutdown
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 5.0.0-25-generic
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: helder.armando@hotmail.com
        Regression: No

Created attachment 285371
  --> https://bugzilla.kernel.org/attachment.cgi?id=285371&action=edit
SDB SMART log

Greetings,

I've got an external Toshiba HDD in good conditions (USB 3.0 cable on USB 2.0
port) that I use to store backups and my work in.
Every time the system shuts down (either by terminal command or regular OS UI),
the system does not wait for the hdd to park/spin down (as seen by the systemd
logs), and instead, cuts the power off too early, making the disc make an acute
screeching sound as if by hard power cutoff.

I believe the same thing is happening to my internal hdd (second one on linux,
previous one was old and had the same problem), but I can't be sure as the
sound isn't too clear.

I have reported this bug to the distribution's bug tracker (Lubuntu) and
systemd, but I was requested to come here instead, as the problem must be down
to the kernel.

I have tested this on Linux Mint and the same has happened. As additional
information, both on Windows 10 and FreeBSD, this problem did not occur.

I'll attach smartctl logs for both HDDs. The logs say old_age and pre_fail, but
this is most likely not true, as I have bought them recently and smartctl
doesn't seem to be that smart at times.

I await your reply,
Hélder

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
