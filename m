From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Thu, 08 Jun 2006 16:56:08 -0400
Message-ID: <44888EE8.6090405@pobox.com>
References: <11490747442153-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58329 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965010AbWFHU4S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 16:56:18 -0400
In-Reply-To: <11490747442153-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5697194..4071156 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -521,7 +521,7 @@ struct ata_port {
>  	struct ata_host_set	*host_set;
>  	struct device 		*dev;
>  
> -	struct work_struct	port_task;
> +	struct work_struct	port_task, hotplug_task;

nit:  break this into two lines.

ACK everything else, and ACK patches 1-2


