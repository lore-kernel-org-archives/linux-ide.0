From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Wed, 2 Nov 2005 11:05:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0511021104020.4928-100000@iolanthe.rowland.org>
References: <4368C851.80203@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44453 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965110AbVKBQFV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Nov 2005 11:05:21 -0500
In-Reply-To: <4368C851.80203@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thomas schorpp <t.schorpp@gmx.de>
Cc: usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

On Wed, 2 Nov 2005, thomas schorpp wrote:

> hi,
> 
> i'll try integrating SMART/ATA-Security in usb-storage driver for usb2
> ide disks.
> 
> other people working on it yet? ive read something on SMART efforts for
> SATA.
> 
> i think of using the passthrough code (libata?) or module in
> usb-storage.ko like the SATA driver for ATA-Security.
> 
> comments?

Is there any standard way to pass ATA commands over a USB transport?  I've 
never heard of one.

Alan Stern

