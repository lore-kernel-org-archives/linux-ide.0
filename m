Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FAFC43600
	for <linux-ide@archiver.kernel.org>; Thu, 20 May 2021 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F368613BD
	for <linux-ide@archiver.kernel.org>; Thu, 20 May 2021 11:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbhETL1f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 May 2021 07:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241832AbhETLZe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 20 May 2021 07:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 16B7E61358
        for <linux-ide@vger.kernel.org>; Thu, 20 May 2021 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621509084;
        bh=i0Jr8sCFbGP63vS2hf7EBqfRb/c4+XwxDzdpmfPGQZc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ic8e/ZVqqtUnDv4XQVpR8xvEg55ih2WuwJYIeA4l7PN96pVYUw6GxE1dTfZ2n6k0o
         hOGLmkJ4gmB1zBMyZJGsf+lXZ5X1FzA1Omch91ThrA4UGuapoSJ5xT7bOirCXT9T4v
         0rkA5wFMjphmYgwrn7h0+N71xs+qF/hsWsIo1olZWppH9auyYfBCTxA7UengUwupcy
         BBTOP+VcY5yGsVIgzHBsRfbnRgzVoDJVQMA3d5F/wYxTB+y8ZbbaUYbKs9ZF5UcUPs
         IPnRiaLE0y1vqM7T/sByOO7hxDtfE3U6H14YRrhbAL5jUpkC9VxslLzbV5XRNIK1W4
         03xHGbYlRwXHQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 213157] BUG: unable to handle page fault for address: fffbb000,
 Workqueue: ata_sff ata_sff_pio_task
Date:   Thu, 20 May 2021 11:11:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213157-11633-Ckmmih9EsV@https.bugzilla.kernel.org/>
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

--- Comment #1 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 296895
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296895&action=3Dedit
kernel .config (kernel 5.13-rc2, Shuttle XPC FS51, Pentium 4)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
