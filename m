From: Eric Eikenberry <eric.eikenberry@psi.ch>
Subject: filesystem corruption with sata_sx4 driver
Date: Fri, 8 Oct 2004 17:24:58 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0410081711190.1475-100000@ganymede.psi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from psi11.psi.ch ([129.129.190.111]:11013 "HELO psi11.psi.ch")
	by vger.kernel.org with SMTP id S270015AbUJHPZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2004 11:25:36 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Dear Jeff & collaborators,

I am experiencing filesystem corruption with the sata_sx4 driver and
have accumulated some circumstantial evidence (below) that may permit
an expert to pinpoint the problem.  Of course, I can't be sure it is
that driver's problem.

Any help would be greatly appreciated.

Many thanks in advance.

Regards,
Eric

======================================================================
System:
Dual Xeon box from Fujitsu-Siemens
root=/dev/hda1 (ext3), a separate 120 GB  EIDE disk
Promise FastTrak S150 SX4 controller configured as 3 x JBOD
3 MaxTor Max Line plus II 250 GB SATA drives
	(the 4th one failed - twice!)
Suse 9.1
kernel: linux-2.6.9-rc3-mm3
ext3 -or- ext2 -or- reiser filesystems for tests below
	(no differences found)

I made sure that the sata_promise driver was not built, because it is
loaded in preference to the sata_sx4 driver, causing no end of problems.

Our application involves writing thousands of 7.6 MByte files at maximum
rate.  So, I made a program to simulate this by writing 1,000 such files
and measuring times.

Under some circumstances, the filesystem becomes corrupted, with the OS
reporting "wierd" files - strange permissions, crazy sizes (even
negative), etc.  These could be recovered with fsck.ext3, etc., to give
intact files.  So, the files themselves are intact.

The 3 disks were each partitoned with 1 partition.

I either mounted the 3 disks individually as /mnt/sda1, /mnt/sdb2, &
/mnt/sdc1, or configured them as a RAID0 array, or a mixture of the
two modes.  Results:

RAID0 with 3 disks, /dev/sda1, /dev/sdb1, /dev/sdc1 - array is
	corrupted after	~200 files.
RAID0 with 2 disks, /dev/sda1 & /dev/sdb1;  /mnt/sdc1 mounted, but
	not used - no problem
RAID0 with 2 disks, /dev/sda1 & /dev/sdb1;  sdc unplugged -
	corruption after 110 files; kernel freezes
no raid, just address /mnt/sda1, /mnt/sdb1 and /mnt/sdc1 directly
	write 1000 files to /mnt/sda1 - no problem
	write 1000 files to /mnt/sdb1 - no problem
	write 1000 files to /mnt/sdc1 - no problem
	write 1000 files to /mnt/sda1 and /mnt/sdb1 at the same time,
		alternating drives - no problem
	write 1000 files to /mnt/sda1, /mnt/sdb1 and /mnt/sdc1 at
		the same time on a round-robin basis - sdc1 (only)
		is quickly corrupted.
Even if sdc1 is merely present, but not mounted, sda1 and sdb1 work
	correctly.
But, if sdc1 is unplugged, then sdb1 becomes corrupted.

It is as if inode information is not being properly transmitted to the
the last disk in the array when it is targetted at the same time as
the other drives; when the last disk is used by itself, no problem.

Would this information lead someone to a fix?  Is it really the
sata_sx4 driver's problem?

=====================================================================


-------------------------------------------------------
Eric F. Eikenberry, Ph. D.
Swiss Light Source
Paul Scherrer Institute
CH-5232 Villigen PSI
Switzerland

Tel:  +41 56 / 310 51 28
             / 310 32 05
Fax:  +41 56 / 310 43 62

E-mail: eric.eikenberry@psi.ch
-------------------------------------------------------

