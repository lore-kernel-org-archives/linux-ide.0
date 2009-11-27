From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt3x2n: fix overclocked MWDMA0 timing
Date: Fri, 27 Nov 2009 19:56:55 +0100
Message-ID: <200911271956.55939.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753173AbZK0S6m@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

Remove superfluous timings table entry while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Sergei, XFER_UDMA_5 timing also looks suspicious,
please take a look when you have a minute, thanks.

 drivers/ata/pata_hpt3x2n.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ata/pata_hpt3x2n.c
===================================================================
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -80,14 +80,13 @@ static struct hpt_clock hpt3x2n_clocks[]
 
 	{	XFER_MW_DMA_2,	0x2c829c62	},
 	{	XFER_MW_DMA_1,	0x2c829c66	},
-	{	XFER_MW_DMA_0,	0x2c829d2c	},
+	{	XFER_MW_DMA_0,	0x2c829d2e	},
 
 	{	XFER_PIO_4,	0x0c829c62	},
 	{	XFER_PIO_3,	0x0c829c84	},
 	{	XFER_PIO_2,	0x0c829ca6	},
 	{	XFER_PIO_1,	0x0d029d26	},
 	{	XFER_PIO_0,	0x0d029d5e	},
-	{	0,		0x0d029d5e	}
 };
 
 /**
