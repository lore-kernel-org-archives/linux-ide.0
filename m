From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/03] sata_mv: move SOC_FLAG to hpriv
Date: Fri, 30 May 2008 18:10:35 -0400
Message-ID: <48407B5B.7030404@pobox.com>
References: <483C8328.1030807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44903 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYE3WKi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:10:38 -0400
In-Reply-To: <483C8328.1030807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Convert the System-on-Chip flag from a host flag to an hpriv flag,
> for better consistency with other chip-rev flags, and for easier use
> in errata fixes etc.
> 
> Also change the related "HAS_PCI()" into "!IS_SOC()" for better consistency
> of naming/use (everything else SOC-related already uses "SOC").
> 
> There are no functionality changes in this patch.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> This is the first of three patches aimed at fixing/completing
> various PHY_MODEx register errata workarounds.
> 

applied 1-5


