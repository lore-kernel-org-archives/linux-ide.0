From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] pata_ns87415: Initial cut at 87415/87560 IDE support
Date: Wed, 26 Sep 2007 19:35:31 -0400
Message-ID: <20070926233531.GA22893@fattire.cabal.ca>
References: <20070926152731.718a5c74@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:41751 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbXIZXfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 19:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20070926152731.718a5c74@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Just some quick review and build test on PARISC.

On Wed, Sep 26, 2007 at 03:27:31PM +0100, Alan Cox wrote:
> +	tristate "Nat Semi NS87410 PATA support (Experimental)"

NS87415 shirley?

> + *    pata_ns87415.c - NS87415 (non PARISC) PATA
> + *	Test PARISC SuperIO

works fine. :)

> +static u8 ns87560_read_buggy(unsigned long port)
> +{
> +	int retries = SUPERIO_IDE_MAX_RETRIES;
> +	do {
> +		tmp = ioread8(port);
> +		if (tmp != 0)
> +			return tmp;
> +		udelay(50);
> +	} while(retries-- > 0);
> +	return tmp;
> +}

u8 tmp is undefined, and port should be void __iomem * if we're going to
use pci-iomap accessors.

Works good otherwise, I was able to mount and copy a cd. Patch attached.
Queued a patch to move SUPERIO_IDE_MAX_RETRIES to <asm/superio.h>.

Cheers,
	Kyle

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5a5e677..fb460a6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -433,7 +433,7 @@ config PATA_NS87410
 	  If unsure, say N.
 
 config PATA_NS87415
-	tristate "Nat Semi NS87410 PATA support (Experimental)"
+	tristate "Nat Semi NS87415 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the National Semiconductor
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 239628d..cfe4ef2 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -222,8 +222,9 @@ static int ns87415_check_atapi_dma(struct ata_queued_cmd *qc)
  *	Work around chipset problems in the 87560 SuperIO chip
  */
 
-static u8 ns87560_read_buggy(unsigned long port)
+static u8 ns87560_read_buggy(void __iomem *port)
 {
+	u8 tmp;
 	int retries = SUPERIO_IDE_MAX_RETRIES;
 	do {
 		tmp = ioread8(port);
