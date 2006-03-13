From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/5] libata-dev: integrate polling pio with irq-pio (respin)
Date: Mon, 13 Mar 2006 15:33:19 +0800
Message-ID: <4415203F.4070103@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:62374 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751536AbWCMHda
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:33:30 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7XO4K022306
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:33:24 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7UZVF243164
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:30:35 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7XNHt008698
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:33:23 -0700
In-Reply-To: <44136D61.4020007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This patch set integrates polling pio with irq-pio.
(Revised per Tejun's advice to remove ap->pio_task_timeout, etc.)

Changes:
1/5: Move out the HSM code from ata_host_intr() to the new ata_hsm_move() function.
2/5: Minor fix for ata_hsm_move() to work with ata_host_intr()
3/5: Let ata_hsm_move() work with both irq-pio and polling pio
4/5: Convert ata_pio_task() to use the new ata_hsm_move()
5/5: Cleanup unused enums/functions.

Patch against irq-pio branch (54da9a3968448681d0ddf193ec90f2480c5cba1c) +
the irq-pio minor fixes (respin) patchset.

For your review, thanks,

Albert



