From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: If I have a single bad sector, how many failed reads should simple dd
	report?
Date: Thu, 8 Jul 2010 13:14:09 -0400
Message-ID: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47135 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab0GHROJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jul 2010 13:14:09 -0400
Received: by iwn7 with SMTP id 7so1086312iwn.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Jul 2010 10:14:09 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

All,

I just ran a test against a IDE drive (/dev/sdb) and slightly older
kernel (2.6.32).

Similar to:

dd if=/dev/sdb of=/dev/null conv=noerror,sync bs=4k

With a good drive it ran fine.

Then I used hdparm --make-bad-sector to intentionally corrupt a sector
on the drive.

When I re-ran it, /var/log/messages reported 10 bad logical blocks.
And even worse, dd reported 20 bad blocks.  I examined the data dd
read and it had 80KB of zero'ed out data.  So that's 160 sectors worth
of data lost because of a single bad sector.  At most I was expecting
4KB of zero'ed out data.

I haven't started troubleshooting, but I want to know if this is
expected behavior due to read-ahead or something.  (Is there
read-ahead on the raw device, or just if a file system is involved.)

I can redo my test with 2.6.34 and get logs if that is a bug.

And if not a bug, is there a hdparm command I can issue to eliminate
this behaviour.

Thanks
Greg
