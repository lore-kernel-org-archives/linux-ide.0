From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 1/4] libata.h: add another IRQ calls
Date: Tue, 16 Jan 2007 19:46:07 +0900
Message-ID: <200701161045.l0GAjwDE009594@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-ide@vger.kernel.org

Two IRQ calls are added in ata_port_operations.
- irq_on() is used to enable interrupts. 
- irq_ack() is used to acknowledge a device interrupt.

And there are additional function declarations which are
used in pata_scc.c.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/include/linux/libata.h.orig	2007-01-17 01:46:12.000000000 +0900
+++ linux-2.6.20-rc4/include/linux/libata.h	2007-01-17 02:14:57.000000000 +0900
@@ -638,6 +638,8 @@ struct ata_port_operations {
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
+	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -761,6 +763,9 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
+struct ata_probe_ent *ata_probe_ent_alloc(struct device *,
+					  const struct ata_port_info *);
 
 /*
  * Default driver ops implementations
