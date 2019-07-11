Return-Path: <SRS0=9bcD=VI=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E604C74A36
	for <linux-ide@archiver.kernel.org>; Thu, 11 Jul 2019 00:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2319A20844
	for <linux-ide@archiver.kernel.org>; Thu, 11 Jul 2019 00:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGKA0b (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:26:31 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45952 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfGKA0b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jul 2019 20:26:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id DAB0F297D3;
        Wed, 10 Jul 2019 20:26:27 -0400 (EDT)
Date:   Thu, 11 Jul 2019 10:26:27 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
cc:     Stan <userm57@yahoo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pata-macio on PowerBook G3: stuck interrupt with MATSHITA CR-174
 CD-ROM
In-Reply-To: <alpine.LNX.2.21.1906271717080.68@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1906291014050.119@nippy.intranet>
References: <alpine.LNX.2.21.1906271717080.68@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 28 Jun 2019, Finn Thain wrote:

> Hi All,
> 
> I've received a bug report concerning the pata-macio driver, when running 
> on a PowerBook G3 (Wallstreet).
> 
> With CONFIG_PATA_MACIO=n && CONFIG_BLK_DEV_IDE_PMAC=y, everything works.
> 
> With CONFIG_PATA_MACIO=y && CONFIG_BLK_DEV_IDE_PMAC=n, the CD-ROM fails.
> 
> When the CD-ROM mediabay module is swapped for a DVD-ROM mediabay module, 
> everything works (either pata-macio or ide-pmac driver works fine).
> 
> I'm not familiar with ATA device drivers or the "Heathrow" chipset and its 
> ATA interfaces so any hints as to how to debug this would be appreciated.
> 
...
> 
> These logs are from v4.20 but the problem is the same in v5.2-rc2.
> 

In the linux-ide list archive I found the same bug reported in 2.6.33-rc2, 
shortly after the pata-macio driver was merged.

https://lore.kernel.org/linux-ide/19254.17766.674348.933702@pilspetsen.it.uu.se/

That report also involves a Matshita CD-ROM and a Heathrow controller 
(beige G3).

In that thread Ben suggested that the cause may be a firmware bug in the 
drive. Is there a quirk or other workaround for that kind of bug?

I tried removing the controller reset but there was no improvement...

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 57f2ec71cfc3..b2fd5e20367f 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1096,7 +1096,7 @@ static int pata_macio_common_init(struct pata_macio_priv *priv,
 	priv->host->ports[0]->private_data = priv;
 
 	/* hard-reset the controller */
-	pata_macio_reset_hw(priv, 0);
+//	pata_macio_reset_hw(priv, 0);
 	pata_macio_apply_timings(priv->host->ports[0], 0);
 
 	/* Enable bus master if necessary */

-- 
