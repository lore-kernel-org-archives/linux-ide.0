From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: A note on libata passthru patch
Date: Mon, 22 Aug 2005 08:26:05 -0400
Message-ID: <20050822122603.GI2736@tuxdriver.com>
References: <4308F40E.3010109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:12676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751305AbVHVVzf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 17:55:35 -0400
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MCTU63023866
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 05:29:30 -0700
Content-Disposition: inline
In-Reply-To: <4308F40E.3010109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

On Sun, Aug 21, 2005 at 05:37:18PM -0400, Jeff Garzik wrote:
> 
> Something that Alan unintentionally reminded me, about the libata 
> passthru patch:  Some controllers require certain ATA commands to be 
> synchronized at the host-wide level.

<snip>

> Currently probing is 100% synchronous, so our internal use of SET 
> FEATURES - XFER MODE is safe.  But when you turn on ATA passthru, it is 
> not safe.

...except that the passthru code specifically filters-out the SET
FEATURES - XFER MODE command. (libata_scsi.c:1976)
 
> This is another issue that needs fixing before we can merge the ATA 
> passthru feature, since the consequences can be serious.

I am by no means an expert either on ATA in general or on the oddities
and quirks of specific SATA controllers.  I don't know if anyone else
interested in the fate of the passthru patch is such an expert or not,
but either way it would likely be helpful to list any other specific
synchronization issues known to date which might be problematic.

Presuming that such a list either exists or is likely to exist, does
anyone have suggestions for what needs to be done in the general
case here?  Perhaps some infrastructure needs to be added to verify
that it is okay for the passthru stuff to issue a given command at a
given time on a given controller?  Sounds complicated...  Maybe some
infrastructure to quiesce _everything_ on the controller before
issuing a passthru command?  Just thinking "out loud"...

I'd like to help (and I'd like the passthru stuff to be "in"), but
I need some guidance...

John
-- 
John W. Linville
linville@tuxdriver.com
