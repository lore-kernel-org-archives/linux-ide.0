From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/14] libata-hp-prep: make some ata_device fields persistent
Date: Fri, 19 May 2006 11:00:21 -0400
Message-ID: <446DDD85.5060103@pobox.com>
References: <1148044584487-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20134 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932322AbWESPAm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:00:42 -0400
In-Reply-To: <1148044584487-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> @@ -439,6 +441,8 @@ struct ata_device {
>  	struct ata_ering	ering;
>  };
>  
> +#define ATA_DEVICE_CLEAR_OFFSET		offsetof(struct ata_device, n_sectors)

add a code comment, explaining what this is used for.

ACK everything else in patch.

ACK patch #2, also.

	Jeff


