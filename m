Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B0C07E9A
	for <linux-ide@archiver.kernel.org>; Wed, 14 Jul 2021 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DB0611AB
	for <linux-ide@archiver.kernel.org>; Wed, 14 Jul 2021 10:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhGNKEm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239044AbhGNKEg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 14 Jul 2021 06:04:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 19BE261358
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2021 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626256905;
        bh=yB+Rsj/UD8YA/MsyyRAJBKiUJR3kbjDsKG09BrbHiys=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eTm68UHnmJ8ZwZVRI/Lz0+PkkeXDMwrzaEgol1zAzVRVTDsPrCvARleC9TmeeQgmt
         8bp4d2C31CQ0RuhVqo3/XrN97da3hFH+fANoqu6D3JYn25TABUAmpY0Zle1FWDyKAS
         uLqM1w35wVVveJ0g9g5ezU0/rSz5m5wNels0i225kWgcXnO8L0cREcF1YfYDkxsXDX
         SaNSLEKRPYHm9/Zmf4XSy+z1+jp8NqjPDGU3ZwnT5DIjJzYIhKnWCX7W7gEoVhxH84
         k3WL8ON76qPTvU1i5cPhsWSC90qmbjtw4VZMgl/vsEkk7M0EIR4olQZCP8lXL15Sqq
         /fdNz8WJbHJEA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 213157] BUG: unable to handle page fault for address: fffbb000,
 Workqueue: ata_sff ata_sff_pio_task
Date:   Wed, 14 Jul 2021 10:01:44 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-213157-11633-BgdJs1SqTo@https.bugzilla.kernel.org/>
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
 Attachment #296895|0                           |1
        is obsolete|                            |

--- Comment #3 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 297839
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D297839&action=3Dedit
kernel .config (kernel 5.14-rc1, Shuttle XPC FS51, Pentium 4)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
