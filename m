From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: SATL support for hdparm?
Date: Sun, 15 Feb 2009 01:13:55 +0100
Message-ID: <20090215001355.GL17914@xi.wantstofly.org>
References: <20090214222114.GI17914@xi.wantstofly.org> <49975A6D.4010608@pobox.com> <20090215000603.GK17914@xi.wantstofly.org> <49975D28.4050101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([80.101.37.227]:38074 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZBOAN5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:13:57 -0500
Content-Disposition: inline
In-Reply-To: <49975D28.4050101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

On Sat, Feb 14, 2009 at 07:09:12PM -0500, Mark Lord wrote:

> >>>I have a bunch of SATA disks hanging off a SAS expander on which I
> >>>would like to disable APM (using hdparm -B).  This doesn't work as-is,
> >>>and from reading:
> >>>
> >>>	http://smartmontools.sourceforge.net/smartmontools_scsi.html
> >>>
> >>>it appears that I'd need to hack hdparm to use the ATA PASS THROUGH
> >>>SCSI command to make it talk to SATA disks behind a SAS expander, as
> >>>was already done for smartctl.  Did anyone implement something like
> >>>this for hdparm yet by any chance?
> >>It actually does that already.  What version are you trying with?
> >
> >I tried with 9.10.  Ah yes, now I see that the man page mentions SAT,
> >but it doesn't appear to be detecting that it needs to do that.
> >
> >
> >>Grab the latest from sourceforge (9.10 or 9.11) and try again.
> >>
> >>If it still doesn't work with that, then let me know and we'll sort
> >>it out.
> >
> >I get this when trying to set -B 254 (in an attempt to turn off head
> >unload/load -- these are WD drives that do that quite frequently):
> >
> >	[root@heth hdparm-9.10]# ./hdparm -B 254 /dev/sdb
> >
> >	/dev/sdb:
> >	 setting Advanced Power Management level to 0xfe (254)
> >	 HDIO_DRIVE_CMD failed: Input/output error
> >	[root@heth hdparm-9.10]# 
> >
> >I don't see it issuing any SG_IO ioctls with command byte being 0xA1
> >or 0xA5 -- I don't see it issuing SG_IO at all:
> 
> That would be because it didn't see SG_IO defined in the header files
> against which it was compiled.  Have a look at your /usr/include/scsi/sg.h
> file and ensure it has SG_IO defined in there.

Well, it does seem to have those:

	[root@heth hdparm-9.10]# grep SG_IO /usr/include/scsi/sg.h
	    char orphan;        /* 0 -> normal request, 1 -> from interruped SG_IO */
	    char sg_io_owned;   /* 0 -> complete with read(), 1 -> owned by SG_IO */
	#define SG_IO 0x2285   /* similar effect as write() followed by read() */
	/* How to treat EINTR during SG_IO ioctl(), only in SG 3.x series */
	[root@heth hdparm-9.10]# strings hdparm | grep SG_IO
	ioctl(fd,SG_IO)
	SG_IO: sb[]
	SG_IO: desc[]
	SG_IO: ATA_%u status=0x%x, host_status=0x%x, driver_status=0x%x
	SG_IO: bad response (not CHECK_CONDITION)
	SG_IO: bad/missing sense data, sb[]
	[root@heth hdparm-9.10]# 

Turns out I was stracing /sbin/hdparm and not ./hdparm (doh).  If I
strace the right binary I get:

	ioctl(3, SG_IO, {'S', SG_DXFER_NONE, cmd[12]=[a1, 06, 20, 05, fd, 00, 00, 00, 40, ef, 00, 00], mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=5000, flags=0, status=02, masked_status=01, sb[22]=[72, 0b, 00, 00, 00, 00, 00, 0e, 09, 0c, 00, 04, 00, fd, 00, 00, 00, 00, 00, 00, 40, 51], host_status=0, driver_status=0x8, resid=0, duration=1, info=0x1}) = 0

Does that mean the drive doesn't support SET_FEATURES/{05,85} (weird)?
