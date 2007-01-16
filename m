From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 3/4] libata-sff.c: add another IRQ calls
Date: Tue, 16 Jan 2007 19:46:23 +0900
Message-ID: <200701161046.l0GAkEOn019773@toshiba.co.jp>
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

When enabling IRQ, ap->ops->irq_on is checked.
Because most drivers can use ata_irq_on() as is, this
patch allows ap->ops->irq_on to be NULL.
If it is NULL, ata_irq_on() are used.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-sff.c.orig	2007-01-17 01:45:56.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-sff.c	2007-01-17 02:16:00.000000000 +0900
@@ -724,8 +724,12 @@ void ata_bmdma_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr) {	/* FIXME: hack. create a hook instead */
+		if (ap->ops->irq_on)
+			ap->ops->irq_on(ap);
+		else
+			ata_irq_on(ap);
+	}
 }
 
 /**
