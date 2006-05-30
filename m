From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/12] libata-hp-prep: update ata_scsi_find_dev() and
 friends
Date: Tue, 30 May 2006 00:02:05 -0400
Message-ID: <447BC3BD.30301@pobox.com>
References: <11488839582103-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13795 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751445AbWE3ECU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:02:20 -0400
In-Reply-To: <11488839582103-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
> +{
> +	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
> +		return &ap->device[id];
> +	return NULL;

>  static struct ata_device *
>  ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
>  {
> -	struct ata_device *dev;
> -
> -	/* skip commands not addressed to targets we simulate */
> -	if (likely(scsidev->id < ATA_MAX_DEVICES))
> -		dev = &ap->device[scsidev->id];
> -	else
> -		return NULL;


You replace a '<' test with a more complex test, which must then be 
modified when we start supporting Port Multipliers.

It is more simple, and easier, to keep the 'id < ATA_MAX_DEVICES' test 
AFAICS.

	Jeff


