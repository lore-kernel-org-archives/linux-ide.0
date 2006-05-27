From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Sat, 27 May 2006 02:31:42 -0400
Message-ID: <4477F24E.8080407@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <44778F2A.7070708@garzik.org> <20060527062159.GB23315@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5353 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751418AbWE0Gbt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:31:49 -0400
In-Reply-To: <20060527062159.GB23315@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> I thought about that, and I don't agree. Waiting for the BSY to clear is
> not a pci property, at best I'd consider that even worse than defining a
> scsi resume function in ata_piix.

It has nothing to do with PCI, and everything to do control flow.  This 
is _how the hardware works_:

First you resume the controller.
Then you resume the bus.
Then you resume the devices on the bus.

The original patch goes BACKWARDS, by trying to resume the bus from the 
device resume method.  That's just dumb.

In a PCI driver, the resume is _always_ driven by pci_driver::resume. 
Control flow starts there.  Once you get down to the individual device 
level -- with the original patch -- you are attempting to pick up the 
pieces that should have _already_ been done by higher layers.

This is how all drivers work.  Control flow starts at driver::resume, 
which in turn directs resumption of various layers.

	Jeff



