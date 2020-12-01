Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA4C64E7B
	for <linux-ide@archiver.kernel.org>; Tue,  1 Dec 2020 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5664B20575
	for <linux-ide@archiver.kernel.org>; Tue,  1 Dec 2020 17:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgLARdb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:33:31 -0500
Received: from vps.thesusis.net ([34.202.238.73]:50792 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbgLARda (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 1 Dec 2020 12:33:30 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 12:33:30 EST
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id C28C62705F
        for <linux-ide@vger.kernel.org>; Tue,  1 Dec 2020 12:24:50 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D3Q6uwCqpWt9 for <linux-ide@vger.kernel.org>;
        Tue,  1 Dec 2020 12:24:50 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 6DEEF27063; Tue,  1 Dec 2020 12:24:50 -0500 (EST)
User-agent: mu4e 1.5.6; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     linux-ide@vger.kernel.org
Subject: Drive reset as an EH strategy when write cache is enabled
Date:   Tue, 01 Dec 2020 12:24:50 -0500
Message-ID: <87r1o9phgd.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A while back I noticed lines in my syslog indicating that a FLUSH CACHE
command timed out and the drive was hard reset to recover.  That made me
wonder if such a thing makes any sense as a valid EH strategy.  Any
previous writes that returned successfully but are still sitting in the
drive's write cache will be silently invalidated by resetting the drive
won't they?  Then the FLUSH CACHE command is retried, and of course,
succeeds because it is now a NOOP.  Then fsync() returns and postfix
thinks my new email has been committed to the disk, when in fact, it has
not.

Am I mistaken somewhere or is the kernel really doing the wrong thing
here?
