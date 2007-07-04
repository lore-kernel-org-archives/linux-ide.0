From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/10] libata: irq_on/off restructuring
Date: Wed, 04 Jul 2007 16:38:47 +0800
Message-ID: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41085 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbXGDIix (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:38:53 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648cplr030345
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:38:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648cpTg089980
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:38:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648coEk027364
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:38:51 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

For ATA, there are two levels of mechanism available to turn irq on/off.
- device level: nIEN bit in the control register. This masks INTRQ from the device.
- host adapter level: some controller can mask out per-port irq from the host adapter.

Currently various parts of libata deal with irq on/off.
  ex. tf_load() can alter the nIEN bit.
  ex. irq_on() also alters the device level nIEN bit.
  ex. freeze()/thaw() deal with the host adapter irq mask.

It seems these irq on/off codes could be better structured.
Patches against libata-dev tree for your review/advice, thanks.

1/10: remove irq_on from ata_bus_reset() and ata_std_postreset()
2/10: add ->irq_off() for symmetry
3/10: implement ->irq_off() in LLDDs
4/10: use irq_off from bmdma_freeze()
5/10: use freeze()/thaw() for polling
6/10: add freeze()/thaw() to old EH LLDDs
7/10: pdc_freeze() semantic change
8/10: remove writing of tf->ctl from ata_tf_load()
9/10: integrate freeze()/thaw() with irq_on/off.
10/10: integrate freeze/thaw with irq_on/off in LLDDs

