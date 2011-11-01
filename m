From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 3/3] drivers: ata: libata-scsi.c: Add function parameter
 documentation
Date: Tue, 01 Nov 2011 11:13:01 -0700
Message-ID: <4EB036AD.8030707@xenotime.net>
References: <1320112216-23810-1-git-send-email-marcos.mage@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:45309 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751921Ab1KASNb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2011 14:13:31 -0400
In-Reply-To: <1320112216-23810-1-git-send-email-marcos.mage@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcos Paulo de Souza <marcos.mage@gmail.com>
Cc: jgarzik@pobox.com, linux-doc@vger.kernel.org, linux-ide@vger.kernel.org

On 10/31/2011 06:50 PM, Marcos Paulo de Souza wrote:
> Add the documentation of parameters of ata_change_queue_depth to silence the warning of make xmldocs
> 
> Signed-off-by: Marcos paulo de Souza <marcos.mage@gmail.com>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.

> ---
>  drivers/ata/libata-scsi.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 19ba770..5eceb23 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1216,6 +1216,10 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
>  
>  /**
>   *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
> + *	@ap: ATA port to which the device change the queue depth
> + *	@sdev: SCSI device to configure queue depth for
> + *	@queue_depth: new queue depth
> + *	@reason: calling context
>   *
>   *	libsas and libata have different approaches for associating a sdev to
>   *	its ata_port.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
