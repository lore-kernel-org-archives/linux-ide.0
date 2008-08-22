From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: add the Gen IIE flag to the SoC devices.
Date: Fri, 22 Aug 2008 02:20:18 -0400
Message-ID: <48AE5AA2.6050601@garzik.org>
References: <12178507751128-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37288 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbYHVGUX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:20:23 -0400
In-Reply-To: <12178507751128-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: liml@rtr.ca, linux-ide@vger.kernel.org, buytenh@marvell.com

Saeed Bishara wrote:
> The SoC sata port is based on the 7042/6042 devices (Gen IIE). This patch
> will fix various issues when working with PMP and/or NCQ.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

applied


