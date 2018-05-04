From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] alim15x3: move irq-restore before pci_dev_put()
Date: Fri,  4 May 2018 16:24:43 +0200
Message-ID: <20180504142446.30525-2-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504142446.30525-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-ide@vger.kernel.org

init_chipset_ali15x3() initializes the chipset during init with disabled
interrupts. There is no need to keep the interrupts disabled during
pci_dev_put().
Move the irq-restore before pci_dev_put() is invoked.

Side note: The same init is performed in
drivers/ata/pata_ali.c::ali_init_chipset() without disabled interrupts.
It looks that the same hardware is supported in the ATA land. Would it
make sense to remove this driver since it is supported in the other
subsystem?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/alim15x3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 36f76e28a0bf..3265970aee34 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -323,9 +323,9 @@ static int init_chipset_ali15x3(struct pci_dev *dev)
=20
 		pci_write_config_byte(dev, 0x53, tmpbyte);
 	}
+	local_irq_restore(flags);
 	pci_dev_put(north);
 	pci_dev_put(isa_dev);
-	local_irq_restore(flags);
 	return 0;
 }
=20
--=20
2.17.0
