From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: set IRQF_SHARED for legacy PCI IDE IRQs
Date: Fri, 17 Nov 2006 16:22:27 +0900
Message-ID: <20061117072227.GG2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:31623 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1755527AbWKQHWg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 02:22:36 -0500
Received: by py-out-1112.google.com with SMTP id a29so472544pyi
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 23:22:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

There are machines out there which share legacy PCI IDE IRQs w/ other
devices.  libata SFF interrupt/HSM code is ready for shared IRQ and
has been setting IRQF_SHARED for devices in native PCI mode.  Device
in legacy mode is still a PCI device and thus supposedly uses
active-low level triggered IRQ.

Machines with such setup should be quite rare and w/o this flag libata
is likely to fail loading and render the system unuseable.  Also, IDE
driver has been setting IRQF_SHARED for devices in legacy mode for a
looooong time.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, I couldn't find a generic way to check whether an IRQ is
confiured as level or edge.  All these legacy mess are pretty much for
the BIOS to figure out, so let's just do what IDE has been doing.

Thanks.

 drivers/ata/libata-sff.c |    1 +
 1 file changed, 1 insertion(+)

Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -911,6 +911,7 @@ static struct ata_probe_ent *ata_pci_ini
 		return NULL;
 
 	probe_ent->n_ports = 2;
+	probe_ent->irq_flags = IRQF_SHARED;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
 		probe_ent->irq = ATA_PRIMARY_IRQ;

