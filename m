Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7882BC05027
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 21:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBAVCV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBAVCU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 16:02:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF0F98
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 13:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0837CB822B8
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 21:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1955C433EF
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 21:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675285337;
        bh=M3tKaohgcaofBbeeb8l4OxZEqUXOKJXbYV5Zc3RztuQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tua/kS9V2HCjj1NVvhasvwDJRftwt1Z9FRie6Rh3bJ9XDgpnc/3vN1RNILgprrThy
         PGIksrrkcb6OKrmbYQOLXRtOP0GZGGKYx4PhwZURXQ+KfJz+ZLOQjIczVMpA7W7qXk
         Rc1BwRXxLg5azIqzlIGoqaXTVKYGtqHVBncjsRiSt1Hq9L6hSLYf3dXnKGsh7fTtn2
         kM9q90ReOv2uSGFMbERdlWqYjbH92qH1QWAg5IEYb+IgZaQLwqNdHOyLUP2QUCCGCN
         /B8+Ll9EbJI43tzyw6wnVMPD16gKidjXEE9IeuGZjv4knMBMoAS9guFKOInAX5cf0I
         mV50MoRZ5zh8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 93368C43144; Wed,  1 Feb 2023 21:02:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 216982] sound hit
Date:   Wed, 01 Feb 2023 21:02:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: damien.lemoal@wdc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216982-11633-VvSY0AKavr@https.bugzilla.kernel.org/>
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

Damien Le Moal (damien.lemoal@wdc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |damien.lemoal@wdc.com

--- Comment #4 from Damien Le Moal (damien.lemoal@wdc.com) ---
Cannot change the ide@ assignment either :)
Someone who can, please remove ide from the distribution list. This regress=
ion
is not about ATA storage.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
