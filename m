From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 10:18:13 -0500
Message-ID: <437607B5.7060605@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:27114 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932393AbVKLPSO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 10:18:14 -0500
In-Reply-To: <4375CA38.9000905@superbug.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-ide@vger.kernel.org

James Courtier-Dutton wrote:
> I am using (at 12-Nov-2005)
> git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> uname -r
> 2.6.15-rc1-gcd52d1ee
> I have found that although smartctl correctly displays different 
> information for /dev/sda and /dev/sdb, hdparm does not.
> hdparm displays the same info for /dev/sda and /dev/sdb
> i.e. hdparm -I /dev/sdb actually returns the information about /dev/sda
> 
> See below for details.
> 
> Is this a bug in hdparm or libata-devel ?
...
> # hdparm -I /dev/sda
> /dev/sda:
> ATA device, with non-removable media
>     Model Number:       ST3300831AS
>     Serial Number:      3NF0A9CQ
>     Firmware Revision:  3.01
> ...
> # hdparm -I /dev/sdb
> /dev/sdb:
> ATA device, with non-removable media
>     Model Number:       ST3300831AS
>     Serial Number:      3NF0A9CQ
>     Firmware Revision:  3.01

That would be a bug in libata passthru.

The reason the two programs behave differently in this example,
is that they likely use different HDIO_* ioctls, and libata/passthru
must have a bug in setting the unit number for the HDIO_DRIVE_CMD call.

We know it cannot be an hdparm bug, because HDIO_DRIVE_CMD does not
have a unit# parameter (and it would not be valid for libata to
accept one, either!).  All it does is open the /dev/ node,
and issue that call.   Use strace to verify that the correct device
is indeed being opened.

Is there a tarball of the latest libata-dev-git available?
Givent that, I could probably sift through libata/passthru and find/fix
the bug, but keeping up with git technology is something I gave up
trying to do ages ago --> it's really not for the casual developer.

Cheers
