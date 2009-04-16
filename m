From: Mark Lord <lkml@rtr.ca>
Subject: Re: [git patches] libata fixes
Date: Thu, 16 Apr 2009 16:28:15 -0400
Message-ID: <49E794DF.8050001@rtr.ca>
References: <20090416193924.GA27823@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:49595 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbZDPU2Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 16:28:16 -0400
In-Reply-To: <20090416193924.GA27823@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> Various minor fixes, and a small libata.h cleanup.
..

Any chance you could also push out the last of the sata_mv errata workarounds?
That's the one that prevents data corruption for multisector WRITEs.

[PATCH 01/02] sata_mv: tidy up qc->tf usage in qc_prep() functions
[PATCH 02/02] sata_mv: workaround for multi_count errata sata24

Thanks
