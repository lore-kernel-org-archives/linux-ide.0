From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: siimage.c -serious- error fixed.  Performance/stability issues resolved.
Date: Tue, 2 Dec 2003 20:16:13 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312022016.13725.bzolnier@elka.pw.edu.pl>
References: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43515 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264280AbTLBTOs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Dec 2003 14:14:48 -0500
In-Reply-To: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Ryan Earl <heretic@clanhk.org>
Cc: linux-ide@vger.kernel.org


On Tuesday 02 of December 2003 11:57, Ryan Earl wrote:
> Hello,

Hi,

> Let me preface this by saying I'm new to the list and that I hope this is
> the right place for this message.  I run a production server that utilizes
> the Silicon Image 3112A SerialATA interface and I had ordered 2 WD360GD
> "Raptor" drives to have a cheap RAID1 hot-swap configuration.  After doing
> research and reading back through the kernel lists I saw there was a
> stability issue being worked around by turning the request buffer down to
> 15KBytes from 128KByte.  While this fixed some symptoms to the problem, it
> did not fix the problem and resulted in horrible performance especially in
> terms of CPU utilization.
>
> After reading through the IDE/PCI subsystems on linux, I looked that
> linux/ide/pci/siimage.[c|h] to find and fix what I believe is the reason
> for the stability issues on SI's SATA hardware.  Here's a verbose diff
> from the unpatched=>patch siimage.c driver from 2.4.23_pre8:
>
> *** /usr/src/linux/drivers/ide/pci/siimage.c.orig       Sun Nov 30
> 07:05:59 2003
> --- /usr/src/linux/drivers/ide/pci/siimage.c    Sun Nov 30 07:05:59 2003
> ***************
> *** 265,271 ****
>   static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
>   {
>         ide_hwif_t *hwif        = HWIF(drive);
> !       u32 speedt              = 0;
>         u16 speedp              = 0;
>         unsigned long addr      = siimage_seldev(drive, 0x04);
>         unsigned long tfaddr    = siimage_selreg(hwif, 0x02);
> --- 265,271 ----
>   static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
>   {
>         ide_hwif_t *hwif        = HWIF(drive);
> !       u16 speedt              = 0;    /* was a u32 that clobered over
> the port/addr section of the stack in OUTW */
>         u16 speedp              = 0;
>         unsigned long addr      = siimage_seldev(drive, 0x04);
>         unsigned long tfaddr    = siimage_selreg(hwif, 0x02);
> ***************
> *** 1065,1072 ****
> --- 1065,1075 ----
>         hwif->hwif_data = 0;
>
>         hwif->rqsize = 128;
> +
> + #if defined( SATA_BUGGY )
>         if (is_sata(hwif))
>                 hwif->rqsize = 15;
> + #endif
>
>         if (pci_get_drvdata(dev) == NULL)
>                 return;
>
>
> The crux of the problem was that the on-disk controller was getting
> programmed with erroneous settings.  A 32-bit argument was being passed
> instead of a 16-bit argument to the function referenced by hwif->OUTW,
> thus clobbering the stack.

Good catch but can you verify this?

I.e. if you are using MMIO (MMIO-DMA banner printed by a driver),
copy ide_mm_outw() function from ide-iops.c to siimage.c, rename it,
add printk("%u\n", val) to it and call this function with speedt argument
instead of calling hwif->OUTW().

It is better to change speedt to u16 anyway.

> I've been stress testing this patch for the last 40 hours.  Benchmark
> results have been excellent.  Without the patch, sequential reads and
> writes were using 90% of the CPU, with the patch it's more around 20% on
> average.  Read CPU usage is significantly lower than write usage.  Disk
> throughput also increased 5-7MB/s in sequential read/write access.  I've
> copied around over 1TB of data on this drive with my patch and the request
> buffer set to 128KByte/sec with zero errors.  Without the patch and with
> 128KByte request buffer the harddrive typically becomes unstable within 5
> minutes of usage.

So without "speedt" fix even and with 128kB requests it is unstable
and with fix and 128kB requests it works okay?

> I checked the latest 2.6.0-test11 kernel, and it also has the same error
> as in the 2.4 kernel, however I do not have a 2.6 testbed so I did not
> attempt to patch that kernel for testing.  I was mainly interested in
> cleaning up things for the kernel my production server will upgrade to
> when I install the SATA RAID1 setup.

You can find patch limiting requests to 15kB only for Seagate drives here:
	http://lkml.org/lkml/2003/11/30/54

It is for 2.6.0-test11 but should also apply to 2.4 kernels.

thanks,
--bart

