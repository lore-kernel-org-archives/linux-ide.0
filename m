From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Tue, 29 Aug 2006 11:39:57 +0900
Message-ID: <44F3A8FD.6090108@gmail.com>
References: <20060828230132.GB20189@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:3522 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932109AbWH2CkF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 22:40:05 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1175065nzf
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 19:40:05 -0700 (PDT)
In-Reply-To: <20060828230132.GB20189@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: linux-ide@vger.kernel.org

Hello,

Derek Taubert wrote:
> Greetings!
> 
> I'm using a 2.6.17.4 kernel (straight from kernel.org) patched with
> libata-tj-stable-2.6.17.4-20060710 in an effort to make use of an external
> drive bay with a Silicon Image port multipler and a bunch of SATA/PATA
> drives.  For the most part, it's a success (more below) but the write
> performance that I'm seeing to a new Seagate 750GB drive (with NCQ) is
> terrible (on the order of 1.2MBytes/sec).
> 
> The host is an old Toshiba laptop (PIIX4 based) with a 550MHz Celeron
> processor.  The SATA host interface is a PCMCIA based Silicon Image 3124
> chip plugged into the Yenta PCMCIA controller.  A tulip based Linksys
> 10/100 card takes up the other slot.  From dmesg:

Hah... interesting setup.

(dmesg snipped, all look good)

> What works:
> 
> 1) Read performance to all 4 drives is ok (40-50 MBytes/sec as reported
>    by iostat) and stable.  I've hammered a read-only software RAID5 spread
>    across the last 3 drives with no problem.
> 2) "smartctl -d ata -a" works nicely to all 4 drives.
> 3) hdparm -S makes the drives spin down when idle as expected.
> 4) Hotplug seems to work quite well.  I'm even able to power down and
>    remove a drive from the port multiplier while the other 3 are reading
>    data (during a "e2fsck -f -n /dev/md0").

Good.

> What doesn't work so well:
> 
> 1) Writing to sda1.
> 
> # dd if=/dev/zero of=/dev/sda1 count=4M
> <ctrl-c, then wait 30 seconds>
> 264205+0 records in
> 264204+0 records out
> 135272448 bytes (135 MB) copied, 111.373 seconds, 1.2 MB/s
> 
> From iostat -k 10:
> Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
> sda            2428.64      2422.46       667.66      24273       6690
> sda              36.84        23.72      1667.87        237      16662
> sda            2440.60      2434.90       616.00      24349       6160
> The read rate is curious (should be 0)...
> 
> Top shows 1% user, 3% system, 93% wait.

It seems some kind of read IO is in progress.  Can you repeat the test 
on an unused/idle (iostat -k 10 shows all zeros...) drive?  The above 
result actually looks good if you consider both read and write sides. 
The result doesn't seem to indicate any problem in libata or any storage 
related kernel subsystem.  I would track down the reader first.

> If I "cat /proc/scsi/sg/devices" during this test, the next to last column
> seems to indicate that the queue fills up and pretty much stays that way:
> 
> # cat /proc/scsi/sg/devices
> 0       0       0       0       0       1       31      0       1
> 0       0       1       0       0       1       1       0       1
> 0       0       2       0       0       1       1       0       1
> 0       0       3       0       0       1       1       0       1
> # cat /proc/scsi/sg/devices
> 0       0       0       0       0       1       31      29      1
> 0       0       1       0       0       1       1       0       1
> 0       0       2       0       0       1       1       1       1
> 0       0       3       0       0       1       1       1       1
> # cat /proc/scsi/sg/devices
> 0       0       0       0       0       1       31      31      1
> 0       0       1       0       0       1       1       0       1
> 0       0       2       0       0       1       1       0       1
> 0       0       3       0       0       1       1       0       1
> # cat /proc/scsi/sg/devices
> 0       0       0       0       0       1       31      30      1
> 0       0       1       0       0       1       1       0       1
> 0       0       2       0       0       1       1       1       1
> 0       0       3       0       0       1       1       0       1

This looks okay too considering the write queue is full.

> 2) hdparm -C for all 4 drives always shows "drive state is:  standby"
>    even when I'm certain that the drives are active.

hdparm -C says the same thing for my drive.  I think it's safe to 
ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in 
HDIO ioctl implementation in libata.

> I'd really like some assistance debugging the write performance issue.
> The "hdparm -C" issue would be gravy...

Please track down the reader.

-- 
tejun
