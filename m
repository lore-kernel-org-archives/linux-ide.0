From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/10] libata: implement new EH action ATA_EH_SPINUP
Date: Wed, 14 Jun 2006 16:25:54 +0100
Message-ID: <1150298754.3490.51.camel@localhost.localdomain>
References: <11501274283970-git-send-email-htejun@gmail.com>
	 <448F63F3.5010909@pobox.com>  <44902511.2040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45954 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964994AbWFNPKk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 11:10:40 -0400
In-Reply-To: <44902511.2040102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

> * Until now, unified EH seems good enough.  In fact, not a single driver 
> needs to go further than calling ata_do_eh() w/ proper callbacks.

This has been shown to be fairly true for the old IDE as well. Other
than the years old unfixed promise crash (for which patches exist) the
core error recovery doesn't need to do anything in a different order for
different devices.

For PATA controllerrs using the traditional i/o API the variances are
small and normally around the resetting of the bus, and whether you also
have to whack the state machine with a large hammer to get it back into
shape after an error case, or whether hardware does it.

The promise is "special" purely because if you reset the state machine
then read from the data port before you do another operation you hang
the box, and that sequence of events is a failure of the old IDE design
rather than a "different" ordering of events.

Alan

