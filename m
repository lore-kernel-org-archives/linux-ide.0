From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: more irq driven pio follow-up patches
Date: Tue, 01 Nov 2005 19:12:26 +0800
Message-ID: <43674D9A.9010007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:53162 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750745AbVKALMb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 06:12:31 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA1BCPVK009532
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 06:12:25 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jA1BDSv3549590
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:13:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA1BCOQF005485
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:12:24 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Dear all,

More irq driven PIO follow-up patches (revised).

Changes:
  1. merge the ata_dataout_task workqueue with the ata_pio_task workqueue
  2. add read/write multiple support

patch 1/4: misc fixes
   - ata_pio_block(): add ata_altstatus(ap) to prevent reading device status before it is valid
   - remove the unnecessary HSM_ST_IDLE state from ata_pio_task()
   - raise BUG() when unknown state is found in ata_pio_task()

patch 2/4: merge the ata_dataout_task workqueue with the ata_pio_task workqueue
   - remove ap->dataout_task from struct ata_port
   - let ata_pio_task() handle the HSM_ST_FIRST state.
   - rename ata_dataout_task() to ata_pio_first_block()

patch 3/4: eliminate unnecessary queuing in ata_pio_first_block()
   - change the return value of ata_pio_complete()
   - add return value to ata_pio_first_block()
   - rename the variable "qc_completed" to "has_next" in ata_pio_task()
   - use "has_next" to eliminate unnecessary queuing in ata_pio_first_block()

patch 4/4: add read/write multiple support
   - add is_multi_taskfile() to ata.h
   - initialize ata_device->multi_count with device identify data
   - use ata_pio_sectors() to support r/w multiple commands

Patch against the libata-dev irq-pio branch (cd8200e6d4f9f05e6ea48f7c000be890337396ac).

For your review and advice, thanks.

Albert


