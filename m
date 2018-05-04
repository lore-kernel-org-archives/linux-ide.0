From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] ide: Handle irq disabling consistently
Date: Fri,  4 May 2018 16:24:44 +0200
Message-ID: <20180504142446.30525-3-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-ide@vger.kernel.org

ide_timer_expiry() disables interrupt at function entry when acquiring
hwif->lock. Before disabling the device interrupt it unlocks hwif->lock,
but interrupts stay disabled. After the call to disable_irq() interrupts
are disabled again, which is a pointless exercise.

After the device irq handler has been invoked with interrupts disabled,
hwif->lock is acquired again with spin_lock_irq() because the device irq
handler might have reenabled interrupts. This is not documented and
confusing for the casual reader.

Remove the redundant local_irq_disable() and add a comment which explains
why hwif->lock has to be reacquired with spin_lock_irq().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/ide-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 6f25da56a169..a444bad7a2aa 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -659,8 +659,7 @@ void ide_timer_expiry (struct timer_list *t)
 		spin_unlock(&hwif->lock);
 		/* disable_irq_nosync ?? */
 		disable_irq(hwif->irq);
-		/* local CPU only, as if we were handling an interrupt */
-		local_irq_disable();
+
 		if (hwif->polling) {
 			startstop =3D handler(drive);
 		} else if (drive_is_ready(drive)) {
@@ -679,6 +678,7 @@ void ide_timer_expiry (struct timer_list *t)
 				startstop =3D ide_error(drive, "irq timeout",
 					hwif->tp_ops->read_status(hwif));
 		}
+		/* Disable interrupts again, `handler' might have enabled it */
 		spin_lock_irq(&hwif->lock);
 		enable_irq(hwif->irq);
 		if (startstop =3D=3D ide_stopped && hwif->polling =3D=3D 0) {
--=20
2.17.0
