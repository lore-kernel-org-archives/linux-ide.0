From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] libata: PIO race condition fixes
Date: Thu, 23 Jun 2005 16:48:27 +0800
Message-ID: <42BA775B.1050601@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:51182 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262681AbVFWIvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2005 04:51:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Jeff,

Two more libata misc patches for your review.

1. Fix race condition in ata_pio_task().
2. Remove 'case ATA_PROT_ATAPI' in the ata_host_intr() interrupt handler.


Albert


