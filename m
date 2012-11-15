From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: libata: ata identify timeouts
Date: Thu, 15 Nov 2012 17:06:21 +0900 (JST)
Message-ID: <945736.73852.qm@web100007.mail.kks.yahoo.co.jp>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100007.mail.kks.yahoo.co.jp ([114.111.98.181]:41615 "HELO
	web100007.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S2992679Ab2KOIGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2012 03:06:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I think this is the code that prevents use of some hard drives:

> static const unsigned long ata_eh_identify_timeouts[] = {
>          5000,  /* covers > 99% of successes and not too boring on failures */
>         10000,  /* combined time till here is enough even for media access */
>         30000,  /* for true idiots */
>         ULONG_MAX,
> };

with help from its immediate predecessor:

> static const unsigned long ata_eh_reset_timeouts[] = {
>         10000,  /* most drives spin up by 10sec */
>         10000,  /* > 99% working drives spin up before 20sec */
>         35000,  /* give > 30 secs of idleness for retarded devices */
>          5000,  /* and sweet one last chance */
>         ULONG_MAX, /* > 1 min has elapsed, give up */
> };

When 5 SATA drives are connected through a port multiplier, some drives become more retarded than they used to be.  They become worse than idiots.  Resetting every 10 seconds doesn't even teach them to speed up.

Is it safe for me to change all of those timeouts to 60000?  Will something else get damaged by that?  Or maybe I should ask first, is this likely to solve the problem of some drives not getting identified, or is there other impatient code somewhere else that disables them?

