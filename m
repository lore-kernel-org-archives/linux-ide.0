From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Sparse warning in AHCI
Date: Mon, 8 Sep 2008 09:28:01 -0700
Message-ID: <20080908092801.474aa23c@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vyatta.com ([216.93.170.194]:48324 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbYIHQ2F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:28:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Not sure how you want to fix this:

  CHECK   drivers/acpi/pci_irq.c
drivers/ata/ahci.c:323:2: warning: Initializer entry defined twice
drivers/ata/ahci.c:324:3:   also defined here

This happens because macro ATA_BASE_SHT(drv_name) defines .can_queue
then then later in the initializer for ahci_sht, it gets redefined.

Granted it probably works now, but sparse is correct to complain that
this is bad usage.
