From: Marc MERLIN <marc@merlins.org>
Subject: Re: M2/NVM vs M2/Sata vs SATA/6GB benchmarks
Date: Wed, 9 Mar 2016 13:50:40 -0800
Message-ID: <20160309215040.GI14112@merlins.org>
References: <20160214031333.GA20879@merlins.org>
 <20160214093258.GC2590@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:48632 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcCIVvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2016 16:51:01 -0500
Content-Disposition: inline
In-Reply-To: <20160214093258.GC2590@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

For now I've posted this here
http://marc.merlins.org/perso/linux/post_2016-02-22_Thinkpad-P70-NVME-vs-M2-Sata-vs-2_5inch-Sata-SSD.html
along with a few pictures of the thinkpad P70

I'm still not sure why NVMe is slower than Sata when going through the
block cache, but oh well, the rest seems to be working well enough for
now.

Marc

> On Sat, Feb 13, 2016 at 07:13:33PM -0800, Marc MERLIN wrote:
> > Hi Matthew,
> > 
> > I didn't find a list for NVMe, I'll Cc linux-ide in case this is useful
> > to others.
> > 
> > I just got a Thinkpad P70 skylake laptop and thought I'd try 3 SSDs:
> > NVMe/M2 vs Sata/M2 vs Sata/6GB.
> > I'm not a benchmarking filesystem expert, so my apologies if I made some
> > stupid choices, but hopefully the benchmarks are still useful.
> > 
> > I'll give the conclusions first. The buffer cache issue with NVMe is weird,
> > maybe there is a non default setting I need to tweak?
> > 
> > a) NVMe is faster for big contiguous I/O, even through dmcrypt
> > b) M2 NVMe and M2 sata do not seem to go through buffer cache for writes, but SATA/6GB does
> > c) When using buffer cache, SATA/6GB beats NVMe/M2 and SATA/M2 by a lot on block reads. Why?
> > d) for random I/O, NVMe is up to 50% faster, and faster with ext4 than btrfs
> > e) Encrypted NVMe is a bit faster than non encrypted Sata/M2
> > f) At $328 for 512GB M2/NVMe vs $168 for 500GB M2/Sata, unless you're doing big contiguous I/O, the 2x price difference is hard to justify, cached I/O and random I/O are not significantly faster on NVMe.
> > 
> > 
> > 
> > 3 SSDs:
> > 1) M2/SATA Samsung 850 EVO 500 GB M.2 3.5-Inch SSD (MZ-N5E500BW) 33c/GB
> > 
> > 2) M2/NVMe: Samsung 950 PRO -Series 512GB PCIe NVMe - M.2 Internal SSD 2-Inch MZ-V5P512BW 64c/GB
> > 70:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a802 (rev 01)
> > 
> > 3) SATA6G: Samsung 850 EVO 2 TB 2.5-Inch SATA III Internal SSD (MZ-75E2T0B/AM) 30c/GB
> > 
> > For price comparison
> > Seagate 2TB Laptop HDD SATA 6Gb/s 32MB Cache 2.5-Inch Internal Bare Drive (ST2000LM003) 4.6c/GB
> > 
> > Laptop: Skylake Lenovo Thinkpad P70
> > Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz x 8 (4 cores HT)
> > 
> > Filesystem: btrfs on top of 
> > cryptsetup luksFormat --align-payload=8192 -s 256 -c aes-xts-plain64 /dev/device
> > ddd test: sync; dd if=/mnt/ram/file of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=100M
> > dd0 test: sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 
> > Summary: 
> > 0) NVMe only really looks faster on big block sequential read/write (indeed 4X read, 2X write).
> >    On Random I/O, it's no faster. Other overheads kill its performance advantage.
> > 1) For Cached I/O NVMe seems slowed down by dmcrypt in hdparm/ioz ranread/write whereas M2/Sata is not
> > 2) 2TB Sata 6GB SSD is faster for read/write encrypted than NVMe is non encrypted (except hdparm)
> > 3) iozone through block cache is faster on M2/SATA than M2/NVMe, weird
> > 4) iozone through block cache is much faster for everything on Sata6G, also weird
> > 5) iozone direct I/O shows NVMe is fastest (by 50% only) and external SATA just a bit faster than M2/Sata
> > 6) when using dmcrypt, NVMe is only marginally faster in iozone than Sata/M2 or Sata/6G
> > 7) kernel build speed is same on SATA/M2 and NVMe/M2, encrypted or not, but SATA6G is 10% faster (probably the same effect that block cache works better on SATA/6G than SATA/M2 or NVMe/M2)
> > 8) ext4 does better on iozone -I (directIO) than btrfs, 2x as fast on random read for NVMe
> > 
> > 
> > 
> > 		SATA/M2 dmcrypt	SATA/M2		NVMe dmcrypt	NVMe		SATA6GB/dmcrypt
> > hdparm -t	 534MB/s	 517MB/s	1307MB/s	2140MB/s	 534MB/s
> > ddd 10GB read	 550MB/s	 560MB/s	2000MB/s	2400MB/s	 550MB/s
> > ddd 10GB write	 500MB/s	 503MB/s	1300MB/s	1200MB/s	 506MB/s
> > 
> > dd with /dev/zero hits optimizations that actually penalize NVMe:
> > dd0 10GB read	   7GB/s	 6.7GB/s	 2.3GB/s	 4.4GB/s	 6.6GB/s
> > dd0 10GB write	 495MB/s	 503MB/s	 1.3GB/s	 1.3GB/s	 2.0GB/s
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2 (cache makes Sata6G faster than M2, weird):
> > ioz read 4KB	1760MB/s	1790MB/s	 675MB/s	 766MB/s	7863MB/s
> > ioz write 4KB	 268MB/s	 298MB/s	 295MB/s	 291MB/s	 777MB/s
> > ioz ranread4KB	5535MB/s	7392MB/s	3185MB/s	7261MB/s	7892MB/s
> > ioz ranwrite4KB	 288MB/s	 329MB/s	 205MB/s	 381MB/s	 796MB/s
> > 
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2 (direct IO):
> > 		SATA/M2 dmcrypt	 SATA/M2	 NVMe dmcrypt	 NVMe		 SATA6GB
> > 										 dmcrypt notcrypted
> > 		 btrfs		 btrfs   ext4	 btrfs		 btrfs   ext4	 btrfs     ext4
> > ioz read 4KB	 255MB/s	 303MB/s 408MB/s 303MB/s	 396MB/s 562MB/s 310MB/s 379MB/s
> > ioz write 4KB	 195MB/s	 238MB/s 344MB/s 257MB/s	 358MB/s 361MB/s 233MB/s 365MB/s
> > ioz ranread4KB	 305MB/s	 351MB/s 482MB/s 476MB/s	 699MB/s1434MB/s 309MB/s 475MB/s
> > ioz ranwrite4KB	 265MB/s	 223MB/s 392MB/s 260MB/s	 217MB/s 315MB/s 254MB/s 366MB/s
> > 
> > 
> > Details of each test, per type of drive;
> > ================================================================================
> > saruman M2 SATA 512GB encrypted btrfs
> > 
> > saruman:/tmp# hdparm -t /dev/mapper/cryptroot
> >  Timing buffered disk reads: 1604 MB in  3.00 seconds = 534.03 MB/sec
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2:
> >                                                               random    random
> >               kB  reclen    write  rewrite    read    reread    read     write
> >             4096       4   257076   281089  1761711  6094733  6066754   290373
> >             4096     512   277108   295167  1588844  8426437 11128258   318731
> >             4096    4096   268940   308248  1760087  8062616  8377131   320802
> > 
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4    38626    45227   102236   111141    30936    64317
> >             4096     512   138467   128878   134674   137832   140067   126248
> >             4096    4096   195439   273100   255379   307300   305605   265093
> > 
> > 
> > saruman:/mnt/mnt# sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 10485760000 bytes (10 GB) copied, 21.1761 s, 495 MB/s
> > 10485760000 bytes (10 GB) copied, 1.49373 s, 7.0 GB/s
> > 
> > kernel 4.4.1 make -j8:
> > real    17m54.712s
> > user    126m26.620s
> > sys     6m21.948s
> > 
> > btrfs send/receive encrypted partition to non encrypted, 87GB: 10mn30
> > 
> > saruman M2 SATA non encrypted btrfs
> > -----------------------------------
> > saruman:/mnt/mnt4# hdparm -t /dev/sdc4
> > /dev/sdc4:
> >  Timing buffered disk reads: 1554 MB in  3.00 seconds = 517.93 MB/sec
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2:
> >                                                               random    random
> >               kB  reclen    write  rewrite    read    reread    read     write
> >             4096       4   285020   297565  1739944  7434579  6605595   305785
> >             4096     512   310937   336617  1298278  3703511  5483860   299416
> >             4096    4096   298433   317101  1790911  7392988  7434579   337476
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4    47219    93497   118900   126065    39160    86462
> >             4096     512   214381   213388   194307   209215   206951   209289
> >             4096    4096   238792   221839   303768   352951   351342   223618
> > ext4 iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4   119524   146035   150173   159105    53090   140697
> >             4096     512   358954   354810   366466   423088   419760   375542
> >             4096    4096   344087   398828   408259   478337   482569   392487
> > 
> > saruman:/mnt/mnt3#  sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 10485760000 bytes (10 GB) copied, 20.8537 s, 503 MB/s
> > 10485760000 bytes (10 GB) copied, 1.55651 s, 6.7 GB/s
> > 
> > kernel 4.4.1 make -j8:
> > real    17m55.612s
> > user    126m31.952s
> > sys     6m27.452s
> > 
> > 
> > ********************************************************************************
> > saruman M2 NVMe 512GB encrypted btrfs
> > 
> > saruman:/tmp# hdparm -t /dev/mapper/cryptroot2
> > /dev/mapper/cryptroot2:
> >  Timing buffered disk reads: 3924 MB in  3.00 seconds = 1307.56 MB/sec
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2:
> >                                                               random    random
> >               kB  reclen    write  rewrite    read    reread    read     write
> >             4096       4   284205   341651   742181  6195843  6178018   341101
> >             4096     512   314351   319573   864883  8865630  8902382   384993
> >             4096    4096   295741   201042   675234  3281854  3185110   205974
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4    80042    83160   122616   127129    41421    53963
> >             4096     512   168713   153333   167710   209923   198123   168026
> >             4096    4096   257968   258566   303023   490828   476440   260014
> > 
> > 
> > saruman:/mnt/mnt2# sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 10485760000 bytes (10 GB) copied, 8.01494 s, 1.3 GB/s
> > 10485760000 bytes (10 GB) copied, 4.63397 s, 2.3 GB/s
> > 
> > kernel 4.4.1 make -j8:
> > real    17m57.513s
> > user    126m58.360s
> > sys     6m25.164s
> > 
> > btrfs send/receive encrypted partition to non encrypted, 87GB: 7mn
> > (33% faster than Sata M2)
> > 
> > saruman M2 NVMe non encrypted btrfs
> > -----------------------------------
> > saruman:/mnt/mnt4# hdparm -t /dev/nvme0n1p4
> > /dev/nvme0n1p4:
> >  Timing buffered disk reads: 6422 MB in  3.00 seconds = 2140.38 MB/sec
> > 
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2:
> >                                                               random    random
> >               kB  reclen    write  rewrite    read    reread    read     write
> >             4096       4   274808   271851   684271  2634219  2280673   177630
> >             4096     512   290191   336755   668196  3362795  4039655   184779
> >             4096    4096   291427   340345   766588  7355007  7261741   381768
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4    94814   117116   147645   159695    44075   108039
> >             4096     512   271130   267800   239969   325933   301841   271062
> >             4096    4096   358602   275933   396591   719099   699939   217665
> > ext4 iozone -I -e -a -s 4096 -i 0 -i 1 -i 2:
> >             4096       4   107281   200735   205900   263035    54832   124219
> >             4096     512   537478   374641   525060  1173664  1139338   558807
> >             4096    4096   361545   526137   562632  1483477  1434069   315883
> > 
> > saruman:/mnt/mnt4# sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 10485760000 bytes (10 GB) copied, 7.90653 s, 1.3 GB/s
> > 10485760000 bytes (10 GB) copied, 2.35863 s, 4.4 GB/s
> > 
> > kernel 4.4.1 make -j8:
> > real    17m54.221s
> > user    126m46.264s
> > sys     6m10.592s
> > 
> > 
> > ********************************************************************************
> > saruman Samsung Evo 850 2TB SSD encrypted btrfs
> > 
> > hdparm -t
> >  Timing buffered disk reads: 1606 MB in  3.00 seconds = 534.87 MB/sec
> > 
> > iozone -e -a -s 4096 -i 0 -i 1 -i 2:
> >                                                               random    random
> >               kB  reclen    write  rewrite    read    reread    read     write
> >             4096       4   513924   738957  8586475  9144037  8017464   697665
> >             4096     512   772100   820362  9287391 10136778 10586522   840551
> >             4096    4096   719099   777517  7863339  8047509  7892238   796108
> > 
> > iozone -I -e -a -s 4096 -i 0 -i 1 -i 2
> >             4096       4    76626    47961    92886    80947    36063    63788
> >             4096     512   135087   138998   143127   150981   144393   132219
> >             4096    4096   233245   234058   310797   311552   309855   254080
> > 
> > ext4 iozone -I -e -a -s 4096 -i 0 -i 1 -i 2 (unencrypted)
> >             4096       4   118013   141212   130575   111534    42343   138654
> >             4096     512   336347   312192   332847   414404   424542   342707
> >             4096    4096   365227   364638   379298   484160   475122   366536
> > 
> > 
> > saruman:/tmp# sync; dd if=/dev/zero of=file bs=100M count=100 conv=fdatasync; dd if=file of=/dev/null bs=1M
> > 10485760000 bytes (10 GB) copied, 5.23919 s, 2.0 GB/s
> > 10485760000 bytes (10 GB) copied, 1.58287 s, 6.6 GB/s
> > 
> > 
> > kernel 4.4.1 make -j8:
> > real    16m4.305s
> > user    104m0.816s
> > sys     7m2.832s
> > 
> > 
> > -- 
> > "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
> > Microsoft is to operating systems ....
> >                                       .... what McDonalds is to gourmet cooking
> > Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
