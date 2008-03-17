From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: use atapi_cmd_type() to determine
 cmd type instead of transfer size
Date: Mon, 17 Mar 2008 08:27:52 -0400
Message-ID: <47DE63C8.2000006@garzik.org>
References: <47D5EFD4.2090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47644 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293AbYCQM1z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:27:55 -0400
In-Reply-To: <47D5EFD4.2090801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

Tejun Heo wrote:
> pata_ali and pata_it821x were using qc->nbytes to determine whether a
> command is data transfer type or not.  As now qc->nbytes can be
> extended by padding and draining buffers, this tests are not useful
> anymore.  Use atapi_cmd_type() instead.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/ata/pata_ali.c    |    2 +-
>  drivers/ata/pata_it821x.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 7e68edf..8786455 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -295,7 +295,7 @@ static void ali_lock_sectors(struct ata_device *adev)
>  static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
>  {
>  	/* If its not a media command, its not worth it */
> -	if (qc->nbytes < 2048)
> +	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
>  		return -EOPNOTSUPP;
>  	return 0;
>  }

applied the pata_ali portion of this patch


