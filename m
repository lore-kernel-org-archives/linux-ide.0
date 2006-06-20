From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_via: convert to new EH, take #3
Date: Tue, 20 Jun 2006 05:16:44 -0400
Message-ID: <4497BCFC.7040109@pobox.com>
References: <20060613115155.GB17964@htj.dyndns.org> <20060613214609.GB10142@htj.dyndns.org> <20060616061353.GD10142@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62408 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965086AbWFTJQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 05:16:47 -0400
In-Reply-To: <20060616061353.GD10142@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_via to new EH.  vt6420 used ATA_FLAG_SRST while vt6421
> used ATA_FLAG_SATA_RESET.  This difference seems to be an accident
> rather than intended.  This patch makes both flavors use
> ata_bmdma_error_handler() which makes use of both SRST and SATA
> hardreset.  This behavior change is intended and if it breaks
> anything, it should be very easy to spot.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Applied.  Addressing the "rather than intended" comment above, the 
history is actually this:

Throughout libata, I have always preferred SATA PHY reset to SRST. 
SATA_RESET didn't work well on one VTxxxx chip, while it did work on 
another.  Thus, the driver reflected what worked.

While we may need to disable COMRESET completely on vt6420 (look for 
sata_via bug reports here!), I would prefer to shove both chips down the 
EH path that you have presented.  If that doesn't work, we'll take 
further action from here.

	Jeff



