From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 18 Dec 2007 16:58:08 -0500
Message-ID: <47684270.5030405@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com> <1196610199229-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524AbXLRV6K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:58:10 -0500
In-Reply-To: <1196610199229-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

saeed.bishara@gmail.com wrote:
> From: Saeed Bishara <saeed@marvell.com>
> 
> The integrated SATA controller is connected directly to the SoC's
> internal bus, not via PCI interface. this patch removes the dependency
> on the PCI interface.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/Kconfig   |    2 +-
>  drivers/ata/sata_mv.c |  113 ++++++++++++++++++++++++++++++-------------------
>  2 files changed, 71 insertions(+), 44 deletions(-)

oh, since Mark Lord is also touching the sata_mv driver, it would be a 
courtesy to CC him ...


