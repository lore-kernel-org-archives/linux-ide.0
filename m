From: Tim Small <tim@buttersideup.com>
Subject: Re: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 12:49:30 +0100
Message-ID: <4BF521CA.7080503@buttersideup.com>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Buehl, Reiner" <reiner.buehl@hp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Buehl, Reiner wrote:
> The two disks used in the RAID1 md device are both Seagate ST31000528AS that show no errors in long and short SMART test and Seatools. Memtest shows no memory problems.


Have you tried:

echo 'check' > /sys/block/md<whatever>/md/sync_action

... that should report discrepancies between the two sides of the mirror
...  Unfortunately, I don't think it reports which LBAs, but you could
find this by hand using dd and md5sum or whatever.  After that, if you
do have discrepancies, then you can investigate what form they take by
comparing the blocks from the individual block devices, and viewing them
in a hex editor etc. etc.



Tim.
