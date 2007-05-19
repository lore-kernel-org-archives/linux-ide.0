From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] libata:
	remove	libata.spindown_compat
Date: Sat, 19 May 2007 13:06:19 +0200
Message-ID: <1179572779.23670.13.camel@localhost.localdomain>
References: <464C6A0E.7020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pkg-sysvinit-devel-bounces+gldds-pkg-sysvinit-devel=m.gmane.org@lists.alioth.debian.org>
In-Reply-To: <464C6A0E.7020601@gmail.com>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-sysvinit-devel>,
	<mailto:pkg-sysvinit-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-sysvinit-devel>
List-Post: <mailto:pkg-sysvinit-devel@lists.alioth.debian.org>
List-Help: <mailto:pkg-sysvinit-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-sysvinit-devel>,
	<mailto:pkg-sysvinit-devel-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-sysvinit-devel-bounces+gldds-pkg-sysvinit-devel=m.gmane.org@lists.alioth.debian.org
Errors-To: pkg-sysvinit-devel-bounces+gldds-pkg-sysvinit-devel=m.gmane.org@lists.alioth.debian.org
To: Tejun Heo <htejun@gmail.com>
Cc: pkg-sysvinit-devel@lists.alioth.debian.org, Chuck Ebbert <cebbert@redhat.com>, Jeff Garzik <jeff@garzik.org>, Francesco Pretto <ceztko@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hmh@hmh.eng.br, Daniel Drake <dsd@gentoo.org>
List-Id: linux-ide@vger.kernel.org

On Thu, 2007-05-17 at 16:43 +0200, Tejun Heo wrote:
> 
> I'll attach the updated version of http://linux-ata.org/shutdown.html
> as a reply to this mail.

It says:

>When a disk is powered off, it needs to flush its write cache and then
>unload its heads so that they don't crash onto the recording surfaces.
>Most disks have mechanical mechanism to unload its heads even when
>power is abruptly cut. This is usually called emergency unload and
>causes popping sound on some disks and may have negative effect on the
>lifetime of the disk, so the operating system must tell the disks to
>unload the heads prior to shutting the system down.

>In ATA, this is achieved by issuing FLUSH CACHE followed by STANDBYNOW
>and the IDE drivers (drivers/ide/*) have always issued the sequence
>prior to powering off. libata uses SCSI sd driver as its high level
>disk driver and the sd driver, unfortunately, issues only the cache
>flush command during shutdown. This is mainly because SCSI disks can be
>accessed by multiple initiators (hosts) and spinning down disks because
>one initiator goes down can disturb others. Because of this
>implementation detail, libata drivers up to kernel version 2.6.21 don't
>issue the STANDBYNOW command before powering off.

This is not quite correct.

The reason halt(8) spins down IDE disks is that, way back when (november
2001 I guess, from the changelog), the IDE drivers did not flush the
cache on poweroff. The result was that on some machines, poweroff was so
fast that the power of the drive got turned off while it still had some
unflushed data in the write-cache, resulting in filesystem corruption.
This problem did not exist with SCSI, apparently.

To fix this issue, halt(8) started issueing WIN_STANDBYNOW1 (0xE0) and
WIN_STANDBYNOW2 (0x94) ioctls before halt and poweroff, as that was more
reliable than "flush cache" and the effect was the same.

Mike.
