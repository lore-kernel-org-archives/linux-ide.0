From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/5] libata-dev: irq-pio minor fixes
Date: Fri, 10 Mar 2006 23:31:21 +0800
Message-ID: <44119BC9.8080502@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:18341 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751383AbWCJPbv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Mar 2006 10:31:51 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2AFVLDV004826
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 10:31:21 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2AFSava209868
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:28:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2AFVKG0004081
	for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 08:31:21 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Minor fixes for irq-pio to catch up with upstream.

Changes:
1/5: Add back missing dev->cdb_len = 16
2/5: Make dev->id dynamically allocated
3/5: Remove ata_dev_identify(), ata_dev_config() and ata_bus_probe().
4/5: Add back ata_dev_configure(), ata_bus_probe(), ata_dev_same_device() and ata_dev_revalidate().
5/5: Add back irq-pio patches, etc.

Patch against the irq-pio branch (c2956a3b0d1c17b38da369811a6ce93eb7a01a04). 

For your review, thanks,

Albert

