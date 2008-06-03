From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] libata:ahci: enclosure management support (resend)
Date: Tue, 03 Jun 2008 14:03:35 -0400
Message-ID: <48458777.70904@garzik.org>
References: <20080603103355.34c49ef4@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37470 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbYFCSDl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 14:03:41 -0400
In-Reply-To: <20080603103355.34c49ef4@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Kristen Carlson Accardi wrote:
> Here's a resend of the patch I sent 2 weeks ago, refreshed against
> Andrews kernel.  This is one of many resends since the original 
> patch was sent in January-ish. Could you please review this patch 
> and let me know what you'd like me to change?  I'm happy to change it 
> however you want as long as the feature still functions.
> 
> Thanks,
> Kristen
> 
> Add Enclosure Management support to libata and ahci.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/ata/ahci.c        |  321 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata-scsi.c |   79 +++++++++++
>  include/linux/libata.h    |   21 +++
>  3 files changed, 419 insertions(+), 2 deletions(-)

I'm pretty happy with this, and I plan on queueing it for #upstream 
(2.6.27, linux-next).

Ideally a better solution would be a bit more generic (i.e. not just 
libata), but this is a nice and compact implementation, and generic 
enough to support all of libata's purposes.

