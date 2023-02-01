Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576EC636CD
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 14:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBAOYt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAOYr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 09:24:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB22CFE0
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 06:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C108617B5
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 14:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 004D9C433EF
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675261486;
        bh=dJpOlFatBZdgtat8svzKAORJ8UJ1l6AeOGjV9bwDNMA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jM7PMVC86FxtH80/H7amJis20FHcmz/kfk5P5DfUwOitCYSGPRsNESHWrVSK5Mss5
         yKmfExKo1skLAmqrPXdHfrcOBhAXkJ6Qez48mJiGn7wsXkdTVWywxAXeT/725VrAKM
         XuEUfR4IzUUcIrU5VhSvMJSW9qPBANlFYhfjy98ZgLdheuY7npjSo451XZ7yb4UIvL
         llCG8idk4fnZbEfcQlm8C4BIejNuyU+mZ0RckuSZGDO9b5PuDud2DPsUe+4LHjo9f5
         gbLuPx//X1RTL85tMHnlH67UMKPis+p7STKMLItL11PUBFaeUyMyuTAyOKjanLz/X9
         7ulq58JqKQeJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C614FC43142; Wed,  1 Feb 2023 14:24:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 216982] sound hit
Date:   Wed, 01 Feb 2023 14:24:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216982-11633-bSukABjQ6D@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216982-11633@https.bugzilla.kernel.org/>
References: <bug-216982-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216982

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to kirill from comment #0)
> The sound disappeared on the ASUS Vivobook.

That sounds like it worked on earlier kernels. Which ones? 6.0.y, or earlier
6.1.y releases? Would also be good to know if mainline works fine.

[BTW, damien: I tried to change the "Assignee:", but apparently I lack
permissions to do so.]

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
