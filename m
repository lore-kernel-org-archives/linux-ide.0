From: "Lelsie Rhorer" <lrhorer@satx.rr.com>
Subject: Odd RAID failure
Date: Sat, 4 Apr 2009 12:32:03 -0500
Message-ID: <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>
Reply-To: <lrhorer@satx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39371 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZDDRcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 13:32:07 -0400
Received: from Leslie ([68.203.168.150]) by cdptpa-omta01.mail.rr.com
          with ESMTP
          id <20090404173205.GIRT22375.cdptpa-omta01.mail.rr.com@Leslie>
          for <linux-ide@vger.kernel.org>; Sat, 4 Apr 2009 17:32:05 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've been discussing this problem over on the linux-raid list, and one of
the participants suggested I post to this list to see if someone here has
any suggestions.

I'm having a severe problem whose root cause I cannot determine.  I have a
RAID 6 array managed by mdadm running on Debian "Lenny" with a 3.2GHz AMD
Athlon 64 x 2 processor and 4G of RAM.  The kernel is 2.6.26-1-amd64.  There
are ten 1 Terabyte SATA drives, unpartitioned, fully allocated to the
/dev/md0 device. The drive are served by 3 Silicon Image SATA port
multipliers and a Silicon Image 4 port eSATA controller.  The /dev/md0
device is also unpartitioned, and all 8T of active space is formatted as a
single Reiserfs file system.  The entire volume is mounted to /RAID.
Various directories on the volume are shared using both NFS and SAMBA.

Performance of the RAID system is very good.  The array can read and write
at over 450 Mbps, and I don't know if the limit is the array itself or the
network, but since the performance is more than adequate I really am not
concerned which is the case.

The issue is the entire array will occasionally pause completely for about
40 seconds when a file is created.  This does not always happen, but the
situation is easily reproducible.  The frequency at which the symptom occurs
seems to be related to the transfer load on the array.  If no other
transfers are in process, then the failure seems somewhat more rare, perhaps
accompanying less than 1 file creation in 10..  During heavy file transfer
activity, sometimes the system halts with every other file creation.
Although I have observed many dozens of these events, I have never once
observed it to happen except when a file creation occurs. 
Reading and writing existing files never triggers the event, although any
read or write occurring during the event is halted for the duration. 
(There is one cron jog which runs every half-hour that creates a tiny file;
this is the most common failure vector.)  There are other drives formatted
with other file systems on the machine, but the issue has never been seen on
any of the other drives.  When the array runs its regularly scheduled health
check, the problem is much worse.  Not only does it lock up with almost
every single file creation, but the lock-up time is much longer - sometimes
in excess of 2 minutes.

Transfers via Linux based utilities (ftp, NFS, cp, mv, rsync, etc) all
recover after the event, but SAMBA based transfers frequently fail, both
reads and writes.  According to iostat, the writes to all 10 drives and to
the array halt abruptly and completely, and reads from 5 of the drives stop
completely, but 5 of the drives still show a dribble of reads happening.  It
is always the same 5 drives.

