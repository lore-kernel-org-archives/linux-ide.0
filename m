From: andrew henry <adhenry.9@gmail.com>
Subject: need advice: slow IO on eSATA WD MyBook compared with ext. ATA MyBook.
Date: Wed, 03 Sep 2008 21:46:58 +0200
Message-ID: <48BEE9B2.6070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:37815 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbYICTrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 15:47:01 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1460819eyi.37
        for <linux-ide@vger.kernel.org>; Wed, 03 Sep 2008 12:47:00 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wonder if anyone has had experience with WD MyBook drives, where older
ATA drives are faster than newer eSATA drives?

I have one 320GB WD Mybook with 1394-a and USB2 interface.  I have it
connected using 1394-a to an Acer Aspire laptop used as file server
running CentOS 5.2.  The disk is one big dmcrypt'ed partition using
ext3.  The tests below are all done on firewire for this drive, but in
the past I have tested USB2 and it was actually slightly faster than
firewire.

I bought some new drives in June, 2 new WD MyBook 500GB drives (the mac
version) which came with a triple interface; USB2, 1394-b and eSATA.

I bought a Silicon Image 3512 controller PCMCIA card with 2 ports, and
connected them both to that controller.  I set them up as a RAID-1
mirror array with mdadm and them encrypted the whole ext3 partition with
dmcrypt.  I had a few problems with this setup, where the disks tended
to flake out if they went to sleep, and mdadm would give up and take out
one of them from the array; then resync times were measured in days not
hours.  I also had problems where the ports would hang during boot or
shutdown, and this made it basically unusable.  I "solved" this by
running a cron job every 3 minutes to 'ping' the drives with sdparm, and
I powercycle the 2 drives just before bootup to solve the problem of
them hanging (the activity light on the pcmcia card would stay lit
indicating it had hung).

This has been working ok since july, and I have discussed these issues
on this list, and recieved a patch, which I am ashamed to say I have not
had time to try yet.

But now, I have finally gotten around to performance testing the drives
and it is a disaster!  The eSATA RAID-1 array is running awful compared
to the older ATA 320GB drive.  My tests are below.  I do not know if I
have tested correctly, and I am aware there will be a write penalty for
RAID.  My question is: Does this seem weird?  What speeds should I get
for eSATA?  Why does a SATA drive on a USB2 interface run much slower
than ATA drive on USB2 interface (note: i tested firewire, but 320GB on
USB has run faster than firewire)?  Why are the 500GB RAID-1 drives on
eSATA controller running at 15MB/s!!! and same RAID-1 array, plugged
into USB2, suddenly jumps up to average of 27MB/s?  I have not tested
the RAID-1 array on 1394-a yet, as I do not have a 1394-b to 1394-a
adapter, but I intend to test this as well.  Do I need to "tune" SATA
drives in the same way one had to tune older ATA drives?  For example,
You used to have to enable DMA on ATA drives, but with sata it's enabled
by default, but is there anything else similar to this that needs
setting with hdparm/sdparm to get "normal" performance?

#####  Firewire 400 Write test on WD 320GB dmcrypt ext3  #####

[root@k2 mnt]# /usr/bin/time dd if=/dev/zero
of=/mnt/mybook320/upload/test count
=393216
393216+0 records in
393216+0 records out
201326592 bytes (201 MB) copied, 6.28506 seconds, 32.0 MB/s
0.23user 3.82system 0:06.40elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+218minor)pagefaults 0swaps

#####  eSATA (sata_sil 3512) Write test on WD 500GB dmcrypt ext3  #####

[root@k2 mnt]# /usr/bin/time dd if=/dev/zero
of=/mnt/raid500/upload/test1 count=
393216
393216+0 records in
393216+0 records out
201326592 bytes (201 MB) copied, 13.3667 seconds, 15.1 MB/s
0.23user 3.52system 0:14.58elapsed 25%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2major+215minor)pagefaults 0swaps

#####  eSATA (sata_sil 3512) Read test on WD 500GB dmcrypt  #####

[root@k2 ~]# /usr/bin/time cp /mnt/raid500/upload/test1 ./
0.04user 2.39system 0:16.72elapsed 14%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (3major+212minor)pagefaults 0swaps

#####  Firewire 400 Read test on WD 320GB dmcrypt ext3  #####

[root@k2 ~]# /usr/bin/time cp /mnt/mybook320/upload/test ./
0.02user 1.55system 0:09.44elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (4major+209minor)pagefaults 0swaps



#######################################################
USB interface tests

#####  USB2 Write test on WD 320GB dmcrypt ext3  #####

[root@k2 Desktop]# /usr/bin/time dd if=/dev/zero
of=/mnt/mybook320/upload/test c
ount=393216
393216+0 records in
393216+0 records out
201326592 bytes (201 MB) copied, 5.30326 seconds, 38.0 MB/s
0.21user 3.29system 0:05.78elapsed 60%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+217minor)pagefaults 0swaps

#####  USB2 Write test on WD 500GB dmcrypt ext3  #####

[root@k2 Desktop]# /usr/bin/time dd if=/dev/zero
of=/mnt/raid500/upload/test1 co
unt=393216
393216+0 records in
393216+0 records out
201326592 bytes (201 MB) copied, 7.40847 seconds, 27.2 MB/s
0.18user 3.21system 0:07.69elapsed 44%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2major+214minor)pagefaults 0swaps

#####  USB2 Read test on WD 320GB dmcrypt ext3  #####

[root@k2 Desktop]# /usr/bin/time cp /mnt/mybook320/upload/test ./
0.01user 1.58system 0:08.86elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+213minor)pagefaults 0swaps

#####  USB2 Read test on WD 500GB dmcrypt ext3  #####

[root@k2 Desktop]# /usr/bin/time cp /mnt/raid500/upload/test1 ./
0.02user 2.42system 0:12.13elapsed 20%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+213minor)pagefaults 0swaps


--andrew
