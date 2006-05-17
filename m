From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/22] libata: use preallocated buffers
Date: Wed, 17 May 2006 08:47:23 -0400
Message-ID: <446B1B5B.2030006@pobox.com>
References: <11473487902895-git-send-email-htejun@gmail.com> <446AB5EB.5050603@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56496 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932543AbWEQMro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 08:47:44 -0400
In-Reply-To: <446AB5EB.5050603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> --- upstream/include/linux/libata.h	2006-05-16 11:08:54.000000000 +0800
> +++ upstream1/include/linux/libata.h	2006-05-17 13:25:24.000000000 +0800
> @@ -330,12 +330,12 @@ struct ata_host_set {
>  	unsigned long		irq;
>  	void __iomem		*mmio_base;
>  	unsigned int		n_ports;
> -	void			*private_data;
>  	const struct ata_port_operations *ops;
>  	unsigned long		flags;
>  	int			simplex_claimed;	/* Keep seperate in case we
>  							   ever need to do this locked */
>  	struct ata_port *	ports[0];
> +	void			*private_data;
>  };

The zero length array needs to remain the last element in the struct...

	Jeff


