From: David Wuertele <dave-gnus@bfnet.com>
Subject: flash as hda causes 2.4.18 to hang in
 grok_partitions()...add_to_page_cache_unique()
Date: Mon, 17 Mar 2003 15:02:46 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3d6kpha09.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 18v3jG-0008FD-00
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2003 00:09:14 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kernelnewbies@nl.linux.org

I've got a mipsel linux 2.4.18 system that has a compact flash IDE
disk as hda.  For some reason, in grok_partitions, the kernel goes
bye-bye.  I've traced it as far as read_page_cache().

The console prints this:

  ide0 at 0x2200-0x2207,0x220a on irq 3
  config_drive_xfer_rate for drive hda (0)
  hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32, DMA
  Partition check:
   /dev/ide/host0/bus0/target0/lun0:

Then hangs.  If I use KGDB to trace the kernel to that point, and do a
backtrace, here's what I see:

  #0  add_to_page_cache_unique (page=0x81042840, mapping=0x810b7520, offset=0, hash=0x8109df5c)
      at /mipsel-linux/include/asm/atomic.h:133
  #1  0x80133d8c in read_cache_page (mapping=0x810b7520, index=0, filler=0x8014b2d4 <blkdev_readpage>, data=0x0)
      at filemap.c:2780
  #2  0x8016b83c in read_dev_sector (bdev=0xffffcfe1, n=2165011744, p=0x803b9dd0) at check.c:433
  #3  0x8016bc98 in handle_ide_mess (bdev=0x810a2120) at msdos.c:485
  #4  0x8016bf18 in msdos_partition (hd=0x803b53e0, bdev=0x810a2120, first_sector=0, 
      first_part_minor=-2130059428) at msdos.c:555
  #5  0x8016b114 in check_partition (hd=0x803b53e0, dev=768, first_part_minor=1) at check.c:270
  #6  0x8016b77c in grok_partitions (dev=0x803b53e0, drive=-2130042592, minors=64, size=250880) at check.c:415
  #7  0x8016b644 in register_disk (gdev=0x1, dev=8480, minors=0, ops=0x8109df5c, size=250880) at check.c:390
  #8  0x8020b79c in ide_geninit (hwif=0x803a3f14) at ide.c:666
  #9  0x80211ae4 in ide_init () at ide.c:3840
  #10 0x801ffd00 in blk_dev_init () at ll_rw_blk.c:1159
  #11 0x80200aa4 in device_init () at genhd.c:184
  #12 0x80108a8c in do_initcalls () at init/main.c:676
  #13 0x80108ae4 in do_basic_setup () at init/main.c:760
  #14 0x80108ca0 in init (unused=0x3f) at init/main.c:830
  #15 0x80109654 in kernel_thread (fn=0x80108c90 <init>, arg=0x0, flags=8457984) at process.c:207

Any suggestions?

Dave

