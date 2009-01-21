From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] libata: fix kernel-doc warnings
Date: Tue, 20 Jan 2009 16:28:59 -0800
Message-ID: <20090120162859.022628c1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:31132 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875AbZAUA30 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jan 2009 19:29:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata kernel-doc warnings:

Warning(linux-next-20090120//drivers/ata/libata-core.c:4720): Excess function parameter 'dev' description in 'ata_qc_new'
Warning(linux-next-20090120//drivers/ata/libata-scsi.c:428): No description found for parameter 'ap'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-core.c |    3 +--
 drivers/ata/libata-scsi.c |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20090120.orig/drivers/ata/libata-core.c
+++ linux-next-20090120/drivers/ata/libata-core.c
@@ -4709,8 +4709,7 @@ void swap_buf_le16(u16 *buf, unsigned in
 
 /**
  *	ata_qc_new - Request an available ATA command, for queueing
- *	@ap: Port associated with device @dev
- *	@dev: Device from whom we request an available command structure
+ *	@ap: target port
  *
  *	LOCKING:
  *	None.
--- linux-next-20090120.orig/drivers/ata/libata-scsi.c
+++ linux-next-20090120/drivers/ata/libata-scsi.c
@@ -414,6 +414,7 @@ int ata_std_bios_param(struct scsi_devic
 
 /**
  *	ata_get_identity - Handler for HDIO_GET_IDENTITY ioctl
+ *	@ap: target port
  *	@sdev: SCSI device to get identify data for
  *	@arg: User buffer area for identify data
  *
