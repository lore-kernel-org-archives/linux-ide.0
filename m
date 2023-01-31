Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FDC636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 17:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAaRAP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjAaRAN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 12:00:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107024DBD1
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 09:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9909861566
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 17:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09435C4339B
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675184400;
        bh=WrF11YwuENcOp1F8I+ZiMEbJKkdqW8ln2NIea7Q6FF0=;
        h=From:To:Subject:Date:From;
        b=ciHnE2QOYzplB3VOzVOf+JEw0is41AYIaK086Q5yrX67b9AZIsMpb2wtqIKguresL
         zmIbAxgvkY79H3WUbPsrllAABUzSPBuOOPVvRGy/FgcET1EXkKlGo4YKXz55OeI1bC
         GHfFS9Bn/IgsTVmPCVKBKRnegRJjsbzMY7ggws1wy2Z9swSVWZ3jnZebtWB4zLg+nf
         StjF19u7voIg980whSMvVNtJPTGC7bixT6XsePkGPoFjez3VEn0DTTg/nKgTROmfhi
         jNH/af4ICQbZ0SF/9d35hXkYbo25PT9ieflynF+xhe4SX1W6HILri+yzts4284zQM7
         ZPlITA+z0kacQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E22A8C43143; Tue, 31 Jan 2023 16:59:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 216982] New: sound hit
Date:   Tue, 31 Jan 2023 16:59:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kirill-s-0801@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216982-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216982

            Bug ID: 216982
           Summary: sound hit
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 6.1.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: kirill-s-0801@yandex.ru
        Regression: No

The sound disappeared on the ASUS Vivobook. When I plugged in the headphone=
s,
the sound disappeared, after removing the headphones, the sound did not wor=
k.
Switched cores, there is no sound. When there should be the intended sound,
there is a crackling in the headphones. And everything works on the Windows.
(fedora 37)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
