From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/14] sata_mv Add want_ncq parameter for EDMA configuration
Date: Fri, 25 Jan 2008 23:18:51 -0500
Message-ID: <479AB4AB.8050704@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FC67.2040103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39449 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbYAZESx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:18:53 -0500
In-Reply-To: <4798FC67.2040103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv Add want_ncq parameter for EDMA configuration.
> 
> An extra EDMA config bit is required for NCQ operation.
> So set/clear it as needed, and cache current setting in port_priv.
> For now though, it will always be "off" (0).
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

ACK, though from a personal taste perspective, I would probably have 
combined this with other NCQ changes further down the line

Not a complaint... just an observation


