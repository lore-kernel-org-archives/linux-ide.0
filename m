From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Fri, 6 Nov 2009 12:51:51 GMT
Message-ID: <200911061251.nA6Cppke032145@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42365 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759212AbZKFMvq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2009 07:51:46 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nA6CppvA032146
	for <linux-ide@vger.kernel.org>; Fri, 6 Nov 2009 12:51:51 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310





--- Comment #8 from David S. Miller <davem@davemloft.net>  2009-11-06 12:51:46 ---
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 5 Nov 2009 16:54:27 +0100

> The problem is that the change in the debug patch affects all host drivers
> and at this moment is not safe enough neither for -stable nor for -rc.
> 
> Somebody needs to go and review all host drivers and their usage of ->media
> field for tuning logic present in ->set_pio_mode implementations first.

The drivers which do this are:

drivers/ide/alim15x3.c
drivers/ide/it8172.c
drivers/ide/it8213.c
drivers/ide/pdc202xx_old.c
drivers/ide/piix.c
drivers/ide/qd65xx.c
drivers/ide/sis5513.c
drivers/ide/slc90e66.c

While the majority of them seem to use it to decide whether to enable
prefetching or not, alim15x3.c uses the ->media value to decide
whether to turn on the ATA or the ATAPI FIFO.

I don't think it's safe to call ->set_pio_mode() until we actually
know the media type.

I suppose we could guard the prefetch/FIFO changes in these drivers
with a test like:

    if (!(hwif->port_flags & IDE_PFLAG_PROBING))

or something like that.

But in this stage of the game, it's just too risky and reverting
the early PIO0 commit is the best way to go.

I'll do that now.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
