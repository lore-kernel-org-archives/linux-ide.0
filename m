From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: interrupt driven pio (revised 2)
Date: Tue, 27 Sep 2005 17:31:25 +0800
Message-ID: <4339116D.30908@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:46291 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964879AbVI0Jbk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Sep 2005 05:31:40 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8R9UxO9020476
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 05:30:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8R9VYrJ533106
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:31:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8R9VXPt014442
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:31:34 -0600
In-Reply-To: <4333CF07.5010400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Dear all,

The revised interrupt driven PIO patch is ready for your review.

Patch 1/4: indent and white space change
Patch 2/4: s/PIO_ST_/HSM_ST_/ and s/pio_task_state/hsm_task_state/.
Patch 3/4: interrupt driven pio patch for libata-core
Patch 4/4: interrupt driven pio patch for LLD

Patch for 2.6.14-rc1 (044a500e46742d39d22f1781cfb64ba93b463e39).
Tested ok on x86 with Promise PDC20275, Seagate ST380011A and LITEON 52x 
CD-ROM drive.
Need more testing with other host adapters and devices, especially 
pre-ATA4 ATAPI CD-ROM drives with CDB interrupt.

For your review and advice, thanks.

Albert

