Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFFC05027
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 12:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBAMVP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAMVP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 07:21:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A31423A
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 04:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E53D9B82151
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 12:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A30D4C4339B
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675254071;
        bh=cwEqJWi0PEUXAGFrG3MYGct874WLPkFQrHfIOb3SRGQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XFTPfOW+H/8CxfM4yTf+wNXHRRrC5nMwaBmShmwcpOxR9nEwUR3GpX8xt1Kmj9XGY
         AJGR3NzRb3ZJ1WD/N/M+v64RFiX4e+zf+VvfYsnVTj3s3ZxsEf2BZsKlzfiESzXWZs
         CrmtBfPaOFDr5N8xejzv0wL5NidKUqydRVOLqPzvlKIOCCQbyJAyEV0Kfh0o8bC7NZ
         D++PzIJ7MQ4XI20LhDLO1g/uwpydJt5OENTiFjyRgtViwx3dl5pnbkI0H2PWZ6wpSP
         92aJtCJaYcNwosdqU87PoiwPSaRWUhKf46+r5TpAidMCp+/myqdqB7VqOgmBEjKwrw
         eJIx32CT6CfRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C3DBC43143; Wed,  1 Feb 2023 12:21:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 216982] sound hit
Date:   Wed, 01 Feb 2023 12:21:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kirill-s-0801@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component rep_platform
Message-ID: <bug-216982-11633-R17c1SFFlf@https.bugzilla.kernel.org/>
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

kirill (kirill-s-0801@yandex.ru) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|IDE                         |Other
           Hardware|All                         |Intel

--- Comment #2 from kirill (kirill-s-0801@yandex.ru) ---
(In reply to kirill from comment #0)
> The sound disappeared on the ASUS Vivobook. When I plugged in the
> headphones, the sound disappeared, after removing the headphones, the sou=
nd
> did not work. Switched cores, there is no sound. When there should be the
> intended sound, there is a crackling in the headphones. And everything wo=
rks
> on the Windows. (fedora 37)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
