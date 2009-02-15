From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: SATL support for hdparm?
Date: Sun, 15 Feb 2009 01:06:03 +0100
Message-ID: <20090215000603.GK17914@xi.wantstofly.org>
References: <20090214222114.GI17914@xi.wantstofly.org> <49975A6D.4010608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([80.101.37.227]:41127 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBOAGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:06:06 -0500
Content-Disposition: inline
In-Reply-To: <49975A6D.4010608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

On Sat, Feb 14, 2009 at 06:57:33PM -0500, Mark Lord wrote:

> > I have a bunch of SATA disks hanging off a SAS expander on which I
> > would like to disable APM (using hdparm -B).  This doesn't work as-is,
> > and from reading:
> >
> >	http://smartmontools.sourceforge.net/smartmontools_scsi.html
> >
> > it appears that I'd need to hack hdparm to use the ATA PASS THROUGH
> > SCSI command to make it talk to SATA disks behind a SAS expander, as
> > was already done for smartctl.  Did anyone implement something like
> > this for hdparm yet by any chance?
> 
> It actually does that already.  What version are you trying with?

I tried with 9.10.  Ah yes, now I see that the man page mentions SAT,
but it doesn't appear to be detecting that it needs to do that.


> Grab the latest from sourceforge (9.10 or 9.11) and try again.
> 
> If it still doesn't work with that, then let me know and we'll sort
> it out.

I get this when trying to set -B 254 (in an attempt to turn off head
unload/load -- these are WD drives that do that quite frequently):

	[root@heth hdparm-9.10]# ./hdparm -B 254 /dev/sdb

	/dev/sdb:
	 setting Advanced Power Management level to 0xfe (254)
	 HDIO_DRIVE_CMD failed: Input/output error
	[root@heth hdparm-9.10]# 

I don't see it issuing any SG_IO ioctls with command byte being 0xA1
or 0xA5 -- I don't see it issuing SG_IO at all:

	[...]
	open("/dev/sdb", O_RDONLY|O_NONBLOCK)   = 3
	fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
	mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b9e17076000
	write(1, "\n", 1)                       = 1
	write(1, "/dev/sdb:\n", 10)             = 10
	write(1, " setting Advanced Power Manageme"..., 55) = 55
	ioctl(3, 0x31f, 0x7fff93a336b0)         = -1 EINVAL (Invalid argument)
	dup(2)                                  = 4
	fcntl(4, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
	brk(0)                                  = 0xf97b000
	brk(0xf99c000)                          = 0xf99c000
	fstat(4, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
	mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b9e17077000
	lseek(4, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
	write(4, " HDIO_DRIVE_CMD failed: Invalid "..., 41) = 41
	close(4)                                = 0
	munmap(0x2b9e17077000, 4096)            = 0
	close(3)                                = 0
	exit_group(0)                           = ?
