Return-Path: <SRS0=nj0s=DF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE7C47433
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DB820717
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgI1Qsc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:48:32 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:48422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgI1Qru (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2020 12:47:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B9179181D303A;
        Mon, 28 Sep 2020 16:47:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arch33_3216d3d27183
X-Filterd-Recvd-Size: 3948
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Sep 2020 16:47:47 +0000 (UTC)
Message-ID: <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
Subject: Re: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than
 commas to separate statements
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Sep 2020 09:47:45 -0700
In-Reply-To: <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

Hi Julia.

How did you decide on this patch subject header line?

It's certainly reasonable, but not what I would expect
from any automation.

A somewhat common method of finding the most commonly used
"git log" subject line doesn't easily provide a similar heading.

$ git log --no-merges --format='%s' drivers/ata/pata_icside.c
treewide: Add SPDX license identifier for more missed files
libata: remove ata_sff_data_xfer_noirq()
scsi: rename SCSI_MAX_{SG, SG_CHAIN}_SEGMENTS
Drivers: ata: remove __dev* attributes.
ata: Convert ata_<foo>_printk(KERN_<LEVEL> to ata_<foo>_<level>
libata-sff: separate out BMDMA irq handler
libata-sff: separate out BMDMA EH
libata-sff: clean up BMDMA initialization
libata-sff: clean up inheritance in several drivers
include cleanup: Update gfp.h and slab.h includes to prepare for breaking implicit slab.h inclusion from percpu.h
[libata] convert drivers to use ata.h mode mask defines
[ARM] dma: Use sensible DMA parameters for Acorn drivers
[ARM] dma: pata_icside's contiguous sg array is now redundant
libata-sff: Fix oops reported in kerneloops.org for pnp devices with no ctl
libata: rename SFF port ops
libata: rename SFF functions
libata: make reset related methods proper port operations
libata: implement and use ops inheritance
libata: implement and use SHT initializers
libata: implement and use ata_noop_irq_clear()
libata: eliminate the home grown dma padding in favour of
libata: convert to chained sg
Fix pata_icside build for recent libata API changes
libata: implement and use ata_port_desc() to report port configuration
[libata] Remove ->port_disable() hook
[libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
[ARM] pata_icside: fix the FIXMEs
[libata] PATA drivers: remove ATA_FLAG_SRST
[ARM] pata_icside: fix build errors
[ARM] ecard: add ecardm_iomap() / ecardm_iounmap()
[ARM] ecard: add helper function for setting ecard irq ops
[ARM] Add support for ICSIDE interface on RiscPC

$ git log --no-merges --format='%s' drivers/ata/pata_icside.c | \
  cut -f1 -d":" | sort | uniq -c | sort -rn
     10 libata
      5 libata-sff
      2 [ARM] pata_icside
      2 [ARM] ecard
      2 [ARM] dma
      1 treewide
      1 scsi
      1 [libata] Remove ->port_disable() hook
      1 [libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
      1 [libata] PATA drivers
      1 [libata] convert drivers to use ata.h mode mask defines
      1 include cleanup
      1 Fix pata_icside build for recent libata API changes
      1 Drivers
      1 ata
      1 [ARM] Add support for ICSIDE interface on RiscPC


