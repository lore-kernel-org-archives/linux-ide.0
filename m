From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon, 29 Dec 2008 07:49:45 -0800 (PST)
Message-ID: <20081229154945.909D210800C@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397AbYL2PuR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 10:50:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBTFnj8w016591
	for <linux-ide@vger.kernel.org>; Mon, 29 Dec 2008 07:49:47 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #6 from nm127@freemail.hu  2008-12-29 07:49 -------
Created an attachment (id=19528)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=19528&action=view)
git bisect log

(In reply to comment #3)
> I started to git bisecting the problem but this might take a while.

The result of git bisecting is:

9bd27cba1aeacb6b12d05f4e5ed6361072f08fe0 is first bad commit
commit 9bd27cba1aeacb6b12d05f4e5ed6361072f08fe0
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Sun Nov 2 21:40:07 2008 +0100

    ide-cd: fix DMA alignment regression

    e5318b531b008c79d2a0c0df06a7b8628da38e2f ("ide: use the dma safe check for
    REQ_TYPE_ATA_PC") introduced a regression which caused some ATAPI drives to
    turn off DMA for REQ_TYPE_BLOCK_PC commands while burning and thus
degrading
    performance and ultimately causing an excessive amount of underruns.

    The issue is documented also in:
    http://bugzilla.kernel.org/show_bug.cgi?id=11742.

    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
    Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
    Tested-by: Valerio Passini <valerio.passini@unicam.it>
    [bart: fixup patch description per comments from Sergei Shtylyov]
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

:040000 040000 998c57acb8e63f2f1d64543f2c03ecfc05beb3a0
fef197de8e3c9db1308917eaeb1c10f196a8a8ab M      drivers





(In reply to comment #4)
> can you try the following patch on a failing kernel and send me the whole dmesg output?

I'll have a look.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
