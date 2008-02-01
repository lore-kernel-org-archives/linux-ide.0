From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 v3] sata_mv: Remove PCI dependency
Date: Fri, 01 Feb 2008 11:50:38 -0500
Message-ID: <47A34DDE.80502@garzik.org>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59223 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbYBAQul (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 11:50:41 -0500
In-Reply-To: <1201733446499-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, saeed@marvell.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>

saeed.bishara@gmail.com wrote:
> From: Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>
> 
> The integrated SATA controller is connected directly to the SoC's
> internal bus, not via PCI interface. this patch removes the dependency
> on the PCI interface.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/Kconfig   |    2 +-
>  drivers/ata/sata_mv.c |  132 +++++++++++++++++++++++++++---------------------
>  2 files changed, 75 insertions(+), 59 deletions(-)

applied, thanks for your patience



