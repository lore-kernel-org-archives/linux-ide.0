From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] libata: Implement ATA_FLAG_NO_DIPM and apply it to
 mcp65
Date: Wed, 16 Mar 2011 11:14:55 +0100
Message-ID: <20110316101455.GC1752@htj.dyndns.org>
References: <20110316101425.GB1752@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44593 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab1CPKPN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2011 06:15:13 -0400
Received: by fxm17 with SMTP id 17so1479454fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2011 03:15:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316101425.GB1752@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Stefan Bader <stefan.bader@canonical.com>

NVIDIA mcp65 familiy of controllers cause command timeouts when DIPM
is used.  Implement ATA_FLAG_NO_DIPM and apply it.

This problem was reported by Stefan Bader in the following thread.

 http://thread.gmane.org/gmane.linux.ide/48841

stable: applicable to 2.6.37 and 38.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Stefan Bader <stefan.bader@canonical.com>
Cc: stable@kernel.org
---
 drivers/ata/ahci.c      |    2 +-
 drivers/ata/libata-eh.c |    6 ++++--
 include/linux/libata.h  |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -150,7 +150,7 @@ static const struct ata_port_info ahci_p
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
-		.flags		= AHCI_FLAG_COMMON,
+		.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -3276,6 +3276,7 @@ static int ata_eh_set_lpm(struct ata_lin
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
 	enum ata_lpm_policy old_policy = link->lpm_policy;
+	bool no_dipm = ap->flags & ATA_FLAG_NO_DIPM;
 	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
 	unsigned int err_mask;
 	int rc;
@@ -3292,7 +3293,7 @@ static int ata_eh_set_lpm(struct ata_lin
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
 		bool hipm = ata_id_has_hipm(dev->id);
-		bool dipm = ata_id_has_dipm(dev->id);
+		bool dipm = ata_id_has_dipm(dev->id) && !no_dipm;
 
 		/* find the first enabled and LPM enabled devices */
 		if (!link_dev)
@@ -3349,7 +3350,8 @@ static int ata_eh_set_lpm(struct ata_lin
 
 	/* host config updated, enable DIPM if transitioning to MIN_POWER */
 	ata_for_each_dev(dev, link, ENABLED) {
-		if (policy == ATA_LPM_MIN_POWER && ata_id_has_dipm(dev->id)) {
+		if (policy == ATA_LPM_MIN_POWER && !no_dipm &&
+		    ata_id_has_dipm(dev->id)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -201,6 +201,7 @@ enum {
 					      * management */
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
 					      * led */
+	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
