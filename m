From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates (mostly fixes)
Date: Thu, 15 Feb 2007 18:43:58 -0500
Message-ID: <45D4F03E.6040208@garzik.org>
References: <20070215233411.GA10782@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60667 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400AbXBOXoB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:44:01 -0500
In-Reply-To: <20070215233411.GA10782@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -352,7 +352,7 @@ static inline int ata_drive_40wire(const u16 *dev_id)
>  {
>  	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
>  		return 0;	/* SATA */
> -	if (dev_id[93] & 0x4000)
> +	if ((dev_id[93] & 0xE000) == 0x6000)
>  		return 0;	/* 80 wire */
>  	return 1;
>  }

A thought:  it seems to me that the major version check should be moved 
into ata_id_is_sata().

	Jeff


