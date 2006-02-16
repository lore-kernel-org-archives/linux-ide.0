From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Thu, 16 Feb 2006 01:56:43 +0100
Message-ID: <20060216005643.GA28396@harddisk-recovery.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:15086 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932201AbWBPA4p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 19:56:45 -0500
Content-Disposition: inline
In-Reply-To: <43F37A5E.1090301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Wed, Feb 15, 2006 at 02:00:46PM -0500, Mark Lord wrote:
> Erik Mouw wrote:
> >Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature set
> >(security freeze, security unlock, etc.). I can't find it in Jeff's
> >libata-dev tree, is there somebody already working on it? Or is there a
> >workaround?
> 
> If that ioctl is missing in libata, then I'll have to convert hdparm
> to use SGIO to submit ATA Passthru packets instead for libata devices.

If SGIO can be used for ATA Passthru, then why are the HDIO_DRIVE_CMD
and HDIO_DRIVE_TASK ioctl()s implemented in libata? AFAICS, the same
functionality can be accomplished through SGIO ATA Passthru.

> That's on my TO-DO list, and rising more quickly to the top now, it seems.

OK, great.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
