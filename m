From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2 v3] sata_mv: Support SoC controllers
Date: Fri, 01 Feb 2008 18:08:47 -0500
Message-ID: <47A3A67F.4010503@garzik.org>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com> <12017334492566-git-send-email-saeed.bishara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33596 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030AbYBAXIu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 18:08:50 -0500
In-Reply-To: <12017334492566-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed.bishara@gmail.com
Cc: linux-ide@vger.kernel.org, saeed@marvell.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>

saeed.bishara@gmail.com wrote:
> From: Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>
> 
> Marvell's Orion SoC includes SATA controllers based on Marvell's
> PCI-to-SATA 88SX controllers. This patch extends the libATA sata_mv
> driver to support those controllers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c   |  365 +++++++++++++++++++++++++++++++++++++++++------
>  include/linux/sata_mv.h |   21 +++
>  2 files changed, 341 insertions(+), 45 deletions(-)
>  create mode 100644 include/linux/sata_mv.h

applied, after editing to use linux/ata_platform.h (renamed from 
linux/pata_platform.h)


