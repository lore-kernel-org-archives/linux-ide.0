From: beolach@juno.com
Subject: Re: Filesystem corruption in kernels 2.4.19, 2.4.20, 2.4.21
Date: Thu, 19 Jun 2003 15:08:25 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030619.150825.2296.2.beolach@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from m27.lax.untd.com ([64.136.30.90]:17906 "HELO m27.lax.untd.com")
	by vger.kernel.org with SMTP id S265411AbTFSUyO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2003 16:54:14 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-newbie@vger.kernel.org
Cc: linux-ide@vger.kernel.org

I forgot to mention, on kernel 2.4.18+patch, I have had no problems
at all.

Conway S. Smith

On Thu, 19 Jun 2003 14:47:34 -0600 beolach@juno.com writes:
> I've been having problems with major filesystem corruption on 
> kernels
> 2.4.19, 2.4.20, and 2.4.21.
> I'm pretty sure it's a problem with the driver for the PCI expansion 
> IDE
> controller the drives are on,
> and I've reported this problem to the manufacturer (Promise 
> Technology
> Inc, www.promise.com),
> but I haven't really gotten any help from them.  I've been 
> considering
> sending this to the kernel mailing
> list, but I'm a little in awe of all the hardcore coders there, so 
> I
> figured I'd see if I could get any help
> here first.
> 
> The drive is being controlled by a PCI expansion Ultra133 TX2 card
> (PDC20269 chipset).  It uses
> the pdc202xx driver, with patches for 2.4.18 & 2.4.19; 2.4.20 & 
> 2.4.21
> don't need the patch.  The
> patches were available on www.promise.com, but for some reason 
> they've
> been taken off.  My
> problem is, on 2.4.19+patch, 2.4.20, and 2.4.21, after compiling 
> the
> kernel and rebooting, the first
> time the filesystem is mounted, it works fine. But after that, the
> filesystem becomes corrupted.  It
> does this on ext2, ext3, and reiserfs.  My fat32 partitions (on a
> seperate drive, also on the expansion
> IDE controller) don't exhibit any symptoms at all.  I have attached 
> the
> config & dmesg files for 2.4.18
> (has no problems) and 2.4.21 (major filesystem corruption after 
> first
> mount).  Below is a diagram of
> my system configuration.
> 
> Mainboard: MSI KT3 Ultra (MS-6380E)
> Mainboard chipset: VIA KT333 & VIA VT8233A
> Processor: AMD Athlon XP 2000+ (1.667 GHz)
> Memory: 768 MB PC2100 DDR RAM
> Onboard IDE:
>         Pri Master: LITE-ON LTR-40125S 40x12x48 CD-RW
>         Pri Slave: TOSHIBA DVD-ROM SD-M1502
>         Sec Master: Imation LS-120 Superdisk UHD Floppy
>         Sec Slave: Unused
> Ultra133TX2 PDC20269 BIOS Version 2.20.0.15
>         Pri Master: MAXTOR 6L060J3  LBA  57259MB UDMA6
>                 hda1: fat32 windows c:
>                 hda2: fat32 windows e:
>                 hda3: fat32 windows e:
>                 hda4: fat32 windows f:
>         Pri  Slave: Unused
>         Sec Master: Western Digital WDC WD205AA-00BAA0 LBA 19569MB 
> UDMA4
>                 hdc1: ext3
>                 hdc2: swap
>         Sec Slave: Unused
> 
> Any help resolving this would be appreciated,
> Conway S. Smith

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
