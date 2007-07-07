From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 0/7] libata: irq_on/off restructuring (take #2)
Date: Sat, 07 Jul 2007 14:57:13 +0800
Message-ID: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:55916 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbXGGG51 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 02:57:27 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l676vQ3x031612
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 02:57:26 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l676vQE2209386
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 00:57:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l676vPUK026594
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 00:57:26 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

(Revised per Tejun's advice.)
For ATA, there are two levels of mechanism available to turn irq on/off.
- device level: nIEN bit in the control register. This masks INTRQ from the device.
- host adapter level: some controllers can mask out per-port irq from the host adapter.

Currently various parts of libata deal with irq on/off.
  ex. tf_load() can alter the nIEN bit.
  ex. irq_on() also alters the device level nIEN bit.
  ex. freeze()/thaw() deal with the host adapter irq mask.

It seems these irq_on/off codes could be better structured.
Patches against the libata-dev tree for your review, thanks.

1/7: remove irq_on from ata_bus_reset() and ata_std_postreset()
2/7: sata_promise::pdc_freeze() semantic change
3/7: add freeze()/thaw() to old EH LLDDs
4/7: use freeze()/thaw() for polling PIO
5/7: integrate freeze/thaw with irq_on/off
6/7: tf_load() cleanup
7/7: remove ap->last_ctl

