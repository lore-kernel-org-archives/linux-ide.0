From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:05:25 +0100
Message-ID: <20060217170524.GC14959@harddisk-recovery.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:11482 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751736AbWBQRF2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 12:05:28 -0500
Content-Disposition: inline
In-Reply-To: <43F4461C.1080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Thu, Feb 16, 2006 at 06:30:04PM +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> >Erik Mouw wrote:
> >>If SGIO can be used for ATA Passthru, then why are the HDIO_DRIVE_CMD
> >>and HDIO_DRIVE_TASK ioctl()s implemented in libata? AFAICS, the same
> >>functionality can be accomplished through SGIO ATA Passthru.
> >
> >For compatibility :)  The HDIO compat ioctls are implemented internally 
> >via the ATA passthru SCSI command.
> >
> >Although in general I resist adding compat ioctls, I think avoiding 
> >TASKFILE when we have TASK/CMD ioctls would be inconsistent.  If 
> >somebody wants to submit a tested patch...
> 
> Just a side note.  Taskfile has finer granuality regarding which 
> registers are written and read back than current libata does and IDE 
> taskfile implementation is somewhat broken/weird in a few delicate fun 
> ways, so... be careful.  Whoever tries it.

The few applications that use the TASKFILE ioctl I've seen don't use
that fine granularity so it might not be necessary.

What kind of delicate broken things are you referring to? The commands
I've tried so far (identify, read sector, etc.) just work.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
