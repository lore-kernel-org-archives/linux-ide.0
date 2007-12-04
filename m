From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/14] libata: add qc->dma_nbytes
Date: Tue, 04 Dec 2007 14:33:28 -0500
Message-ID: <4755AB88.6080808@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468193821-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40300 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbXLDTda (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:33:30 -0500
In-Reply-To: <11963468193821-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> qc->nbytes doesn't include extra buffers setup by libata core layer
> and my be odd.  This patch adds qc->dma_nbytes which includes any
> extra buffers setup by libata core layer and is guaranteed to be
> aligned on 4 byte boundary.
> 
> This value is to be used to program the host controller.  As this
> represents the actual length of buffer available to the controller and
> the controller must be able to deal with short transfers for ATAPI
> commands which can transfer variable length, this shouldn't break any
> controllers while making problems like rounding-down and controllers
> choking up on odd transfer bytes much less likely.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c       |   11 +++++++----
>  drivers/ata/pata_pdc202xx_old.c |    2 +-
>  drivers/ata/sata_inic162x.c     |    2 +-
>  drivers/ata/sata_qstor.c        |    2 +-
>  include/linux/libata.h          |    3 ++-
>  5 files changed, 12 insertions(+), 8 deletions(-)

I would suggest two values:

qc->nbytes	-> value to program host controllers with
qc->raw_nbytes	-> the precise value, without any padding etc.

IMO this makes it more likely that people will use the "right" value


