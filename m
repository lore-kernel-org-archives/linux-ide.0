From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c
 cable check, take 3
Date: Thu, 15 Feb 2007 18:08:49 -0500
Message-ID: <45D4E801.8090103@garzik.org>
References: <20070205074535.GE1625@htj.dyndns.org> <20070205105744.6f22fc7d@localhost.localdomain> <20070205124106.GK1625@htj.dyndns.org> <20070205132706.1ff6d761@localhost.localdomain> <20070205142119.GM1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60255 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161662AbXBOXIw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:08:52 -0500
In-Reply-To: <20070205142119.GM1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, stable@kernel.org

Tejun Heo wrote:
> The 80c wire bit is bit 13, not 14.  Bit 14 is always 1 if word93 is
> implemented.  This increases the chance of incorrect wire detection
> especially because host side cable detection is often unreliable and
> we sometimes soley depend on drive side cable detection.  Fix the test
> and add word93 validity check.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Sure, updated as suggested.
> 
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 1df9416..939be94 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -347,7 +347,7 @@ static inline int ata_drive_40wire(const u16 *dev_id)
>  {
>  	if (ata_id_major_version(dev_id) >= 5 && ata_id_is_sata(dev_id))
>  		return 0;	/* SATA */
> -	if (dev_id[93] & 0x4000)
> +	if ((dev_id[93] & 0xE000) == 0x6000)
>  		return 0;	/* 80 wire */

applied


