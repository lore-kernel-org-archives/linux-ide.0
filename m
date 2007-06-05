From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/3] libata: minor pio fixes
Date: Tue, 05 Jun 2007 11:42:17 +0800
Message-ID: <4664DB99.8010202@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:57708 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275AbXFEDmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 23:42:55 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l553gsKQ014127
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:42:54 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l553gskp177580
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:42:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l553grSe002407
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:42:54 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Minor pio fixes:
1/3: remove unneeded ata_altstatus() from ata_hsm_qc_complete()
2/3: move the ata_altstatus() to pio data xfer functions
3/3: change the last state of pio read to HSM_ST_IDLE

Patch against the libata-dev tree for your review.

