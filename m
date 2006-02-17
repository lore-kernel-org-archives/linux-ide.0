From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:07:14 +0100
Message-ID: <20060217170714.GD14959@harddisk-recovery.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:31194 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751167AbWBQRHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 12:07:15 -0500
Content-Disposition: inline
In-Reply-To: <43F3E17E.1090701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Wed, Feb 15, 2006 at 09:20:46PM -0500, Jeff Garzik wrote:
> Erik Mouw wrote:
> >On Wed, Feb 15, 2006 at 02:00:46PM -0500, Mark Lord wrote:
> >
> >>Erik Mouw wrote:
> >>
> >>>Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature set
> >>>(security freeze, security unlock, etc.). I can't find it in Jeff's
> >>>libata-dev tree, is there somebody already working on it? Or is there a
> >>>workaround?
> >>
> >>If that ioctl is missing in libata, then I'll have to convert hdparm
> >>to use SGIO to submit ATA Passthru packets instead for libata devices.
> >
> >
> >If SGIO can be used for ATA Passthru, then why are the HDIO_DRIVE_CMD
> >and HDIO_DRIVE_TASK ioctl()s implemented in libata? AFAICS, the same
> >functionality can be accomplished through SGIO ATA Passthru.
> 
> For compatibility :)  The HDIO compat ioctls are implemented internally 
> via the ATA passthru SCSI command.

OK, thanks for the hint.

> Although in general I resist adding compat ioctls, I think avoiding 
> TASKFILE when we have TASK/CMD ioctls would be inconsistent.  If 
> somebody wants to submit a tested patch...

Hmm, I might want to have a try. OTOH, Mark's suggestion to use SG_IO
also makes sense and avoids adding nasty compat ioctls.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
