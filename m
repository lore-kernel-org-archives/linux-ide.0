From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH: IDE - do spin up for all platforms
Date: Tue, 10 Aug 2004 08:10:38 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092089438.14102.48.camel@gaston>
References: <20040809143902.GA16025@devserv.devel.redhat.com>
	 <411790DE.7010503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33491 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267307AbUHIWNl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Aug 2004 18:13:41 -0400
In-Reply-To: <411790DE.7010503@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Tue, 2004-08-10 at 00:57, Jeff Garzik wrote:

> It needs to check for "status != 0x7f" which is the standard "no device 
> here" return status.

Nope, it waits for BSY to go down

> But worse than that, status can return 0xFF for "no hardware there", in 
> which case this routine will hang the boot for 35 seconds.

My original version did, let me check.. yes, the current code does that
too, check ide_wait_not_busy. Note that this is a workaround for broken
hardware as the spec clearly says that D7 should be pulled low so that
no drive returns 0x7f (BSY clear). However, there is a significant
amount of HW with this bug...

> Note also that libata code does this:
> * wait 7 seconds
> * printk("it's taking a long time, be patient")
> * wait ~30 seconds

That could be a good idea. Patch welcome :)

Ben.


