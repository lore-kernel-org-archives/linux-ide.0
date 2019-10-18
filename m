Return-Path: <SRS0=jEsg=YL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C9CA9EA9
	for <linux-ide@archiver.kernel.org>; Fri, 18 Oct 2019 20:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641A2064B
	for <linux-ide@archiver.kernel.org>; Fri, 18 Oct 2019 20:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395283AbfJRUvB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfJRUvB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 18 Oct 2019 16:51:01 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Fri, 18 Oct 2019 20:51:00 +0000
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
Message-ID: <bug-205107-11633-lkcuO4XXxv@https.bugzilla.kernel.org/>
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

--- Comment #6 from Kaur Männamaa (kaurman@outlook.com) ---
Apologies for the delay. I have not had time for the research my current (and
rather limited) knowledge of the matter requires :) So far I have found quite a
few descriptions involving external drives but the problem certainly isn't as
massive as what we've had before
(https://bugzilla.kernel.org/show_bug.cgi?id=7674).

We know now that in your case the drives remain off during shutdown if turned
off manually beforehand. It's not much but it's a piece of the puzzle
nevertheless.

You are using usb2, I found some reports of usb3 causing this. True, I have no
idea (at least off the top of my head) about the kernel version that was used
in these cases. In other words, such a problem can have all kinds of causes.

But while we're at it, are you sure you are not overthinking the problem? I
mean, from what I understood from your previous post, your other drive (sda)
was not affected by the issue? What about the others? In order to do any bug
hunting & get some knowledgeable people involved we must know exactly which
drives are affected. Nailing down the basics is crucial in deciding how much
attention (if any) the bug will get.

Some further questions:

You said you tested with Mint. I assume the kernel version was the same?
Could you perhaps play around some more? Try with a live version of something
(different kernel), maybe even try different systems.


As for your temporary fix, I would say it's a start and during my brief
research on the issue I've seen quite a few versions of it used. Perhaps
convert it into a systemd service to make the process smoother. It turns out
udisksctl supports unmounting too, so you could even make it look nicer if you
wanted to:)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
