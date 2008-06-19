From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: don't check whether to use
 DMA or not for no data commands
Date: Wed, 18 Jun 2008 20:28:53 -0400
Message-ID: <4859A845.5060302@garzik.org>
References: <4857313A.1000405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40156 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769AbYFSA24 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 20:28:56 -0400
In-Reply-To: <4857313A.1000405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, luke@lukeross.name

Tejun Heo wrote:
> There's no reason to check whether to use DMA or not for no data
> commands.  Don't do it.  While at it, make local variable using_pio in
> atapi_xlat() set iff ATAPI_PROT_PIO is going to be used and rename
> ata_check_atapi_dma() to atapi_check_dma() for consistency.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> It's late in the -rc cycle but these two patches are to work around
> specific hardware and low risk.  Thanks.
> 
>  drivers/ata/libata-core.c |    4 ++--
>  drivers/ata/libata-scsi.c |   16 +++++++---------
>  drivers/ata/libata.h      |    2 +-
>  3 files changed, 10 insertions(+), 12 deletions(-)

applied this (patch #1)

dropped patch #2 per discussion


