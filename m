From: Tejun Heo <tj@kernel.org>
Subject: Re: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Wed, 2 Mar 2016 10:25:59 -0500
Message-ID: <20160302152559.GA4282@mtj.duckdns.org>
References: <56CF75E6.5070803@gmail.com>
 <20160225215130.GK6092@mtj.duckdns.org>
 <56CF77CE.2040204@gmail.com>
 <CAOS58YNe5Jw-OiDHs6t-uUN8n0c-8LkJYFbVLQ4TjGtMtsTJgw@mail.gmail.com>
 <56D6A86C.9070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33818 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbcCBP0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2016 10:26:01 -0500
Received: by mail-yw0-f169.google.com with SMTP id h129so179295879ywb.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2016 07:26:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56D6A86C.9070007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carolin Latze <carolin.latze@gmail.com>
Cc: Hans De Goede <hdegoede@redhat.com>, linux-ide <linux-ide@vger.kernel.org>

Hello, Carolin.

On Wed, Mar 02, 2016 at 09:46:36AM +0100, Carolin Latze wrote:
> please see attached screen capture. If there is any better way to capture
> those logs than taking pictures, please let me know

Heh, so there have been quite a few cases where device locks up after
a lot of NCQ commands are issued and/or data transfer is taking place
at high rate but device locking up on plain WRITE_DMA_EXT is pretty
new.  Hmmm.... Does the following patch make any difference?

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 45586c1..95c4d5c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -366,8 +366,8 @@ extern struct device_attribute *ahci_sdev_attrs[];
 #define AHCI_SHT(drv_name)						\
 	ATA_NCQ_SHT(drv_name),						\
 	.can_queue		= AHCI_MAX_CMDS - 1,			\
-	.sg_tablesize		= AHCI_MAX_SG,				\
-	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
+	.sg_tablesize		= LIBATA_MAX_PRD,			\
+	.dma_boundary		= ATA_DMA_BOUNDARY			\
 	.shost_attrs		= ahci_shost_attrs,			\
 	.sdev_attrs		= ahci_sdev_attrs
 
