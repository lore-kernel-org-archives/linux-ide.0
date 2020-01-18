Return-Path: <SRS0=kgRP=3H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FEEC32771
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jan 2020 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507DF246AE
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jan 2020 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARXpo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Jan 2020 18:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgARXpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 18 Jan 2020 18:45:44 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Sat, 18 Jan 2020 23:45:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-X6OguNdiMp@https.bugzilla.kernel.org/>
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

--- Comment #13 from Hélder (helder.armando@hotmail.com) ---
< That reply was sent too early >

The networking problem makes it all much harder, since I can no longer
comfortably research the problem online.

I tried to run the script and proceed with the shutdown without unplugging the
cable and also unmounting regularly (with the file manager) and then shutting
down without unplugging. In both cases, the problem persists. 

For the record:
>>> uname -a
>> Linux hn-pc 5.0.0-36-generic #39-Ubuntu SMP Tue Nov 12 09:46:06 UTC 2019
>> x86_64 x86_64 x86_64 GNU/Linux

The Linux version I initially used was the latest (?) Lubuntu LTS version (I
can't really look it up now). As mentioned previously, I updated it manually
later. I believe we are experiencing the exact same problem with different
Linux versions.

- Hélder

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
