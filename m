From: wessels <wessels147@gmail.com>
Subject: SB700 AHCI causes disk power cycle
Date: Sun, 22 Jun 2008 19:52:08 +0200
Message-ID: <a58c5fe70806221052w7c93b342hdaf44fb27983534a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:32553 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbYFVRwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jun 2008 13:52:13 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1689616wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 22 Jun 2008 10:52:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I also bought an ASUS M3A78 mATX board with a SB700 to see if it might
solve my problem with the SB600. But it doesn't.
The SB700 shows the same behaviour as the SB600, it periodically
throws an error and the power cycles the disk.
But it always happens on one channel not both. Perhaps a sudden burst
in disk IO causes this but I'm unable to
reproduce this with a synthetic load. Only when vmware is running this
happens. I don't see it when the machine is idling.
The load on the machine is very light both on cpu and disk. Also I
didn't see the error with a single seagate disk attached.

The error and configuration is the same as mentioned in my earlier
post regarding the "SB600 AHCI causes disk power cycle".

What I didn't mentioned then was the filesystem layout
two disks in a mirror
/dev/sda & /dev/sdb
no LVM just a software raid via md
md0 /boot ext3
md1 / ext3
md2 swap
md3 /usr/local/virtmach XFS

Please let me know what else I need to log and/or test.

Thank you for your time and interest,

Wessels
