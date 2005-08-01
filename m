From: Polly <pollyp100@yahoo.com>
Subject: Plextor 712-sa write issue (repost)
Date: Mon, 1 Aug 2005 10:23:17 -0700 (PDT)
Message-ID: <20050801172318.79706.qmail@web34313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web34313.mail.mud.yahoo.com ([66.163.178.145]:17761 "HELO
	web34313.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262052AbVHARXW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 13:23:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

This is my second post on this issue, in the hopes
that someone can enlighten me, or point me off to the
right resource for this problem.

I can mount my Plextor 712 SA DVD burner read-only,
but I can't mount it read-write. I have an Intel ICH6
SATA controller:

---
Jul 28 11:37:54 HTPC kernel: cdrom: sr0: mrw address
space DMA selected
Jul 28 11:37:54 HTPC kernel: attempt to access beyond
end of device
Jul 28 11:37:54 HTPC kernel: sr0: rw=0, want=68,
limit=4
Jul 28 11:37:54 HTPC kernel: isofs_fill_super: bread
failed, dev=sr0, iso_blknum=16, block=16
---

I am running under 2.6.12.3, with ATA_ENABLE_ATAPI and
ATA_ENABLE_PATA in libata.h turned on.

- Is this a known issue? If so, is there a bug number
I should track, a branch or release I should be
keeping an eye on? Should I be trying out a particular
patch? Is there a workaround for this?

- If this is not a known issue, should I open a
bugzilla report on this? Is there additional
information that would be useful for me to include in
a report?

Again, if there are developers that are working on
this, I'd be happy to work with you as an alpha test
site.

Thank you for your time,

Polly


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
