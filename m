From: Byron Bradley <byron.bbradley@gmail.com>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Fri, 8 Feb 2008 02:20:35 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0802080217070.16853@git.byronbradley.co.uk>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:34888 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762135AbYBHCUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 21:20:38 -0500
Received: by mu-out-0910.google.com with SMTP id i10so3978341mue.5
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 18:20:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed@marvell.com, linux-ide@vger.kernel.org, mlord@pobox.com, jeff@garzik.org, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, 8 Feb 2008, Byron Bradley wrote:

> I'm having problems getting the sata_mv driver working as a platform
> driver on the QNAP TS-209 and the Linkstation/Kurobox (both are Marvell
> Orion 88f5182 based devices). First of all it would oops in
> mv_port_start() while calling dma_pool_alloc(), the patch to fix this is
> at the end of this email.
>
> In mv_platform_probe() host->iomap is set to NULL but it is dereferenced
> in mv_start_dma(), I'm not sure what the fix for this is. This is based on
> the latest 2.6-git and a merge with the for-rmk branch of the orion git.

The following patch makes this driver work although I have no idea if this
is the correct thing to do. Will this be OK for other devices using this
driver? The pointer only works because it is dereferenced as
iomap[MV_PRIMARY_BAR] and MV_PRIMARY_BAR = 0, will another offset ever be
used in the future?

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 04b5717..b538ccc 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2950,8 +2950,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 	host->private_data = hpriv;
 	hpriv->n_ports = n_ports;

-	host->iomap = NULL;
 	hpriv->base = ioremap(res->start, res->end - res->start + 1);
+	host->iomap = &hpriv->base;
 	hpriv->base -= MV_SATAHC0_REG_BASE;

 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
