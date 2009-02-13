From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/06] sata_mv: export ata_pio_queue_task()
Date: Fri, 13 Feb 2009 00:08:56 -0500
Message-ID: <49950068.9040705@rtr.ca>
References: <4994FF3D.90904@rtr.ca> <4994FF7C.2050607@rtr.ca> <4994FFA9.7030300@rtr.ca> <49950036.50509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46605 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZBMFI6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:08:58 -0500
In-Reply-To: <49950036.50509@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Export ata_pio_queue_task() so that it can be used from sata_mv.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/libata-core.c	2009-02-12 22:41:42.000000000 -0500
+++ upstream/drivers/ata/libata-core.c	2009-02-12 22:41:46.000000000 -0500
@@ -6707,6 +6707,7 @@
  EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
  EXPORT_SYMBOL_GPL(ata_scsi_simulate);

+EXPORT_SYMBOL_GPL(ata_pio_queue_task);
  EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
  EXPORT_SYMBOL_GPL(ata_timing_find_mode);
  EXPORT_SYMBOL_GPL(ata_timing_compute);
--- old/drivers/ata/libata.h	2009-02-12 19:58:00.000000000 -0500
+++ upstream/drivers/ata/libata.h	2009-02-12 22:43:16.000000000 -0500
@@ -79,8 +79,6 @@
  			   u64 block, u32 n_block, unsigned int tf_flags,
  			   unsigned int tag);
  extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
-extern void ata_pio_queue_task(struct ata_port *ap, void *data,
-			       unsigned long delay);
  extern void ata_port_flush_task(struct ata_port *ap);
  extern unsigned ata_exec_internal(struct ata_device *dev,
  				  struct ata_taskfile *tf, const u8 *cdb,
--- old/include/linux/libata.h	2009-02-12 19:58:07.000000000 -0500
+++ upstream/include/linux/libata.h	2009-02-12 22:43:24.000000000 -0500
@@ -1006,6 +1006,9 @@
  extern int ata_cable_ignore(struct ata_port *ap);
  extern int ata_cable_unknown(struct ata_port *ap);

+extern void ata_pio_queue_task(struct ata_port *ap, void *data,
+			       unsigned long delay);
+
  /* Timing helpers */
  extern unsigned int ata_pio_need_iordy(const struct ata_device *);
  extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
