From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Wed, 2 Nov 2005 14:26:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0511021422450.5719-100000@iolanthe.rowland.org>
References: <43690F8B.5000605@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:5762 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965192AbVKBT0L
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 14:26:11 -0500
In-Reply-To: <43690F8B.5000605@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thomas schorpp <t.schorpp@gmx.de>
Cc: usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

On Wed, 2 Nov 2005, thomas schorpp wrote:

> Alan Stern wrote:

> > Is there any standard way to pass ATA commands over a USB transport?  I've 
> > never heard of one.
> > 
> > Alan Stern
> > 
> > 
> 
> yes, ive read on the smartmontools page theres none, at present.
> 
> since therere rw-commands issued, why not possible to issue other, too?

They aren't ATA read/write commands; they are SCSI commands.  If there is 
a version of SMART that runs over SCSI, you might be able to use it.

> and sata is short of smart support. both use scsi-emu(?).
> 
> i dont think theres a hardware problem.

Yes there is.  The USB interface on the drive won't recognize an ATA SMART
command and won't pass it on to the drive controller.

> i'll look at sata/libata/smartctl code and trial'n'error.
> 
> maybe i find a way and you can propose it as standard then :)
> why wait for it?

Because if you don't wait, then no vendors will have implemented it and so 
it won't work.

Alan Stern

