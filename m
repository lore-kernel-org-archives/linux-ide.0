From: Kurt Wall <kwall@kurtwerks.com>
Subject: Fix make mandocs for ata_piix.c
Date: Mon, 30 Jan 2006 22:31:24 -0500
Message-ID: <20060131033124.GQ1501@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spooner.celestial.com ([192.136.111.35]:31199 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030303AbWAaDZS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Jan 2006 22:25:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

"make mandocs" complains when on ata_piix.c because
piix_check_450nx_errata() has undescribed parameters. This patch silences
this warning by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- ./linux-2.6.16-rc1/drivers/scsi/ata_piix.c.orig	2006-01-30 21:24:16.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/ata_piix.c	2006-01-30 22:30:39.000000000 -0500
@@ -624,6 +624,7 @@
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: ATA device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
-- 
Finagle's First Law:
	If an experiment works, something has gone wrong.
