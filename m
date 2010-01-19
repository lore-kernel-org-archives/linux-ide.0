From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 25/64] ide: use standard timing for XFER_PIO_SLOW mode in ide_timing_compute()
Date: Tue, 19 Jan 2010 16:09:42 +0100
Message-ID: <201001191609.42582.bzolnier@gmail.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171729.14623.46024.sendpatchset@localhost> <20100119.012526.203639880.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754089Ab0ASPL4@vger.kernel.org>
In-Reply-To: <20100119.012526.203639880.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 19 January 2010 10:25:26 am David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Mon, 18 Jan 2010 18:17:29 +0100
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: use standard timing for XFER_PIO_SLOW mode in ide_timing_compute()
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Applied.

Thanks.

Here is a bonus fixup for a small issue noticed by Sergei yesterday.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: ide_timing_compute() fixup

XFER_SW_DMA_0 mode should be excluded from the extended cycle
timing computations.

[ This is just a documentation fix -- code inside the affected
  'if' block already makes sure to accept only PIO modes. ]

Noticed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timings.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-timings.c
===================================================================
--- a/drivers/ide/ide-timings.c
+++ b/drivers/ide/ide-timings.c
@@ -166,7 +166,7 @@ int ide_timing_compute(ide_drive_t *driv
 	if (id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE drive */
 		memset(&p, 0, sizeof(p));
 
-		if (speed >= XFER_PIO_0 && speed <= XFER_SW_DMA_0) {
+		if (speed >= XFER_PIO_0 && speed < XFER_SW_DMA_0) {
 			if (speed <= XFER_PIO_2)
 				p.cycle = p.cyc8b = id[ATA_ID_EIDE_PIO];
 			else if ((speed <= XFER_PIO_4) ||
