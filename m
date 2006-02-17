From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:17:43 +0100
Message-ID: <20060217171743.GE14959@harddisk-recovery.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com> <43F58B7E.4000401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:55516 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751143AbWBQRRp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 12:17:45 -0500
Content-Disposition: inline
In-Reply-To: <43F58B7E.4000401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Fri, Feb 17, 2006 at 03:38:22AM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Just a side note.  Taskfile has finer granuality regarding which 
> >registers are written and read back than current libata does and IDE 
> >taskfile implementation is somewhat broken/weird in a few delicate fun 
> >ways, so... be careful.  Whoever tries it.
> 
> Yes -- it opens the question about whether we care enough to fully 
> support flagged taskfiles, and if not, how to best emulate that support 
> under libata.
> 
> I'm told that flagging individual ATA shadow registers for modification 
> (or not) is required for issuing certain specialized PATA 
> vendor-specific commands.  SATA, OTOH, transmits all ATA shadow 
> registers in a FIS, so flagged taskfiles are useless.

I'd have to look at our own software to see if it's required or not.
For PATA it doesn't really matter, you can always fiddle the registers
using inb() and outb().

You're right about SATA, it doesn't make sense to use flagged
taskfiles.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
