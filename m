From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: to /sys from /proc/ide/hd$v/identify
Date: Mon, 7 Jun 2004 13:46:00 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4D5B0986-B8BB-11D8-AE55-00039398BB5E@ieee.org>
References: <1086616121.3649.0.camel@patibmrh9> <40C4739C.6070508@pobox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:9601 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265024AbUFGTpN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 15:45:13 -0400
In-Reply-To: <40C4739C.6070508@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

>>> - /proc/ide/ interfaces are obsolete
>> Where do I now find the ATA op xEC/A1 "IDENTIFY" data that was
>> /proc/ide/hd$v/identify ?
>
> Since IDE supports taskfile ioctl, you shouldn't need this in sysfs...

Unless corrected, I will guess this answer means:

Forget about the ! CONFIG_IDE_TASK_IOCTL kernels, and then for the  
remaining kernels persuade Google to teach you ioctl  
HDIO_DRIVE_TASKFILE.

Pat LaVarre

P.S. Evidence as follows:

http://marc.theaimsgroup.com/?l=linux-ide&s=taskfile+ioctl
http://www.google.com/search?q=linux-ide+taskfile+ioctl
http://lxr.linux.no/ident?v=2.6.5&i=ide_taskfile_ioctl
http://lxr.linux.no/source/drivers/ide/ide.c?v=2.6.5#L1554

1548 #ifdef CONFIG_IDE_TASK_IOCTL
1549                 case HDIO_DRIVE_TASKFILE:
1550                         if (!capable(CAP_SYS_ADMIN) ||  
!capable(CAP_SYS_RAWIO))
1551                                 return -EACCES;
1552                         switch(drive->media) {
1553                                 case ide_disk:
1554                                         return  
ide_taskfile_ioctl(drive, cmd, arg);
1555                                 default:
1556                                         return -ENOMSG;
1557                         }

http://groups.google.com/groups?q=ioctl%20HDIO_DRIVE_TASKFILE

From: Jeff Garzik (jgarzik@pobox.com)
Subject: Re: "do ata" scsi command?
Newsgroups: mlist.linux.scsi
Date: 2003-05-16 09:00:27 PST
...
I don't like HDIO_DRIVE_TASKFILE in this case :) and here's why:
...
http://groups.google.com/groups? 
selm=linux.scsi.3EC509A1.10503%40pobox.com

