From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/21] ide-mpc8xx: convert to use ide_timing_find_mode()
Date: Wed, 28 May 2008 23:43:05 +0200
Message-ID: <20080528214305.16327.52161.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:51381 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950AbYE1Vpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:45:31 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394678mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:45:29 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Also fix (disabled) debugging code while at it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/mpc8xx.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -89,7 +89,7 @@ ide_ioport_desc_t ioport_dsc[MAX_HWIFS] 
 #endif	/* IDE0_BASE_OFFSET */
 };
 
-ide_pio_timings_t ide_pio_clocks[6];
+struct ide_timing ide_pio_clocks[6];
 int hold_time[6] =  {30, 20, 15, 10, 10, 10 };   /* PIO Mode 5 with IORDY (nonstandard) */
 
 /*
@@ -200,30 +200,23 @@ static int __init m8xx_ide_init_ports(hw
 		/* Compute clock cycles for PIO timings */
 		for (i=0; i<6; ++i) {
 			bd_t	*binfo = (bd_t *)__res;
+			struct ide_timing *t, *n;
 
 			hold_time[i]   =
 				PCMCIA_MK_CLKS (hold_time[i],
 						binfo->bi_busfreq);
-			ide_pio_clocks[i].setup_time  =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].setup_time,
-						binfo->bi_busfreq);
-			ide_pio_clocks[i].active_time =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].active_time,
-						binfo->bi_busfreq);
-			ide_pio_clocks[i].cycle_time  =
-				PCMCIA_MK_CLKS (ide_pio_timings[i].cycle_time,
-						binfo->bi_busfreq);
+
+			t = ide_timing_find_mode(XFER_PIO_0 + i);
+			n = &ide_pio_clocks[i];
+
+			n->setup  = PCMCIA_MK_CLKS(t->setup,  binfo->bi_busfreq);
+			n->active = PCMCIA_MK_CLKS(t->active, binfo->bi_busfreq);
+			n->cycle  = PCMCIA_MK_CLKS(t->cycle,  binfo->bi_busfreq);
 #if 0
 			printk ("PIO mode %d timings: %d/%d/%d => %d/%d/%d\n",
 				i,
-				ide_pio_clocks[i].setup_time,
-				ide_pio_clocks[i].active_time,
-				ide_pio_clocks[i].hold_time,
-				ide_pio_clocks[i].cycle_time,
-				ide_pio_timings[i].setup_time,
-				ide_pio_timings[i].active_time,
-				ide_pio_timings[i].hold_time,
-				ide_pio_timings[i].cycle_time);
+				t->setup, t->active, t->cycle,
+				n->setup, n->active, n->cycle);
 #endif
 		}
 	}
@@ -404,8 +397,8 @@ static void m8xx_ide_set_pio_mode(ide_dr
 	mask = ~(PCMCIA_SHT(0xFF) | PCMCIA_SST(0xFF) | PCMCIA_SL(0xFF));
 
 	timing  = PCMCIA_SHT(hold_time[pio]  )
-		| PCMCIA_SST(ide_pio_clocks[pio].setup_time )
-		| PCMCIA_SL (ide_pio_clocks[pio].active_time)
+		| PCMCIA_SST(ide_pio_clocks[pio].setup)
+		| PCMCIA_SL (ide_pio_clocks[pio].active)
 		;
 
 #if 1
