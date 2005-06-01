From: Bob Ramstad <rramstad@gmail.com>
Subject: sata_sil 0.9 experience
Date: Wed, 1 Jun 2005 11:51:39 -0700
Message-ID: <86298ca105060111511cfd1cf1@mail.gmail.com>
Reply-To: rramstad@alum.mit.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:1744 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261230AbVFASvo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2005 14:51:44 -0400
Received: by zproxy.gmail.com with SMTP id 13so2082232nzn
        for <linux-ide@vger.kernel.org>; Wed, 01 Jun 2005 11:51:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is anecdotal, but may be helpful.  If you require more details,
please let me know.

I recently converted a WBEL3 (RHEL3 clone) system from using IDE
drives to using Serial ATA.  I found the performance using the built
in driver abysmal, and switched over to libata + sata_sil.  The
sata_sil version shipping with the RHEL3 kernel is 0.54 (ancient) but
gave me much better performance (45x as fast).

Things seemed fine, but I noticed when doing massive copies -- say 20
GB of data in 2000 files -- that it was not uncommon to have one or
two files corrupted in the copy.  Recopying the affected files would
fix the problem.  I started keeping md5 checksums of anything I was
copying back and forth.

The problem finally drove me nuts, and I did some research online and
found the 0.8 -> 0.9 sata_sil driver.  Up until then I didn't know I
was using an ancient version of sata_sil.

Unfortunately, I was unable to just upgrade to 2.4.31 due to
threads... when I compiled 2.4.31-rc1 and booted with it, BIND aka
named would dump core, and upon investigation I discovered that the
vanilla 2.4 kernel would not work right with RHEL3.  (I'm sure if I
spent a bunch of time that there has to be a way to compile 2.4 so
that it works with RHEL3, but I'm not really all that interested in
that particular learning curve.)

I then tried to use the sata_sil.c 0.9 with the kernel-source for
RHEL3 and that failed miserably with many compile time errors... I
also tried to replace the entire drivers/scsi directory, and that
failed too.

Finally, I patched by hand my 0.54 sata_sil.c source by looking at the
0.8 -> 0.9 changes and making the same changes.

The upshot of all of this is that my modified 0.54 with manual 0.8 ->
0.9 sata_sil.c seems to work much better.  I've done some testing,
with three or four large copies, and had no data corruption.  My
testing is not extensive, however.

My hardware is ASUS A7N8X-E Deluxe (nForce2 chipset) with onboard
Silicon Image SATA RAID.  Drives are two new Seagates ST3250823AS.  I
use them with Linux LVM with some partitions as ext3 on top of RAID1
and some straight ext3 partitions.  I do not use the SI RAID
functionality, the drives are used as plain old /dev/sdX with software
/dev/mdX RAID.

I hope this information helps.  Of course, I'm feeling a little bit
painted into a corner, I can't keep doing weird hand patches to the
kernel-source for RHEL3 when new versions of the kernel come out...
and given that RedHat seems to have no urgency to upgrade sata_sil
given the shipping version is 0.54 (archaic) I'm hopeful that the 0.9
will finally make it into the next official RHEL3 kernel given the
data corruption issues.  The other alternative from my perspective is
to consider going to RHEL4 as at least the learning curve there is
probably something I'll have to deal with eventually anyway.

Thank you for all your hard work on sata_sil -- it is much appreciated
by a LOT of people!

Do let me know if there is anything specific I can test or details I
can provide... or if any of you have specific thoughts on how I can
best maintain my system, given the weird hand patched mess that it is
right now!

-- Bob
