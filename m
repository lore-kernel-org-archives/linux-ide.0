From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] libata PIO fixes (revised)
Date: Fri, 12 Aug 2005 14:09:51 +0800
Message-ID: <42FC3D2F.1030803@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:27622 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1751099AbVHLGLf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 02:11:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff,

The PIO fixes revised according to the previous reviews.

1/2 pio1.diff:
   - Modify ata_mmio_data_xfer() and ata_pio_data_xfer() to handle buffer with odd length.

2/2 pio2.diff:
   - Modify __atapi_pio_bytes() to handle the case where device returns/needs extra data.

(Patch diff'ed against 2.6.13-rc6 tree, 7d69fa6266770eeb6317eddd46b64456e8a515bf)

Tested ok on x86 with Promise PDC20275 and LG DVD-Multi drive.

For your review and advice, thanks.

Albert


