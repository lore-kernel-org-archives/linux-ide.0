From: Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH] m68k/atari - ide: do not register interrupt if host->get_lock is set
Date: Sat,  1 Feb 2014 13:48:13 +1300
Message-ID: <1391215693-2880-2-git-send-email-schmitz@debian.org>
References: <1391215693-2880-1-git-send-email-schmitz@debian.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1391215693-2880-1-git-send-email-schmitz@debian.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org, davem@davemloft.net, linux-ide@vger.kernel.org, Michael Schmitz <schmitz@debian.org>
List-Id: linux-ide@vger.kernel.org

On m68k, host->get_lock is used to both lock and register the interrupt
that the IDE host shares with other device drivers. Registering the
IDE interrupt handler in ide-probe.c results in duplicating the
interrupt registered (once via host->get lock, and also via init_irq()),
and may result in IDE accepting interrupts even when another driver has
locked the interrupt hardware. This opens the whole locking scheme up
to races.

host->get_lock is set on m68k only, so other drivers' behaviour is not
changed.

Signed-off-by: Michael Schmitz <schmitz@debian.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
---
 drivers/ide/ide-probe.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 2a744a9..a3d3b17 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -853,8 +853,9 @@ static int init_irq (ide_hwif_t *hwif)
 	if (irq_handler == NULL)
 		irq_handler = ide_intr;
 
-	if (request_irq(hwif->irq, irq_handler, sa, hwif->name, hwif))
-		goto out_up;
+	if (!host->get_lock)
+		if (request_irq(hwif->irq, irq_handler, sa, hwif->name, hwif))
+			goto out_up;
 
 #if !defined(__mc68000__)
 	printk(KERN_INFO "%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
@@ -1533,7 +1534,8 @@ static void ide_unregister(ide_hwif_t *hwif)
 
 	ide_proc_unregister_port(hwif);
 
-	free_irq(hwif->irq, hwif);
+	if (!hwif->host->get_lock)
+		free_irq(hwif->irq, hwif);
 
 	device_unregister(hwif->portdev);
 	device_unregister(&hwif->gendev);
-- 
1.7.0.4
