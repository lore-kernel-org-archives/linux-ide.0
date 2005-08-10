From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata total system lockup fix
Date: Wed, 10 Aug 2005 17:24:57 -0400
Message-ID: <42FA70A9.6080608@pobox.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37281 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030277AbVHJVZB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 17:25:01 -0400
In-Reply-To: <42F2E267.50402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Mark Lord <mlord@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Tejun Heo wrote:
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -385,6 +385,7 @@ int ata_scsi_error(struct Scsi_Host *hos
>          * appropriate place
>          */
>         host->host_failed--;
> +       INIT_LIST_HEAD(&host->eh_cmd_q);
> 
>         DPRINTK("EXIT\n");
>         return 0;


applied to 2.6.13

