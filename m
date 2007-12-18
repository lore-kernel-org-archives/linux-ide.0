From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 07/15] change-data_xfer
Date: Tue, 18 Dec 2007 16:38:23 -0500
Message-ID: <47683DCF.3060304@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405971209-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57859 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbXLRViZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:38:25 -0500
In-Reply-To: <11968405971209-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Depending on how many bytes are transferred as a unit, PIO data
> tranasfer may consume more bytes than requested.  Knowing how much
> data is consumed is necessary to determine how much is left for
> draining.  This patch update ->data_xfer such that it returns the
> number of consumed bytes.
> 
> While at it, it also makes the following changes.
> 
> * s/adev/dev/
> * use READ/WRITE constants for rw indication
> * misc clean ups
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c    |   46 +++++++++++++++++++++++++++--------------
>  drivers/ata/pata_bf54x.c     |   28 +++++++++++++-----------
>  drivers/ata/pata_ixp4xx_cf.c |   26 ++++++++++++-----------
>  drivers/ata/pata_legacy.c    |   36 +++++++++++++++++---------------
>  drivers/ata/pata_qdi.c       |   30 +++++++++++++++-----------
>  drivers/ata/pata_scc.c       |   30 ++++++++++++++------------
>  drivers/ata/pata_winbond.c   |   28 ++++++++++++++-----------
>  include/linux/libata.h       |   11 +++++----
>  8 files changed, 133 insertions(+), 102 deletions(-)

applied 6-7 to #upstream


