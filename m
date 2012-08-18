From: Brian Norris <computersforpeace@gmail.com>
Subject: Deferred disk spinup during system resume
Date: Fri, 17 Aug 2012 19:12:30 -0700
Message-ID: <CAN8TOE_Y2EgSoK4euCC6fp1jr8bKyjdoVJq=Kk8fnG6qZboTGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34395 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab2HRCMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 22:12:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

Hi Tejun,

I would like some advice regarding a patch you sent a while ago. I'd
greatly appreciate some help.

I'm working on an embedded platform in which the resume from suspend
process takes an excessive amount of time waiting on the disk to spin
up, even though the disk is not integral to system wake-up. You sent
this patch a while back to deal with this issue:
http://article.gmane.org/gmane.linux.scsi/64719

Unfortunately, this doesn't seem to work on my system. With this
applied to either 2.6.37 (current kernel near the time of the patch)
or 3.3, a simple suspend/resume cycle no longer actually spins down
the disk. The problem is actually worse on 2.6.37, where I get errors
like this during resume:

sd 1:0:0:0: [sda] Starting disk
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
sd 1:0:0:0: [sda] START_STOP FAILED
sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
pm_op(): scsi_bus_resume_common+0x0/0x6c returns 262144
PM: Device 1:0:0:0 failed to resume async: error 262144

And any subsequent I/O fails:

sd 1:0:0:0: [sda] Unhandled error code
sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sda] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 20 00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
Buffer I/O error on device sda, logical block 1
Buffer I/O error on device sda, logical block 2
Buffer I/O error on device sda, logical block 3
sd 1:0:0:0: [sda] Unhandled error code
sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sda] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0

(I do not experience the last two problems on my 3.3 kernel)

I understand that your original patch was given the "not tested"
disclaimer, but I wanted to know if you had any immediate advice on
why this failed so miserably for me, before I go trying to dig in to
this issue more deeply. For instance, maybe there's been enough code
change between 2.6.37 and 3.3 (or current upstream - 3.6-rc2) that
would require a change in approach.

Thanks,
Brian
