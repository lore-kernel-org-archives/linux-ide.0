From: "James  C. Bevier" <jbev@jbsys.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Tue, 26 Oct 2004 08:48:11 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <001701c4bb73$330c8c30$0a01a8c0@jbsys.com>
References: <20041026111746.12695.qmail@web88002.mail.re2.yahoo.com>
Reply-To: "James  C. Bevier" <jbev@jbsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 24-117-200-54.cpe.cableone.net ([24.117.200.54]:9875 "EHLO
	hipeak.jbsys.com") by vger.kernel.org with ESMTP id S261186AbUJZPsO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Oct 2004 11:48:14 -0400
List-Id: linux-ide@vger.kernel.org
To: Ericisko <linux2@rogers.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Ericisko,

The disks are two identical Western Digital 160 GB drives.  They are
seen by Windows XP and were seen by the Promise driver under
Linux 2.4.  I have the BIOS set on the K8V SE Deluxe motherboard
to be non-raid disks on the Promise controller.  The first drive has
two NTFS partitions and the second has three Linux partitions.  Hda
& hdb are 80 GB drives and hdc & hdd are DVDROM & DVD Writer.
I was able to read the NTFS files and did not experience any lock-ups.
I have an Athlon64  3200+ and am only running the 64 bit version of
Fedora Core 3 RC1.

I will do some more testing to see if I can see the second drive.
Thanks for the information.

Jim

----- Original Message ----- 
From: "Ericisko" <linux2@rogers.com>
To: "James C. Bevier" <jbev@jbsys.com>; "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-ide@vger.kernel.org>
Sent: Tuesday, October 26, 2004 4:17 AM
Subject: Re: Pata support on Promise controller under Fedora Core 3


> James,
> 
> I don't have any additional code. I quickly tested it
> on my system (PDC20378) and both drives were
> recognized.
> However, I've got hard lockup after about 1 min. It is
> with vanilla 2.6.9-rc3, smp, preempt enabled. Didn't
> have time to investigate further.
> Are your drives recognized by BIOS? Also, AFAIK PATA
> port on 378 supports only ATA (disk) drives, not ATAPI
> drives (CD/DVD). Is your second drive disk or CD/DVD?
> 
>  Erik
> 
> --- "James  C. Bevier" <jbev@jbsys.com> wrote: 
>> Jeff,
>> 
>> I cut out the attached patch from the sata_promise
>> dev patches on kernel.org.  I 
>> put it in the latest kernel in Fedora Core 3 RC1. 
>> It is version 2.6.9-1.640 
>> kernel.  It works well enough to be able to see the
>> first PATA drive on the 
>> Promise controller.  It does not see the second
>> drive.  The code only seems to 
>> work for one drive.  Could you (or Erik) provide the
>> rest of the code that will 
>> see the second drive.  If you could point me to
>> specs for the controller or give 
>> me the register offset for the last drive, I could
>> try to hack at it myself.  I 
>> really need this to work in Fedora Core 3.
>> 
>> Thanks for your help!
>> 
>> Jim Bevier 
>> 
> 
>> ATTACHMENT part 2 application/octet-stream
> name=linux-2.6.9-sata_promise.patch
> )
>
