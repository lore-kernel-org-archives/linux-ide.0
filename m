From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/2] libata: minor pio fixes (resend)
Date: Wed, 04 Jul 2007 16:24:16 +0800
Message-ID: <468B5930.3070000@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:54895 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbXGDIYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:24:19 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648OJQ6006149
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:24:19 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648OIiT219912
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:24:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648OIE0009104
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:24:18 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Minor pio fixes:
1/2: move ata_altstatus() to pio data xfer functions
2/2: change the last state of pio read to HSM_ST_IDLE

(The previous "remove unneeded ata_altstatus() from ata_hsm_qc_complete()"
has been accepted.)

Patch against the libata-dev tree for your review.

