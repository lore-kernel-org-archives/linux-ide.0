From: jarkap@poczta.onet.pl
Subject: libata-core error handling
Date: Wed, 10 May 2006 14:45:03 -0400
Message-ID: <20060510184503.GA4852@jarkap.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bv170.internetdsl.tpnet.pl ([80.53.205.170]:27027 "EHLO
	jarkap.dom.local") by vger.kernel.org with ESMTP id S964944AbWEJMoj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 08:44:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello!

I'd like to suggest some minor changes to improve error reporting
in libata_core.c function ata_device_add().

I had terrible time to find the reason of kernel oops after
enabling in config ACPI without X86_LOCAL_APIC (by the way -
I don't understand why acpi irq routing is used then).

As it turned out messages from libata are very misleading,
because it tries to unregister too much and they cover on the
screen real reasons (bad irq request). No need to tell this
messages aren't added to logs.

I enclose this small diff, which was prepared with kernel
version 2.6.15.4, but it applied to 2.6.16-6 and 2.6.17-rc3
as well. 

Best regards from Poland,

Jarek P.


--- libata-core.c-	2006-02-10 02:22:48.000000000 -0500
+++ libata-core.c	2006-04-23 22:30:14.000000000 -0400
@@ -4357,8 +4357,11 @@
 
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			DRV_NAME, host_set))
+			DRV_NAME, host_set)) {
+		printk(KERN_ERR "ata: unable to allocate irq %lu\n",
+			ent->irq);
 		goto err_out;
+	}
 
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
@@ -4406,9 +4409,14 @@
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
 
+/* FIXME: goto after scsi_add_host
+ * err_out_remove:
+ *	for (i = 0; i < count; i++) {
+ *		ata_host_remove(host_set->ports[i], 1);
+ *	}
+ */
 err_out:
 	for (i = 0; i < count; i++) {
-		ata_host_remove(host_set->ports[i], 1);
 		scsi_host_put(host_set->ports[i]->host);
 	}
 err_free_ret:
