From: Tejun Heo <tj@kernel.org>
Subject: Re: SB700 AHCI causes disk power cycle
Date: Mon, 23 Jun 2008 09:28:06 +0900
Message-ID: <485EEE16.1060701@kernel.org>
References: <a58c5fe70806221052w7c93b342hdaf44fb27983534a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49234 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbYFWA2O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 20:28:14 -0400
In-Reply-To: <a58c5fe70806221052w7c93b342hdaf44fb27983534a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wessels <wessels147@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

wessels wrote:
> Hi,
> 
> I also bought an ASUS M3A78 mATX board with a SB700 to see if it might
> solve my problem with the SB600. But it doesn't.
> The SB700 shows the same behaviour as the SB600, it periodically
> throws an error and the power cycles the disk.
> But it always happens on one channel not both. Perhaps a sudden burst
> in disk IO causes this but I'm unable to
> reproduce this with a synthetic load. Only when vmware is running this
> happens. I don't see it when the machine is idling.
> The load on the machine is very light both on cpu and disk. Also I
> didn't see the error with a single seagate disk attached.
> 
> The error and configuration is the same as mentioned in my earlier
> post regarding the "SB600 AHCI causes disk power cycle".
> 
> What I didn't mentioned then was the filesystem layout
> two disks in a mirror
> /dev/sda & /dev/sdb
> no LVM just a software raid via md
> md0 /boot ext3
> md1 / ext3
> md2 swap
> md3 /usr/local/virtmach XFS
> 
> Please let me know what else I need to log and/or test.

>From your report on sb600.

kernel: ata4: SError: { RecovComm Persist PHYRdyChg 10B8B }
kernel: ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
kernel:          res 40/00:3c:0d:bd:c9/00:00:0b:00:00/40 Emask 0x10 (ATA bus error)

This combined with the incremented start stop count looks very much
like the harddisk went offline briefly and came back for whatever
reason.  I doubt the ahci driver even with its all might can do that.

Can you please try to hook up the faulting harddrive to a separate
power supply?

  http://modtown.co.uk/mt/article2.php?id=psumod

-- 
tejun
