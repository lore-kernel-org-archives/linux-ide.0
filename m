From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Wed, 15 Apr 2009 00:00:54 +0400
Message-ID: <20090414200054.GB17134@orion>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com> <49E47A45.60902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:37638 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZDNUBJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 16:01:09 -0400
Received: by ti-out-0910.google.com with SMTP id 11so336446tim.23
        for <linux-ide@vger.kernel.org>; Tue, 14 Apr 2009 13:01:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49E47A45.60902@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, Apr 14, 2009 at 07:57:57AM -0400, Jeff Garzik wrote:
> Alexander Beregalov wrote:
> > ECC initialization takes too long. It writes zeroes by portions of 4
> > byte, it takes more than 6 minutes to initialize 512Mb DIMM module.
> > Change portion to 1Mb.
> > 
> > before:
> > [10857.207576] pdc20621_dimm_init: Start ECC initialization
> > [11235.333118] pdc20621_dimm_init: Finish ECC initialization
> > 
> > after:
> > [ 1005.126437] pdc20621_dimm_init: Local DIMM Speed = 100
> > [ 1005.128111] pdc20621_dimm_init: Local DIMM Size = 512MB
> > [ 1005.133508] Local DIMM ECC Enabled
> > [ 1005.236482] pdc20621_dimm_init: Start ECC initialization
> > [ 1031.278098] pdc20621_dimm_init: Finish ECC initialization
> > 
> Comments:
> 
> 1) on an older machine, where these things might be found, 1MB might be 
> a lot -- particularly if there is a lot of VM fragmentation.  Please 
> reduce the size a bit -- I suppose 128k is not unbearably slow?
> 
> 2) Rather than repeating 'page size * 32' calculation multiple times, 
> put it into a named constant somewhere.
> 
> Other than that, looks ok!


>From 00e980a4651ef12811fbe9a893a7e72510b955d1 Mon Sep 17 00:00:00 2001
From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Tue, 14 Apr 2009 23:55:52 +0400
Subject: [PATCH v2] sata_sx4: speed up ECC initialization

ECC initialization takes too long. It writes zeroes by portions
of 4 byte, it takes more than 6 minutes on my machine to initialize
512Mb ECC DIMM module. Change portion to 128Kb - it significantly
reduces initialization time.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 drivers/ata/sata_sx4.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index dce3dcc..197a4d7 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -193,6 +193,7 @@ enum {
 					  PDC_TIMER_MASK_INT,
 };
 
+#define ECC_ERASE_BUF 128 * 1024;
 
 struct pdc_port_priv {
 	u8			dimm_buf[(ATA_PRD_SZ * ATA_MAX_PRD) + 512];
@@ -1208,7 +1209,6 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 {
 	int speed, size, length;
 	u32 addr, spd0, pci_status;
-	u32 tmp = 0;
 	u32 time_period = 0;
 	u32 tcount = 0;
 	u32 ticks = 0;
@@ -1323,14 +1323,17 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			  PDC_DIMM_SPD_TYPE, &spd0);
 	if (spd0 == 0x02) {
+		void *buf;
 		VPRINTK("Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
+		buf = kzalloc(ECC_ERASE_BUF, GFP_KERNEL);
 		while (addr < length) {
-			pdc20621_put_to_dimm(host, (void *) &tmp, addr,
-					     sizeof(u32));
-			addr += sizeof(u32);
+			pdc20621_put_to_dimm(host, buf, addr,
+					     ECC_ERASE_BUF);
+			addr += ECC_ERASE_BUF;
 		}
+		kfree(buf);
 		VPRINTK("Finish ECC initialization\n");
 	}
 	return 0;
-- 
1.6.2.3

