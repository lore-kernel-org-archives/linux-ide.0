From: Greg Stark <gsstark@mit.edu>
Subject: Re: [SATA] libata-dev queue updated
Date: 06 Jun 2005 21:57:32 -0400
Message-ID: <87u0kbhqsz.fsf@stark.xeocode.com>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A47376.80203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stark.xeocode.com ([216.58.44.227]:19073 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261205AbVFGB5y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 21:57:54 -0400
In-Reply-To: <42A47376.80203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>

Mark Lord <liml@rtr.ca> writes:

> Greg Stark wrote:
> >
> > Are there diffs downloadable for these? In particular I'm looking for
> > passthru. I'm imagining that with passthru SMART works?
> 
> SMART works already using the HDIO_* ioctls in libata-dev
> (these may be built on top of the passthru stuff.. dunno).
> 
> Eg.  smartctl -data -a /dev/sda

Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
site:

 bash-3.00$ smartctl -data -a /dev/sda
 smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
 Home page is http://smartmontools.sourceforge.net/

 Smartctl: Device Read Identity Failed (not an ATA/ATAPI device)

 A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.


-- 
greg

