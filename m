From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 09/09] sata_mv cache main_irq_mask register in hpriv
Date: Mon, 19 May 2008 11:27:49 -0700
Message-ID: <da824cf30805191127p1069d568h2049c5d00ff69387@mail.gmail.com>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca>
	 <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca>
	 <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca>
	 <482F179E.8020602@rtr.ca> <482F17C3.8020106@rtr.ca>
	 <482F17F8.3010403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:50504 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYESS16 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 14:27:58 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id m4JIRpxS028499
	for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 19:27:51 +0100
Received: from wf-out-1314.google.com (wfg23.prod.google.com [10.142.7.23])
	by zps78.corp.google.com with ESMTP id m4JIRfoJ030657
	for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 11:27:50 -0700
Received: by wf-out-1314.google.com with SMTP id 23so1605619wfg.30
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 11:27:50 -0700 (PDT)
In-Reply-To: <482F17F8.3010403@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Harald Welte <laforge@gnumonks.org>

On Sat, May 17, 2008 at 10:38 AM, Mark Lord <liml@rtr.ca> wrote:
> Part five of simplifying/fixing handling of the main_irq_mask register
> to resolve unexpected interrupt issues observed in 2.6.26-rc*.
>
> Keep a cached copy of the main_irq_mask so that we don't have
> to stall the CPU to read it on every pass through mv_interrupt.
>
> This significantly speeds up interrupt handling, both for sata_mv,
> and for any other driver/device sharing the same PCI IRQ line.

To be precise, it saves about ~1% of cpu cycles of ~2Ghz CPU
as measured by oprofile. "fio" provided the workload by sequentially
reading 4K blocks from 4 normal SATA II disks (about 8K IO/s per disk).
This is expected to be similar to using SSDs.
So not a huge win; just an easy one.

Here is the cost of one MMIO read on a not-to-old intel PCI-e chipset:
0a:00.0 (11ab:7042): sata_mv from CPU0                   SATAHC0Cause
(20014):  1345 cycles   576 ns
0a:00.0 (11ab:7042): sata_mv from CPU0                      main_mask
(1d64):  1302 cycles   558 ns
0a:00.0 (11ab:7042): sata_mv from CPU0                     main_cause
(1d60):  1302 cycles   558 ns

I'll note this is extremely fast since there are no PCI-PCI bridges
and the 7042 controller seems to respond very quickly.
More typical is 1000ns or so.

thanks,
grant

(1) svn co http://svn.gnumonks.org/trunk/mmio_test/

Plus this patch:
    http://iou.parisc-linux.org/~grundler/diff/diff-mmio_test-02
