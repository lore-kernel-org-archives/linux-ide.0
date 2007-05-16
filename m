From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/8] libata: delegate irq driven pio to workqueue (take
 2)
Date: Wed, 16 May 2007 15:03:59 +0800
Message-ID: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:43410 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbXEPHEg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:04:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G74age023196
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:04:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G74ZLc217930
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:04:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G74ZHt024476
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:04:35 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

1/8: fix the ata_altstatus() in ata_hsm_qc_complete()
2/8: move ata_altstatus() from ata_hsm_move() to pio data xfer functions
3/8: change the state after "PIO data-in" to HSM_ST_IDLE instead of HSM_ST_LAST
4/8: move and reduce locking to the pio data xfer functions
5/8: ack possibly unsolicited irq when polling
6/8: delegate irq driven pio to workqueue
7/8: ata_port_flush_task() fix for irq pio delegation
8/8: ack more unsolicited irq

---
Revised and reorder the patches per previous comments.
Patch against the libata-dev tree for your review.
(af3b146d26550f0c8e0d77b2117c6f8aec5d8146)

