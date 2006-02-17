From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Fri, 17 Feb 2006 18:28:04 +0100
Message-ID: <20060217172804.GF14959@harddisk-recovery.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com> <43F4461C.1080501@gmail.com> <20060217170524.GC14959@harddisk-recovery.com> <58cb370e0602170915mda252e5qc3b0f0a65fd12022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:6367 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750811AbWBQR2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 12:28:06 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0602170915mda252e5qc3b0f0a65fd12022@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Fri, Feb 17, 2006 at 06:15:12PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 2/17/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> > What kind of delicate broken things are you referring to? The commands
> > I've tried so far (identify, read sector, etc.) just work.
> 
> Documentation/ioctl/hdio.txt

I actually meant "broken things beyond what is documented in hdio.txt"
;-)

> TASKFILE ioctl will be hopefully removed from drivers/ide
> in few months time (and replaced by SG_IO).

Note that there are two widely used programs that use TASKFILE: hdparm
and smartcl. We'd rather don't have many complaining users on this list
(or on linux-kernel), so please put the announcement in
Documentation/feature-removal-schedule.txt .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
