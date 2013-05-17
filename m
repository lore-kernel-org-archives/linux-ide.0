From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/2] Adds new device resume mode in PM core, async
 plus non-blocking
Date: Fri, 17 May 2013 15:44:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305171539470.1012-100000@iolanthe.rowland.org>
References: <11E08D716F0541429B7042699DD5C1A16B97BD8A@FMSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46527 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750753Ab3EQTox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 May 2013 15:44:53 -0400
In-Reply-To: <11E08D716F0541429B7042699DD5C1A16B97BD8A@FMSMSX103.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Brandt, Todd E" <todd.e.brandt@intel.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>

On Fri, 17 May 2013, Brandt, Todd E wrote:

> Updates the drivers/base/power subsystem to allow any devices which
> have registred as asynchronous and who have not registered "complete"
> callbacks to be non-blocking. i.e system resume can finish and return
> control to the user while these devices continue resuming.

This does not sound like a good idea.  The presence or absence of a 
"complete" callback has nothing to do with whether or not system resume 
can finish before the device is ready.  It is more closely related to 
whether the device's driver can register hot-plugged children below the 
device or needs to perform other actions after the children have been 
resumed.

The whole approach seems wrong -- it violates the implicit agreement 
that the kernel will not try to perform I/O through a device that isn't 
at full power.

A better approach would be to modify the SCSI disk driver to carry out 
the spin-up operation asynchronously with respect to the resume 
callback.  Then the disk could be reported as back to full power while 
the spin-up is taking place.

Alan Stern

