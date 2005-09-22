From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/3] libata: interrupt driven pio (revised)
Date: Thu, 22 Sep 2005 12:00:16 +0800
Message-ID: <43322C50.1060009@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50612 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750842AbVIVEAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2005 00:00:40 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8M40Rkx025018
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:00:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8M40Q8D094558
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:00:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8M40MJ0030016
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:00:26 -0400
In-Reply-To: <4321C7DD.5050503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Dear all,

The revised interrupt driven PIO draft patch is ready for your review.

Patch 1/3: interrupt driven pio patch for libata-core

Patch 2/3: s/PIO_ST_/HSM_ST_/ and s/pio_task_state/hsm_task_state/.

Patch 3/3: interrupt driven pio patch for LLD

Patch for 2.6.14-rc1 (044a500e46742d39d22f1781cfb64ba93b463e39).
Tested ok on x86 with Promise PDC20275, Seagate ST380011A and LITEON 52x 
CD-ROM drive.

For your review and advice, thanks.

Albert


