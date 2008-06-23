From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Mon, 23 Jun 2008 10:16:00 +0100
Message-ID: <20080623101600.391e5245@lxorguk.ukuu.org.uk>
References: <87k5gmz596.fsf@denkblock.local>
	<200806192247.25063.bzolnier@gmail.com>
	<87wskhuk98.fsf@denkblock.local>
	<87r6apuk16.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756149AbYFWJez@vger.kernel.org>
In-Reply-To: <87r6apuk16.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-ide@vger.kernel.org

> in various ways.  Most importantly, it is treated as an out of band
> request in an illegal way which may very likely lead to system lock ups.
> Use the drive's request queue to avoid this problem (and fix a locking
> issue for free along the way).

It was always designed to be, and used out of band. One of the important
uses of the ioctl is to abort a running command when an interface has
jammed up. If you end up queueing it behind that command you've lost most
of the reason for the ioctl anyway (and you might as well just remove it
really given SG_IO exists).

Other than the command aborting bit, it looks a good idea - that code has
always been racy and raced against timer handlers, irq handlers and if
neither of them got it then a speed changedown raced the lot 8(

Alan
