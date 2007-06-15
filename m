From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/9] libata: irq_on/off restructuring
Date: Fri, 15 Jun 2007 11:11:15 +0800
Message-ID: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:44550 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXFODLl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:11:41 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3BbdS012304
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:11:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3Bb0O257168
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:11:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3Ba1H019390
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:11:36 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>

For ATA, there are two levels of mechanism available to turn irq on/off.
 - device level: nIEN bit in the control register. nIEN masks INTRQ from the device.
 - host adapter level: some controller can mask out per-port irq from the host adapter.

Currently various parts of libata deal with irq on/off.
  ex. tf_load() can alter the nIEN bit.
  ex. irq_on() also alters the device level nIEN bit.
  ex. freeze()/thaw() deal with the host adapter irq mask.

It seems these irq on/off codes could be better structured.
Draft patches for your review/advice, thanks.

1/9: remove irq_on from ata_bus_reset() and ata_std_postreset()
2/9: add ->irq_off() for symmetry
3/9: implement ->irq_off() in LLDDs
4/9: call irq_off from bmdma_freeze()
5/9: use freeze()/thaw() for polling
6/9: add freeze()/thaw() to old EH LLDDs
7/9: pdc_freeze() semantic change
8/9: remove writing of tf->ctl from ata_tf_load()
9/9: Remove irq_on/off. Rename freeze()/thaw() to irq_on/off.

