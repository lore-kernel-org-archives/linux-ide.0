From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 22:17:56 +0800
Message-ID: <456C4514.9090107@tw.ibm.com>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59824 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S934539AbWK1OXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 09:23:31 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kASENU0s022401
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 09:23:30 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kASEIEmA213282
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 07:18:17 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kASEICfe012679
	for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 07:18:13 -0700
In-Reply-To: <456BDCAC.4060609@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Albert Lee wrote:

> Some devices raise irq early before clearing the BSY.

> This patch waits up to 10 microseconds to workaround the early irq problem.

> 



BTW, the patch is on the hot path. The following is a quick analysis of
the performance penalty introduced by the patch:



1. DMA mode:

   The dma_status is checked before reading the alt_status, so we are pretty

   sure that it is our interrupt. It's worthwhile to poll alt_status and wait

   for BSY to clear in this case. 



2. PIO mode with non-shared irq:

   It is our interrupt. It's worthwhile to wait a moment for BSY to clear.



3. PIO mode with shared-irq:

   If PIO + shared-irq + qc active + other people's irq

   => We waste 10 micro seconds to figure out that it is not our interrupt.
      In exchange for the wasted time, we get better tolerance for the
      early irq situations.

--
albert

  

     

