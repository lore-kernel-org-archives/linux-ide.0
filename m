From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH 5/7] ATA: remove excess kernel-doc notation
Date: Wed, 29 Oct 2008 22:35:08 -0700
Message-ID: <20081029223508.c824f8dc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:47190 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbYJ3FgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Oct 2008 01:36:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Remove excess kernel-doc function parameter notation from drivers/ata/:

Warning(drivers/ata/libata-core.c:1622): Excess function parameter or struct member 'fn' description in 'ata_pio_queue_task'
Warning(drivers/ata/libata-core.c:4655): Excess function parameter or struct member 'err_mask' description in 'ata_qc_complete'
Warning(drivers/ata/ata_piix.c:751): Excess function parameter or struct member 'udma' description in 'do_pata_set_dmamode'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/ata_piix.c    |    1 -
 drivers/ata/libata-core.c |    2 --
 2 files changed, 3 deletions(-)

--- lin2628-rc2.orig/drivers/ata/ata_piix.c
+++ lin2628-rc2/drivers/ata/ata_piix.c
@@ -738,7 +738,6 @@ static void piix_set_piomode(struct ata_
  *	do_pata_set_dmamode - Initialize host controller PATA PIO timings
  *	@ap: Port whose timings we are configuring
  *	@adev: Drive in question
- *	@udma: udma mode, 0 - 6
  *	@isich: set if the chip is an ICH device
  *
  *	Set UDMA mode for device, in host controller PCI config space.
--- lin2628-rc2.orig/drivers/ata/libata-core.c
+++ lin2628-rc2/drivers/ata/libata-core.c
@@ -1602,7 +1602,6 @@ unsigned long ata_id_xfermask(const u16 
 /**
  *	ata_pio_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
- *	@fn: workqueue function to be scheduled
  *	@data: data for @fn to use
  *	@delay: delay time in msecs for workqueue function
  *
@@ -4643,7 +4642,6 @@ static void ata_verify_xfer(struct ata_q
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
- *	@err_mask: ATA Status register contents
  *
  *	Indicate to the mid and upper layers that an ATA
  *	command has completed, with either an ok or not-ok status.
