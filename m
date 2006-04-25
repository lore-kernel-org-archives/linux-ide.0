From: "James Sutherland" <J.A.Sutherland@dundee.ac.uk>
Subject: sata_sil 3114 and Seagate problem
Date: Tue, 25 Apr 2006 13:39:38 +0100
Message-ID: <s44e26aa.070@gw-out.dundee.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pp6a.dundee.ac.uk ([134.36.2.69]:46840 "EHLO pp6a.dundee.ac.uk")
	by vger.kernel.org with ESMTP id S932211AbWDYMkG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Apr 2006 08:40:06 -0400
Received: from ia-gen-a2.dundee.ac.uk ([134.36.0.42] helo=gw-out.dundee.ac.uk)
	by pp6.dundee.ac.uk with esmtp (Exim 4.43)
	id 1FYMpe-0002lk-JP
	for linux-ide@vger.kernel.org; Tue, 25 Apr 2006 13:40:05 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Running 2.6.16.7, I'm hitting problems with one of my two 3114 cards.

Setup:

10 Seagate drives, all ST3400832AS rev 3.03. Four connected to an
onboard nVidia chip, four connected to one 3114 card, the final pair
connected to a second 3114. Tyan (K8W/2885) motherboard, two dual
Opterons, 8Gb RAM.

It seems everything is fine, except the two drives connected to the
second 3114. A Dutch guy (Joost Kraaijeveld) posted last month about a
problem with two drives connected to a 3114, same motherboard as me, and
got no response. The 3114 is supposed to be immune to the m15w problem,
isn't it?

dmesg error follows:
ATA: abnormal status 0xD8 on port 0xFFFFC200000102C7
ATA: abnormal status 0xD8 on port 0xFFFFC200000102C7
ATA: abnormal status 0xD8 on port 0xFFFFC200000102C7
ata8: command 0x25 timeout, stat 0xd8 host_stat 0x1
ata8: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata8: status=0xd8 { Busy }
sd 7:0:0:0: SCSI error: return code = 0x8000002
sdf: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdf, sector 0
Buffer I/O error on device sdf, logical block 0

I tried enabling slow_down - no difference. The drive itself passes
Seagate's diagnostics (run on another machine), but just trying to read
from the drive once this happens leaves the process in state D.

The problem seems to be triggered by heavy I/O - when hde (the 1st
drive on the same controller) went out-to-lunch and md started
rebuilding the array on sdf, everything went downhill quickly; as I
recall, the other 3114 card started dropping disks as well, killing the
array, but the system seems to be working OK apart from these two drives
for the moment. Performance on the other 4 drives isn't great, but at
least they do work...

Any suggestions? Any other information I can give people to help debug
this, or patches to try?


James.

