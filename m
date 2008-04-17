From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/07] sata_mv hardreset rework
Date: Thu, 17 Apr 2008 15:57:12 -0400
Message-ID: <4807AB98.4070707@pobox.com>
References: <48064BCC.5070505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34270 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbYDQT5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2008 15:57:16 -0400
In-Reply-To: <48064BCC.5070505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Rework and simplify sata_mv's hardreset code to take advantage
> of libata improvements since it was first coded.
> 
> Also, get rid of the now unnecessary prereset, postreset, and phy_reset 
> functions.
> 
> This patch also paves the way for subsequent pmp support patches,
> which will follow once this one passes muster.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-04-10 14:30:27.000000000 -0400
> +++ linux/drivers/ata/sata_mv.c    2008-04-10 14:31:01.000000000 -0400

applied 1-7


