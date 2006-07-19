From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/12] libata: implement ata_all_ports list
Date: Wed, 19 Jul 2006 15:34:08 -0400
Message-ID: <44BE8930.4040506@pobox.com>
References: <11531191512553-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28041 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030234AbWGSTeQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 15:34:16 -0400
In-Reply-To: <11531191512553-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_all_ports list.  All active ata_ports are linked on this
> list.  This will be used to dynamically modify libata-wide
> configurations.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |   13 +++++++++++++
>  include/linux/libata.h     |    2 ++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> a962488760934f639dd202793694339afd2db1cf
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 61db4f5..1477d32 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -70,6 +70,9 @@ static unsigned int ata_dev_init_params(
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>  static void ata_dev_xfermask(struct ata_device *dev);
>  
> +static DEFINE_MUTEX(ata_all_ports_mutex);
> +static LIST_HEAD(ata_all_ports);

NAK.  I'm pretty strongly against things that cross the controller 
boundary.  Any information or data structure shared across multiple 
controllers often winds up unnecessary limiting future implementations, 
and become locking/serialization nightmares.


