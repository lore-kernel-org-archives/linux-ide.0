From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Thu, 3 Dec 2009 09:55:39 +0100
Message-ID: <20091203085539.GB23867@frolo.macqel>
References: <20091026162011.GA3289@frolo.macqel> <4AE64031.5060105@gmail.com> <4AEC420A.9030502@rtr.ca> <20091202.215738.12118816.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:4734 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbZLCIzh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 03:55:37 -0500
Content-Disposition: inline
In-Reply-To: <20091202.215738.12118816.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: liml@rtr.ca, hancockrwd@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 02, 2009 at 09:57:38PM -0800, David Miller wrote:
> ide: Increase WAIT_DRQ to accomodate some CF cards and SSD drives.
> 
> Based upon a patch by Philippe De Muyter, and feedback from Mark
> Lord and Robert Hancock.
> 
> As noted by Mark Lord, the outdated ATA1 spec specifies a 20msec
> timeout for setting DRQ but lots of common devices overshoot this.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> 
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index e4135d6..0ec6129 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -125,8 +125,8 @@ struct ide_io_ports {
>   * Timeouts for various operations:
>   */
>  enum {
> -	/* spec allows up to 20ms */
> -	WAIT_DRQ	= HZ / 10,	/* 100ms */
> +	/* spec allows up to 20ms, but CF cards and SSD drives need more */
> +	WAIT_DRQ	= 1 * HZ,	/* 1s */
>  	/* some laptops are very slow */
>  	WAIT_READY	= 5 * HZ,	/* 5s */
>  	/* should be less than 3ms (?), if all ATAPI CD is closed at boot */
