From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] module ide-pnp
Date: Sat, 19 Jun 2004 12:43:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040619104316.GA30619@lst.de>
References: <20040619103546.GA30487@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([212.34.189.10]:52902 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265482AbUFSKnS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jun 2004 06:43:18 -0400
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i5JAhGQc030637
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-ide@vger.kernel.org>; Sat, 19 Jun 2004 12:43:16 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i5JAhG8d030635
	for linux-ide@vger.kernel.org; Sat, 19 Jun 2004 12:43:16 +0200
Content-Disposition: inline
In-Reply-To: <20040619103546.GA30487@lst.de>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sat, Jun 19, 2004 at 12:35:46PM +0200, Christoph Hellwig wrote:
> This patch allows compile ide-pnp as a module.  The original patch is
> from Herbert Xu through the Debian kernel package, but I reworked it
> significantly.

oops, makefile bits missing:


--- 1.21/drivers/ide/Makefile	2004-06-18 08:43:53 +02:00
+++ edited/drivers/ide/Makefile	2004-06-19 12:42:49 +02:00
@@ -23,7 +23,6 @@
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from arm/
 ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
@@ -44,6 +43,7 @@
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
