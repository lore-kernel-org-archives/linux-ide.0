From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] libata: improve ata_down_xfermask_limit()
Date: Tue, 20 Feb 2007 10:46:39 -0500
Message-ID: <45DB17DF.1000702@garzik.org>
References: <11704009501245-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43949 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbXBTPqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:46:42 -0500
In-Reply-To: <11704009501245-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ata_down_xfermask_limit() accept @sel instead of @force_pio0.
> @sel selects how the xfermask limit will be adjusted.  The following
> selectors are defined.
> 
> * ATA_DNXFER_PIO	: only speed down PIO
> * ATA_DNXFER_DMA	: only speed down DMA, don't cause transfer mode change
> * ATA_DNXFER_40C	: apply 40c cable limit
> * ATA_DNXFER_FORCE_PIO	: force PIO
> * ATA_DNXFER_FORCE_PIO0	: force PIO0 (same as original with @force_pio0 == 1)
> * ATA_DNXFER_ANY	: same as original with @force_pio0 == 0
> 
> Currently, only ANY and FORCE_PIO0 are used to maintain the original
> behavior.  Other selectors will be used later to improve EH speed down
> sequence.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |  105 ++++++++++++++++++++++++++++++++++-----------
>  drivers/ata/libata-eh.c   |    9 +++-
>  drivers/ata/libata.h      |   12 +++++-
>  3 files changed, 96 insertions(+), 30 deletions(-)

applied 1-4


