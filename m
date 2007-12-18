From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/15] libata: rename ATA_PROT_ATAPI_* to ATAPI_PROT_*
Date: Tue, 18 Dec 2007 16:35:18 -0500
Message-ID: <47683D16.6090600@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <1196840596229-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58279 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbXLRVfU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:35:20 -0500
In-Reply-To: <1196840596229-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> ATA_PROT_ATAPI_* are ugly and naming schemes between ATA_PROT_* and
> ATA_PROT_ATAPI_* are inconsistent causing confusion.  Rename them to
> ATAPI_PROT_* and make them consistent with ATA counterpart.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c       |   24 ++++++++++++------------
>  drivers/ata/libata-eh.c         |    8 ++++----
>  drivers/ata/libata-scsi.c       |   10 +++++-----
>  drivers/ata/libata-sff.c        |    2 +-
>  drivers/ata/pata_pdc202xx_old.c |    5 ++---
>  drivers/ata/pdc_adma.c          |    2 +-
>  drivers/ata/sata_inic162x.c     |    2 +-
>  drivers/ata/sata_promise.c      |   26 ++++++++++++--------------
>  drivers/ata/sata_qstor.c        |    2 +-
>  drivers/ata/sata_sx4.c          |    2 +-
>  drivers/scsi/ipr.c              |    6 +++---
>  drivers/scsi/libsas/sas_ata.c   |    2 +-
>  include/linux/ata.h             |   12 ++++++------
>  13 files changed, 50 insertions(+), 53 deletions(-)

applied #upstream, with build fixes for recent #upstream-fixes changes


