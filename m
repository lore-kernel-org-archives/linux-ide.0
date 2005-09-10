From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Promise SATAII150 TX4 or raidreconf broken
Date: Sat, 10 Sep 2005 11:29:45 +1000
Message-ID: <43223709.8090002@eyal.emu.id.au>
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:60550 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030414AbVIJB3y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 21:29:54 -0400
In-Reply-To: <4313E433.1080602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Eyal Lebedinsky wrote:
> 
>> I needed a 4-port SATA controller and this was was picked. It seems
>> to work OK, however I find that Linux (2.6.12.5 and .13-rc7) see
>> the disks in a different order than the labelled sockets (which do
>> match what the BIOS detection lists at bootup).
>>
>> It is not even the reverse order:
>>     TX4 socket    sata_promise ata*
>>     1        4
>>     2        2
>>     3        1
>>     4        3
>> This order looks stable - I connected a different number of disks
>> on some ports and this ordering was maintained.
> 
> sata_promise driver just presents the devices in the order that the
> board maker has wired each port to the chip.  What may be labelled "port
> 3" on the board might be wired to the chip's port-0.  sata_promise just
> presents what it is given.
> 
>     Jeff

I am, for now, ignoring the ordering problem and moving on to using the
array.

I spent the last week attempting to build and test the array and I have
a problem: the array is thrashed by raidreconf. I need to know if this
is a hardware problem (TX4?), a raidreconf problem or a kernel issue.

It is now becoming urgent for me to sort this out, any hints will be
appreciated.

If this is a TX4 issue, which SATA controllers (4-way) are known to be
supported and good on Linux?

I have a test script that does this:
	build a 3-disk raid-5
	mkfs.ext3
	copy data in
		200+GB
	fsck
		OK
	raidreconf
		3->4 disks
	fsck
		failed

The disks are 320GB SATA "WDC WD3200JD-00K  Rev: 08.0". Kernel 2.6.13
vanilla.

The test takes about 16h to complete.

The rebuild messages:
====================
Sat Sep 10 01:19:07 EST 2005 mdbuild: checking the file system
====================================
/dev/md0: 4136/610560 files (2.7% non-contiguous), 55952642/156285568 blocks
Sat Sep 10 01:25:51 EST 2005 mdbuild: reconfiguring RAID
====================================
Parsing /etc/raidtab.old
Parsing /etc/raidtab.new
Old raid-disk 0 has 1220981 chunks, 312571136 blocks
Old raid-disk 1 has 1220981 chunks, 312571136 blocks
Old raid-disk 2 has 1220981 chunks, 312571136 blocks
New raid-disk 0 has 1220981 chunks, 312571136 blocks
New raid-disk 1 has 1220981 chunks, 312571136 blocks
New raid-disk 2 has 1220981 chunks, 312571136 blocks
New raid-disk 3 has 1220981 chunks, 312571136 blocks
Using 256 Kbyte blocks to move from 256 Kbyte chunks to 256 Kbyte chunks.
Detected 1035336 KB of physical memory in system
A maximum of 1181 outstanding requests is allowed
Working with device /dev/md0
Size of old array: 1875427344 blocks,  Size of new array: 2500569792 blocks
---------------------------------------------------
I will grow your old device /dev/md0 of 2441962 blocks
to a new device /dev/md0 of 3662943 blocks
using a block-size of 256 KB
Is this what you want? (yes/no): yes
Converting 2441962 block device to 3662943 block device
Allocated free block map for 3 disks
4 unique disks detected.
Working (/) [02441962/02441962] [############################################]
Source drained, flushing sink.
Reconfiguration succeeded, will update superblocks...
Maximum friend-freeing depth:         8
Total wishes hooked:            2441962
Maximum wishes hooked:             1181
Total gifts hooked:             2441962
Maximum gifts hooked:               991
Congratulations, your array has been reconfigured,
and no errors seem to have occured.
Updating superblocks...
handling MD device /dev/md0
analyzing super-block
disk 0: /dev/sda, 312571224kB, raid superblock at 312571136kB
disk 1: /dev/sdb, 312571224kB, raid superblock at 312571136kB
disk 2: /dev/sdc, 312571224kB, raid superblock at 312571136kB
disk 3: /dev/sdd, 312571224kB, raid superblock at 312571136kB
Array is updated with kernel.
Disks re-inserted in array... Hold on while starting the array...
Sat Sep 10 10:30:19 EST 2005 mdbuild: checking the file system
====================================
/dev/md0: Inode 129 is in use, but has dtime set.  FIXED.
/dev/md0: Inode 129 has imagic flag set.

/dev/md0: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)


Inspecting the fs shows real corruption. It does not even look like full
bad blocks but specific entries are bad. The some directories are completely
missing and I (naturally) get errors reading the fs (mounted with errors).

/data3/mythtv/tv_grab_au:
========================
total 2968465682
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:56 08092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:56 09092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:59 10092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:57 11092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:58 12092005
?--xrws--T  31794 3359396242 982138100 1048034695 Oct  9  1972 13092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  8 04:59 14092005
drwxr-sr-x      2 mythtv     mythtv          8192 Sep  9 04:52 15092005
srw-----w-  26765  936675348 473714967 2355711621 Oct  5  1976 16092005
drwxr-sr-x      2 mythtv     mythtv          8192 Aug 26 04:54 26082005
drwxr-sr-x      2 mythtv     mythtv          8192 Aug 26 04:54 27082005
drwxr-sr-x      2 mythtv     mythtv          8192 Aug 26 04:55 28082005
drwxr-sr-x      2 mythtv     mythtv          8192 Aug 26 04:55 29082005
drwxr-sr-x      2 mythtv     mythtv          8192 Aug 24 04:57 30082005
-rw-r--r--      1 mythtv     mythtv        362153 Nov  5  2004 guide.xml

The original has:
================
drwxr-sr-x  2 mythtv mythtv   8192 Sep  8 04:56 09092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep  8 04:57 10092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep  8 04:57 11092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep  8 04:58 12092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep 10 04:58 13092005 <<<<<
drwxr-sr-x  2 mythtv mythtv   8192 Sep  8 04:59 14092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep  9 04:52 15092005
drwxr-sr-x  2 mythtv mythtv   8192 Sep 10 05:00 16092005 <<<<<
drwxr-sr-x  2 mythtv mythtv   8192 Sep 10 05:00 17092005
drwxr-sr-x  2 mythtv mythtv   8192 Aug 26 04:54 26082005
drwxr-sr-x  2 mythtv mythtv   8192 Aug 26 04:54 27082005
drwxr-sr-x  2 mythtv mythtv   8192 Aug 26 04:55 28082005
drwxr-sr-x  2 mythtv mythtv   8192 Aug 26 04:55 29082005
drwxr-sr-x  2 mythtv mythtv   8192 Aug 24 04:57 30082005
-rw-r--r--  1 mythtv mythtv 362153 Nov  5  2004 guide.xml

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
