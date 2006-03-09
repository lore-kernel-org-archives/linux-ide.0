From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/5] libata-dev: integrate polling pio with irq-pio
Date: Thu, 09 Mar 2006 16:41:47 +0800
Message-ID: <440FEA4B.10500@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:63120 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750786AbWCIIlq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Mar 2006 03:41:46 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298feC5024877
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:41:40 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298cuAE265758
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:38:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298fd3n026427
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:41:40 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This patch set integrates polling pio with irq-pio.

Changes:
1/5: Move out the HSM code from ata_host_intr() to the new ata_hsm_move() function.
2/5: Minor fix for ata_hsm_move() to work with ata_host_intr()
3/5: Let ata_hsm_move() work with both irq-pio and polling pio
4/5: Convert ata_pio_task() to use the new ata_hsm_move()
5/5: Cleanup unused enums/functions.

Patch against irq-pio branch (c2956a3b0d1c17b38da369811a6ce93eb7a01a04). 
Minimally tested ok on x86. 

For your review, thanks,

Albert

