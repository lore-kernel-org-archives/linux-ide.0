From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] libata: Kill unused ATA_DFLAG_{H|D}IPM flags
Date: Wed, 16 Mar 2011 11:14:25 +0100
Message-ID: <20110316101425.GB1752@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56453 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1CPKOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2011 06:14:36 -0400
Received: by fxm17 with SMTP id 17so1479081fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2011 03:14:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Stefan Bader <stefan.bader@canonical.com>

ATA_DFLAG_{H|D}IPM flags are no longer used.  Kill them.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/libata.h |    2 --
 1 file changed, 2 deletions(-)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -137,8 +137,6 @@ enum {
 	ATA_DFLAG_ACPI_PENDING	= (1 << 5), /* ACPI resume action pending */
 	ATA_DFLAG_ACPI_FAILED	= (1 << 6), /* ACPI on devcfg has failed */
 	ATA_DFLAG_AN		= (1 << 7), /* AN configured */
-	ATA_DFLAG_HIPM		= (1 << 8), /* device supports HIPM */
-	ATA_DFLAG_DIPM		= (1 << 9), /* device supports DIPM */
 	ATA_DFLAG_DMADIR	= (1 << 10), /* device requires DMADIR */
 	ATA_DFLAG_CFG_MASK	= (1 << 12) - 1,
 
