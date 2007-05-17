From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Thu, 17 May 2007 17:00:30 +0100
Message-ID: <20070517170030.11a1d933@the-village.bc.nu>
References: <464AACDF.1030903@tw.ibm.com>
	<464AB2F3.7030103@tw.ibm.com>
	<20070516140201.29d0f6f0@the-village.bc.nu>
	<464C1972.6050205@tw.ibm.com>
	<464C1FA7.20503@gmail.com>
	<464C77EC.10607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38170 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755060AbXEQP4S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 11:56:18 -0400
In-Reply-To: <464C77EC.10607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> The libata IRQ handler for that channel would then check for this flag
> on entry, before touching any chipset registers, and if it sees the flag
> then it should self-disable the IRQ and return immediately.

How do you plan to disable the IRQ at this point ?

Alan
