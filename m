From: "Ryan Earl" <heretic@clanhk.org>
Subject: siimage.c -serious- error fixed.  Performance/stability issues
     resolved.
Date: Tue, 2 Dec 2003 04:57:47 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:46795 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S261868AbTLBLBu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2003 06:01:50 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Let me preface this by saying I'm new to the list and that I hope this is
the right place for this message.  I run a production server that utilizes
the Silicon Image 3112A SerialATA interface and I had ordered 2 WD360GD
"Raptor" drives to have a cheap RAID1 hot-swap configuration.  After doing
research and reading back through the kernel lists I saw there was a
stability issue being worked around by turning the request buffer down to
15KBytes from 128KByte.  While this fixed some symptoms to the problem, it
did not fix the problem and resulted in horrible performance especially in
terms of CPU utilization.

After reading through the IDE/PCI subsystems on linux, I looked that
linux/ide/pci/siimage.[c|h] to find and fix what I believe is the reason
for the stability issues on SI's SATA hardware.  Here's a verbose diff
from the unpatched=>patch siimage.c driver from 2.4.23_pre8:

*** /usr/src/linux/drivers/ide/pci/siimage.c.orig       Sun Nov 30
07:05:59 2003
--- /usr/src/linux/drivers/ide/pci/siimage.c    Sun Nov 30 07:05:59 2003
***************
*** 265,271 ****
  static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
  {
        ide_hwif_t *hwif        = HWIF(drive);
!       u32 speedt              = 0;
        u16 speedp              = 0;
        unsigned long addr      = siimage_seldev(drive, 0x04);
        unsigned long tfaddr    = siimage_selreg(hwif, 0x02);
--- 265,271 ----
  static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
  {
        ide_hwif_t *hwif        = HWIF(drive);
!       u16 speedt              = 0;    /* was a u32 that clobered over
the port/addr section of the stack in OUTW */
        u16 speedp              = 0;
        unsigned long addr      = siimage_seldev(drive, 0x04);
        unsigned long tfaddr    = siimage_selreg(hwif, 0x02);
***************
*** 1065,1072 ****
--- 1065,1075 ----
        hwif->hwif_data = 0;

        hwif->rqsize = 128;
+
+ #if defined( SATA_BUGGY )
        if (is_sata(hwif))
                hwif->rqsize = 15;
+ #endif

        if (pci_get_drvdata(dev) == NULL)
                return;


The crux of the problem was that the on-disk controller was getting
programmed with erroneous settings.  A 32-bit argument was being passed
instead of a 16-bit argument to the function referenced by hwif->OUTW,
thus clobbering the stack.

I've been stress testing this patch for the last 40 hours.  Benchmark
results have been excellent.  Without the patch, sequential reads and
writes were using 90% of the CPU, with the patch it's more around 20% on
average.  Read CPU usage is significantly lower than write usage.  Disk
throughput also increased 5-7MB/s in sequential read/write access.  I've
copied around over 1TB of data on this drive with my patch and the request
buffer set to 128KByte/sec with zero errors.  Without the patch and with
128KByte request buffer the harddrive typically becomes unstable within 5
minutes of usage.

Here are some preliminary benchmarks with bonnie++:

name,file_size,putc,putc_cpu,put_block,put_block_cpu,rewrite,rewrite_cpu,getc,getc_cpu,get_block,get_block_cpu,seeks,seeks_cpu,num_files,seq_create,seq_create_cpu,seq_stat,seq_stat_cpu,seq_del,seq_del_cpu,ran_create,ran_create_cpu,ran_stat,ran_stat_cpu,ran_del,ran_del_cpu
aeryn,2G,13394,98,44280,29,20448,8,18897,88,42106,11,206.9,0,16,19359,94,+++++,+++,18830,98,19631,99,+++++,+++,17084,100
aeryn,2G,13426,98,41892,28,19254,7,19021,88,39806,10,203.8,0,16,20929,99,+++++,+++,16702,91,20550,100,+++++,+++,16454,100
aeryn,2G,13491,99,41469,28,17846,7,18908,88,37610,9,204.0,0,16,21461,99,+++++,+++,18478,99,20609,100,+++++,+++,15858,95
aeryn,2G,13285,97,35673,23,16948,7,18934,88,34985,8,197.6,0,16,20864,96,+++++,+++,18135,100,20712,101,+++++,+++,16243,100
aeryn,2G,12428,91,52800,35,21584,9,18974,89,45868,12,191.3,0,16,21298,100,+++++,+++,15746,86,20526,100,+++++,+++,16347,100
aeryn,2G,13464,99,43526,29,20138,8,18978,88,42060,12,202.2,0,16,21233,99,+++++,+++,18045,100,19158,93,+++++,+++,16182,100
aeryn,2G,13170,97,42420,28,19145,7,19044,89,39721,10,209.8,0,16,20469,96,+++++,+++,18263,99,20636,100,+++++,+++,16327,99
aeryn,2G,13263,97,39844,26,17376,7,18844,88,36047,10,201.5,0,16,21212,99,+++++,+++,18221,100,20513,100,+++++,+++,14119,87
aeryn,2G,13087,96,38054,26,16139,6,18797,88,33860,8,197.0,0,16,20503,97,+++++,+++,18021,100,20281,99,+++++,+++,16120,99
aeryn,2G,12632,92,51055,34,20976,8,18841,88,45228,12,172.1,0,16,21476,100,+++++,+++,18446,100,20225,96,+++++,+++,15075,92

I'm getting disk throughput within 5% of the manufactures claim, which I
feel is reasonable considering filesystem overhead and what not.  This is
on ReiserFS 3.6.  There is room I'm sure to reduce CPU overhead more, but
I think that's a good thing to do with 2.6. Hopefully libata will take
care of that.

I checked the latest 2.6.0-test11 kernel, and it also has the same error
as in the 2.4 kernel, however I do not have a 2.6 testbed so I did not
attempt to patch that kernel for testing.  I was mainly interested in
cleaning up things for the kernel my production server will upgrade to
when I install the SATA RAID1 setup.

Cheers,
J. Ryan Earl
