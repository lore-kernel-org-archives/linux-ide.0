From: Felix Miata <mrmazda@ij.net>
Subject: Re: Bart's efforts?
Date: Sat, 03 Nov 2007 11:39:16 -0400
Message-ID: <472C9624.104@ij.net>
References: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com> <20071103141022.7a6c0209@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fall-pradero.atl.sa.earthlink.net ([207.69.195.104]:47100 "EHLO
	fall-pradero.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459AbXKCPyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 11:54:16 -0400
Received: from pop-knobcone.atl.sa.earthlink.net ([207.69.195.64])
	by fall-pradero.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1IoLKC-0001su-5B
	for linux-ide@vger.kernel.org; Sat, 03 Nov 2007 11:54:16 -0400
Received: from user-142grmk.cable.mindspring.com ([72.40.110.212] helo=[192.168.0.51])
	by pop-knobcone.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1IoL5g-0000BB-00
	for linux-ide@vger.kernel.org; Sat, 03 Nov 2007 11:39:16 -0400
In-Reply-To: <20071103141022.7a6c0209@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2007/11/03 14:10 (GMT) Alan Cox apparently typed:

> I don't think there is anything useful in old IDE that isn't in the new.

You mean besides being able to access all existing disk partitions? Google
can show you I'm not the only multiboot upgrader with far more than 14
filesystems per disk. The standard drivers should be able to provide access
to every standard partition fdisk/cfdisk/sfdisk or any other conforming
partitioning tool is able to create. LVM should not be prerequisite to using
SATA for those who need many low level logical disk subdivisions.

Disk /dev/hda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1          13      104391   17  Hidden HPFS/NTFS
/dev/hda2   *          14          14        8032+   a  OS/2 Boot Manager
/dev/hda3              15          46      257040    6  FAT16
/dev/hda4              48       30401   243818505    5  Extended
/dev/hda5              48          73      208813+  83  Linux
/dev/hda6              74         188      923706   82  Linux swap / Solaris
/dev/hda7             189         800     4915858+  83  Linux
/dev/hda8            1108        1108        8001    1  FAT12
/dev/hda9            1109        1140      257008+   6  FAT16
/dev/hda10           1142        1243      819283+   7  HPFS/NTFS
/dev/hda11           1269        1523     2048256    7  HPFS/NTFS
/dev/hda12           1575        1693      955836    7  HPFS/NTFS
/dev/hda13           1694        2012     2562336    7  HPFS/NTFS
/dev/hda14           2014        2217     1638598+  83  Linux
/dev/hda15           2218        2568     2819376   83  Linux
/dev/hda16           2569        3486     7373803+  83  Linux
/dev/hda17           3487        4379     7172991   83  Linux
/dev/hda18           4380        4409      240943+  83  Linux
/dev/hda19           4410        4549     1124518+  83  Linux
/dev/hda20           4550        5187     5124703+  83  Linux
/dev/hda21          18234       18845     4915858+  83  Linux
/dev/hda22          18846       19457     4915858+  83  Linux
/dev/hda23          20383       20391       72261   83  Linux
/dev/hda24          20392       30401    80405293+  83  Linux

> However libata PATA support is not all new code, its built on and from
> the old IDE driver code. Similarly there is stuff recently going on in
> drivers/ide that is then going into drivers/ata (eg the IVB blacklists).

> The big issue with drivers/ide is the core code which simply can't cope
> with SMP or modern hardware designs.   don't consider drivers/ide
> anything but "legacy" but lots of older systems use it and its important
> it stays maintained. Bart is doing whats actually a pretty thankless job
> - working on maintaining stuff for the short term knowing it has no real
> future.
-- 
"   A patriot without religion . . . is as great a
paradox, as an honest man without the fear of God."
	                             John Adams

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://mrmazda.no-ip.com/
