From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 01:45:34 +0100
Message-ID: <20070718014534.6a0adffe@the-village.bc.nu>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	<6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:56292 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S934708AbXGRAiw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 20:38:52 -0400
In-Reply-To: <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: flyashi@gmail.com
Cc: linux-ide@vger.kernel.org

> - each driver, in ata_port_operations, specifies a soft_reset and
> hard_reset functions, which take ata_port* as a parameter

They already have them via the EH code.

> - in ata_scsi_pass_through, check for HARDRESET and SRST, and call
> respective driver's soft/hard reset function

Old IDE has an ioctl for it - it would be good to provide this for
compatibility as we have with some other needed ioctls.

> Now here's where I'm not quite certain on how to proceed. Another
> developer has recommended that the reset be performed from an error
> context, so that pre/post reset get called automatically. However,
> there's a few issues, one of which is, as I was told, that the user
> process will resume before the reset is complete. Thus the user sends
> SG_IO and gets an immediate response, before the reset is finished,
> whereas running the reset command directly blocks the user process
> until the drive returns.
> 
> So the question is: should the driver simply call prereset, optionally
> hardreset, softreset, and postreset, or set up the error handler
> context to do it?

I think you have to do the latter. I see no other way to get the locking
right, and the old IDE was horrible (and broken) because it tried to do
it in the user context. drivers/ide is a worked example of why *NOT* to
simply call the methods. The EH just needs triggering and can do the rest
sanely in a sensible context without adding new methods to the drivers.
