From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: IDE layer adoptations that *fake* a failing drive?
Date: 14 May 2004 17:17:24 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084576644.3084.92.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:27633 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264579AbUENXRt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 19:17:49 -0400
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leonw@mailcan.com>
Cc: linux-ide@vger.kernel.org

> code that sits between the IDE software layer and
> the storage device, that emulates a failing disk
> in one way or another.

I guess you want intermittent and unreliable failure ... else you could
swap in an ATAPI drive, since ATAPI protocol by definition looks like a
dead ATA drive.

Like you, I want to eject errors and timeouts, please post back here
what you find.  Meanwhile, three thoughts:

1) Read errors

Via ATA pass thru you can force a read error, if your drive supports the
write/ read long legacy of ATA 2 for that purpose.

2) No-data timeouts

Via 48-bit lba ATA you can force a slow timeout by asking to verify
xFFFF lba's = 32 MiB = (1 << (16+9)) bytes, at 512 = x200 = (1 << 9)
bytes/lba, if you drive actually does verify blocks when asked.

3) Write errors, data timeouts, etc.

Tough, without customarily proprietary knowledge of the drive.

Pat LaVarre


