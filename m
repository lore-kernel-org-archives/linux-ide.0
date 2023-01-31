Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F5C636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 23:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjAaXrp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaXro (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 18:47:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE42B619
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 15:47:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB56DB81FAC
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 23:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C95C433D2
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675208860;
        bh=0FqGljvrhxi486e39SVgqa0ci0r+Olhg/nVe751vFZs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A4bqlbymjVJ+uoppqt15E0G8pd9e1rcKDiHTa49BmLnq3yq/qGq6YgoRExKx5CYEy
         pmhUm1KfqtoIawgoMm9R+cqyra3TDcxhgYdTRIWO7y5EgNNq9Zx7xLaj22mnenEj1g
         MAq512vUm1lGPjOHeET4QdHmUSRG2rwbA+HKcUHO72vOFd7sJmmOkXTqy4ines7vIO
         DJuB4gFjGSMCCvrmcY2Slw1dalfnxU0ivLfBS9j5Y7RAHabxYA6udJVU90gOPZbI/j
         L1NujhoIbh9KCtPyGSBd2PJ1Kf13l3sDsiBOVatYh7Zh810UHp4m0iLfb6UfFccTLn
         ovh/D3Jk9KHBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 76495C43142; Tue, 31 Jan 2023 23:47:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 216982] sound hit
Date:   Tue, 31 Jan 2023 23:47:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: damien.lemoal@opensource.wdc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216982-11633-98NdIsT2rr@https.bugzilla.kernel.org/>
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

--- Comment #1 from damien.lemoal@opensource.wdc.com ---
On 2023/02/01 1:59, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216982
>=20
>             Bug ID: 216982
>            Summary: sound hit
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 6.1.8
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>           Assignee: io_ide@kernel-bugs.osdl.org
>           Reporter: kirill-s-0801@yandex.ru
>         Regression: No
>=20
> The sound disappeared on the ASUS Vivobook. When I plugged in the headpho=
nes,
> the sound disappeared, after removing the headphones, the sound did not w=
ork.
> Switched cores, there is no sound. When there should be the intended soun=
d,
> there is a crackling in the headphones. And everything works on the Windo=
ws.
> (fedora 37)
>=20

Why is this addressed to linux-ide ? This problem has nothing to do with li=
bata
& ata drivers.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
