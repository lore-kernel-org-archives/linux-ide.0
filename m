From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: siimage.c -serious- error fixed.  Performance/stability issues resolved.
Date: Wed, 3 Dec 2003 00:32:25 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312030032.25783.bzolnier@elka.pw.edu.pl>
References: <62929.67.101.15.58.1070362667.squirrel@mail.clanhk.org> <200312022016.13725.bzolnier@elka.pw.edu.pl> <33385.209.163.161.49.1070400815.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28867 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264432AbTLBXax
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Dec 2003 18:30:53 -0500
In-Reply-To: <33385.209.163.161.49.1070400815.squirrel@mail.clanhk.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Ryan Earl <heretic@clanhk.org>
Cc: linux-ide@vger.kernel.org

On Tuesday 02 of December 2003 22:33, Ryan Earl wrote:
> > Good catch but can you verify this?
> >
> > I.e. if you are using MMIO (MMIO-DMA banner printed by a driver),
> > copy ide_mm_outw() function from ide-iops.c to siimage.c, rename it,
> > add printk("%u\n", val) to it and call this function with speedt argument
> > instead of calling hwif->OUTW().
> >
> > It is better to change speedt to u16 anyway.
>
> The 3112 is using memory mapped I/O yes.  I verified by simply putting a
> printk() in the 'if (hwif->mmio) { }' section.  I took it out for the
> diff.  Even if we're not using MMIO, it was still using a 32-bit speedt as
> an argument to pci_write_config_WORD() which is still erroneous.

Okay.

> > So without "speedt" fix even and with 128kB requests it is unstable
> > and with fix and 128kB requests it works okay?
>
> Without the "speedt" fix, a 128KB request buffer causes the hardrive to
> become completely unstable.  In benchmarking it would timeout and give DMA
> errors within 5 minutes of usage.  For my development setup, I was running
> a second non-SATA harddrive with RAID1 across the partitions on the
> Raptor; benchmarks were obviously run on a non-RAID partition.  I had to
> reboot to resync the drives many times after DMA errors.  I have had zero
> issues with the patch installed.

Okay, thanks!

> > You can find patch limiting requests to 15kB only for Seagate drives
> > here: http://lkml.org/lkml/2003/11/30/54
> >
> > It is for 2.6.0-test11 but should also apply to 2.4 kernels.
>
> The 15KB request buffer "fix"--*ahem* workaround--never addressed the real
> issue.  You want to get rid of all the 15KB hoocus-poocus.  All that does
> is kill your disk performance, it never solved the problem, merely made
> your system more stable with the problem still around.  Essentially, you
> should never have that buffer set to 15KB and with this fix all that noise
> should just disappear from the driver/kernel.

No, there is a REAL issue with Seagate SATA drives
(more details in recent discussion on lkml and in lkml archives).

Proper workaround (instead of limiting requests to 15kB) is underway.

> I mean, think about what's happening to OUTW with a 32-bit speedt.  The 16
> most significant bits of speedt are being used as the whole first
> argument--this will always be 0--and the lower order 16-bits of speedt is
> then being used as the upper order 16-bits of the address/port, while the
> upper 16-bits of the real address/port are now the lower 16-bits of the
> argument sent.  The lower order 16-bits of the address/port then get left
> on the stack to cause whatever damage it can down the road.  The driver
> was sending complete nonsense to the on-disk controller.  Though the error
> was only 2 characters long, this belies the severity of its nature.

Yep, this explanaiton makes sense.
It made me wonder why gcc doesn't emit warning for this case...

> I'm currently waiting for a benchmarking script to finish, it's been
> running about 10 hours now.  I setup a script to run tests across varrying
> datasets--from 2G to 8G, 15K to 64K files--with the patched driver with
> 128 and 15 K buffers, and with/without write caching enabled.  I noticed
> wcache was not enabled by default, so I'm trying to gauge its effect on
> performance and stability.  I will post the results when the runs have
> finished.  The performance differential here is incredible.

Okay.

thanks,
--bart

