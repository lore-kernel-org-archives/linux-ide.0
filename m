From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/3] libata/pdc_adma: make SFF EH handle non-bmdma
 SFF drivers and standardize pdc_adma ops
Date: Fri, 04 Apr 2008 03:50:57 -0400
Message-ID: <47F5DDE1.4000808@garzik.org>
References: <47E8F15F.50601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48834 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbYDDHvA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:51:00 -0400
In-Reply-To: <47E8F15F.50601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> pdc_adma has interface similar to SFF but has its own DMA interface.
> It currently implements noop bmdma ops to avoid crashing
> ata_bmdma_error_handler() which BTW actually is EH for SFF drivers.
> 
> This patch makes ata_bmdma_error_handler() dereference bmdma ops iff
> bmdma_addr is initialized as done in ata_bmdma_post_internal_cmd.
> This change allows pdc_adma to standardize ops and use SFF
> error_handler and post_internal_cmd.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <liml@rtr.ca>
> ---
> This patch series in on top of #cleanup-sht-ops (ed75ba53) and not for
> #upstream-fixes.  Tested with pdc_adma controllers Mark sent me. :-)
> 
>  drivers/ata/libata-sff.c |    3 ++-
>  drivers/ata/pdc_adma.c   |   16 ++--------------
>  2 files changed, 4 insertions(+), 15 deletions(-)

applied 1-3

I realize now that the lack of this patchset (broken ordering on my 
part) probably caused the previously-emailed-about compile breakage. 
sorry!  I'll pull the rest after a resync, since I ack'd that 27-patch 
patchset.


