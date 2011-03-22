From: Herbert Poetzl <herbert@13thfloor.at>
Subject: PMP and Smart Enclosure ...
Date: Tue, 22 Mar 2011 15:54:40 +0100
Message-ID: <20110322145440.GA15541@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:43051 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab1CVPPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Mar 2011 11:15:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>


following up on a thread about PMP and SEP from earlier this
year, I have now prepared a test system which should allow
me to control all involved parts (i.e. SATA controller, PMP
and the SEP) for testing and debugging ...

during the initial system tests, I found some strange
behaviour, which I am unable to explain, and it might as
well be a SATA/PMP bug in Linux ...

the problem basically arises when I pull a drive from the 
enclosure (without telling Linux first), wait some time
till the kernel becomes aware of the fact, and then put it 
back into the enclosure ...

at this point, the drive indicator (PMP and the drive one)
goes on, the drive spins up, but Linux refuses to detect
the device ... I tried the following things:

 echo "- - -" >/sys/class/scsi_host/host9/scan

 scsiadd -s 9

 resetting the PMP (via small front panel button)

note that the target is still listed in sysfs:
# ls /sys/class/scsi_host/host9/device/
power/  scsi_host/  subsystem@  target9:0:0/  target9:1:0/  target9:2:0/  target9:3:0/  target9:4:0/  uevent

only way to get the device back seems to be to remove the
driver (rmmod sata_sil24) and to reload it again, which is
probably a little tricky assuming that the other disks are
in use :)

many thanks in advance,
Herbert

