From: Phillip Jordan <phillip.m.jordan@gmail.com>
Subject: [PATCH 2.6.16.4 2/2] sata_promise: alternative PATA support on pdc2037x
 without libata interface changes
Date: Fri, 21 Apr 2006 01:09:11 +0100
Message-ID: <444822A7.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.186]:36377 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932153AbWDUAJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Apr 2006 20:09:14 -0400
Received: by nproxy.gmail.com with SMTP id l24so244124nfc
        for <linux-ide@vger.kernel.org>; Thu, 20 Apr 2006 17:09:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Add support for PATA ports on pdc2037x SATA hardware, without changing
libata itself. This is an alternative to the patch by Erik Benada from
early 2005, which makes some libata interface changes.

Signed-off-by: Phil Jordan <phillip.m.jordan@gmail.com>

---
Notes:
* Based on current libata development branch and PATA support patch by
Erik Benada from early 2005, which still isn't in main kernel, AFAIK
because of the libata changes it requires
* To avoid the libata interface changes, set the PATA port in
pdc_port_start() callback instead of pdc_ata_init_one(). Consider this a
hack?
* Tested successfully on PDC20376 on the MSI K7N2G-ILSR motherboard in
various PATA/SATA drive attachment configurations

phil

--- sata_promise.c	2006-04-12 21:27:57.000000000 +0100
+++ sata_promise.c	2006-04-16 22:27:00.000000000 +0100
@@ -257,6 +258,18 @@ static int pdc_port_start(struct ata_por
 	struct pdc_port_priv *pp;
 	int rc;

+	/* If there are exactly three ports, the last one will be PATA, not
+	 * SATA. */
+	if (3 == ap->host_set->n_ports && 2 == ap->port_no) {
+		ap->flags &= (~ATA_FLAG_SATA);
+		ap->flags |= ATA_FLAG_SLAVE_POSS;
+		
+		/* perform PATA, not SATA operations on this port */
+		ap->ops = &pdc_pata_ops;
+		
+		printk(KERN_DEBUG DRV_NAME "Disabling SATA for third port\n");
+	}
+
 	rc = ata_port_start(ap);
 	if (rc)
 		return rc;
@@ -717,7 +744,27 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
 	case board_2037x:
-		probe_ent->n_ports = 2;
+		{
+			/* Some pdc2037x boards also have a PATA port */
+			u8 tmp = readb(mmio_base + PDC_FLASH_CTL+1);
+			if (!(tmp & 0x80))
+			{
+				probe_ent->n_ports = 3;
+				
+				pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+				
+				/* HACK! Since this is a mixed-mode
+				 * SATA/PATA adapter, and libata doesn't allow
+				 * us to provide per-port flags and port-ops,
+				 * pdc_port_start() has to change the PATA
+				 * port, rather than us being able to specify
+				 * the PATA-ness here. If anything in libata's
+				 * ata_device_add() changes, THIS MAY BREAK. */
+				printk(KERN_DEBUG DRV_NAME " PATA port found\n");
+			} else {
+				probe_ent->n_ports = 2;
+			}
+		}
 		break;
 	case board_20771:
 		probe_ent->n_ports = 2;

