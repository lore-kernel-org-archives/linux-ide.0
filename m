From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/7] libata: push part of irq driven pio to workqueue
Date: Fri, 11 May 2007 15:20:10 +0800
Message-ID: <4644192A.8090809@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:46265 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbXEKHUa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:20:30 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B7KUsh032691
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:20:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7KQAI180978
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:20:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7KP6P016915
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:20:26 -0600
In-Reply-To: <464073B1.80303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

1/7: set the state after "PIO data-in" to HSM_ST_IDLE instead of HSM_ST_LAST
2/7: fix the ata_altstatus() in ata_hsm_qc_complete()
3/7: move ata_altstatus() out from ata_hsm_move() to the pio data xfer functions
4/7: move polling idle irq check to ata_host_intr()
5/7: move and reduce locking to the pio data xfer functions
6/7: push part of the irq driven pio out to workqueue
7/7: ack unexpected INTRQ when polling

This is not complete yet, still needs to check if this creates new race
conditions with EH or causing trouble to other part.

Draft patch against 2.6.21.1 for your review.

