From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/5] libata-dev: Add back missing dev->cdb_len = 16
Date: Fri, 10 Mar 2006 23:38:26 +0800
Message-ID: <44119D72.7040902@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:11453 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751577AbWCJPi0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 10:38:26 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2AFcKRS013507
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 10:38:20 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2AFZYva209806
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:35:34 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2AFcJqh031431
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:38:19 -0700
In-Reply-To: <44119BC9.8080502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Add back missing dev->cdb_len = 16 in ata_dev_identify().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

---
Originally done in Tejun's patch.
Add back to make hard drive probed.

--- irq-pio/drivers/scsi/libata-core.c	2006-03-10 16:03:36.000000000 +0800
+++ catchup0/drivers/scsi/libata-core.c	2006-03-10 18:18:04.000000000 +0800
@@ -1143,6 +1143,7 @@ static void ata_dev_identify(struct ata_
 				ap->id, device, dev->multi_count);
 		}
 
+		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */


