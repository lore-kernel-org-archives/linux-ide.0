Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3D4C11D0C
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 20:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5825207FD
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBTUeu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgBTUeu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 20 Feb 2020 15:34:50 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 206405] kernel crash during boot debian server on qemu+kvm
Date:   Thu, 20 Feb 2020 20:34:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antdev66@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206405-11633-gHUzPMarTb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206405-11633@https.bugzilla.kernel.org/>
References: <bug-206405-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206405

--- Comment #5 from anthony (antdev66@gmail.com) ---
(In reply to b.zolnierkie from comment #4)
> On 2/19/20 10:25 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=206405
> > 
> > --- Comment #3 from anthony (antdev66@gmail.com) ---
> > same problem in version 5.5.5
> 
> Hi,
> 
> Please check v5.6-rc2 and if it doesn't help please try to do
> bisection between v5.4 and v5.5 kernel versions as described in:
> 
>       Documentation/admin-guide/bug-bisect.rst
> 
> Also could you please explain what prevents you from migration to
> libata drivers (CONFIG_ATA) from the IDE subsystem (CONFIG_IDE, it
> has been deprecated many years ago and is scheduled for removal)?
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

Hello,
I have tested version 5.6-rc2 but I get the same result.
As for IDE drivers, they were enabled due to previous configurations.
However, following your suggestion, I recompiled the 5.5.5 kernel with
CONFIG_IDE disabled and the problem no longer occurs.
This does not explain the reason for the crash, but I solved the problem.
Thanks,
Antonio

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
