Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E10C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Feb 2022 22:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiBHWxR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiBHWxO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2022 17:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD155C07D8C0
        for <linux-ide@vger.kernel.org>; Tue,  8 Feb 2022 14:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 601A0B81C15
        for <linux-ide@vger.kernel.org>; Tue,  8 Feb 2022 22:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E61A1C340ED
        for <linux-ide@vger.kernel.org>; Tue,  8 Feb 2022 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644360653;
        bh=C18+AeHR60lcJEuuLdk/N5IIc9/+BfJnlUjLmrdzO6E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mPo97SGc4ge6b9U2SdeB0VtHg7a+sazrPOMBcxaRcYX+GxKt5YXfNccGfqMRLIGXb
         oqCR98szz6FzwwhAdisZEUrSobTo/XphW+Oxeea6HRfB35YkqL+ek8oUlJD3py7eGJ
         z2ZlIkhuGiyWklKhILHQXSxOUaHFDReSCSUJF6vOR5b3IXZvxiAKh8ztcemr5ONdfM
         /3IiabEvdFAdrG1ZgMIATiyDYtI/OSXbDil8el6g8oJ+alynU2yJ/6XGhhqxN6a7b7
         DAcsFQtdLmWrEL1YclN0mJ2JadT9ke3DneWtIxrikNdsBMQu5eCRWzI27wRk3IkeNK
         Gsj8SnJbq55GQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C8471C05FD0; Tue,  8 Feb 2022 22:50:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 213157] BUG: unable to handle page fault for address: fffbb000,
 Workqueue: ata_sff ata_sff_pio_task
Date:   Tue, 08 Feb 2022 22:50:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-213157-11633-qkNqPSQJ9V@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213157-11633@https.bugzilla.kernel.org/>
References: <bug-213157-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213157

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #4 from Erhard F. (erhard_f@mailbox.org) ---
Can't reproduce this on 5.16.x and 5.17-rc3. Which is supposedly a good thi=
ng..

Closing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
