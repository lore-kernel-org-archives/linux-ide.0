From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata PIO fixes (revised)
Date: Mon, 01 Aug 2005 22:54:35 +0800
Message-ID: <42EE37AB.2000006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:25084 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261288AbVHAOyq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Aug 2005 10:54:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Jeff,

The PIO fixes revised according to the previous reviews.

1/3 pio1.diff:
   - Modify the "if conditions" in __atapi_pio_bytes() to be more robust.

2/3 pio2.diff:
   - Add ATA_FLAG_IO_32BIT to libata.h for hosts with 32-bit data register.
   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle buffer with length
     not aligned to 32-bit boundary.

3/3 pio3.diff:
   - Modify __atapi_pio_bytes() to handle the case when device returns/needs extra data.

(Patch diff'ed against 2.6.13-rc4 tree, 02459eaab98a6a57717bc0cacede148fc76af881)

Tested ok on x86 with Promise PDC20275 and LG DVD-Multi drive.

For your review and advice, thanks.

Albert




