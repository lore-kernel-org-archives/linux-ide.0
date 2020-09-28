Return-Path: <SRS0=nj0s=DF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA5C2D0A8
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A7620773
	for <linux-ide@archiver.kernel.org>; Mon, 28 Sep 2020 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1RLU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:11:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53496
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgI1RLU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2020 13:11:20 -0400
X-IronPort-AV: E=Sophos;i="5.77,313,1596492000"; 
   d="scan'208";a="360266987"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 19:11:16 +0200
Date:   Mon, 28 Sep 2020 19:11:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than
 commas to separate statements
In-Reply-To: <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009281909000.2650@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>  <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr> <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On Mon, 28 Sep 2020, Joe Perches wrote:

> On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> > Replace commas with semicolons.  What is done is essentially described by
> > the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
>
> Hi Julia.
>
> How did you decide on this patch subject header line?
>
> It's certainly reasonable, but not what I would expect
> from any automation.

Most of the patches on this file touch other files as well.  There are
four that only touch this file.  One has no subsystem.  One has dma as the
subsystem.  Two have pata_icside, so that was chosen.

I found that taking the most popular overall could give results that were
too general.

julia

>
> A somewhat common method of finding the most commonly used
> "git log" subject line doesn't easily provide a similar heading.
>
> $ git log --no-merges --format='%s' drivers/ata/pata_icside.c
> treewide: Add SPDX license identifier for more missed files
> libata: remove ata_sff_data_xfer_noirq()
> scsi: rename SCSI_MAX_{SG, SG_CHAIN}_SEGMENTS
> Drivers: ata: remove __dev* attributes.
> ata: Convert ata_<foo>_printk(KERN_<LEVEL> to ata_<foo>_<level>
> libata-sff: separate out BMDMA irq handler
> libata-sff: separate out BMDMA EH
> libata-sff: clean up BMDMA initialization
> libata-sff: clean up inheritance in several drivers
> include cleanup: Update gfp.h and slab.h includes to prepare for breaking implicit slab.h inclusion from percpu.h
> [libata] convert drivers to use ata.h mode mask defines
> [ARM] dma: Use sensible DMA parameters for Acorn drivers
> [ARM] dma: pata_icside's contiguous sg array is now redundant
> libata-sff: Fix oops reported in kerneloops.org for pnp devices with no ctl
> libata: rename SFF port ops
> libata: rename SFF functions
> libata: make reset related methods proper port operations
> libata: implement and use ops inheritance
> libata: implement and use SHT initializers
> libata: implement and use ata_noop_irq_clear()
> libata: eliminate the home grown dma padding in favour of
> libata: convert to chained sg
> Fix pata_icside build for recent libata API changes
> libata: implement and use ata_port_desc() to report port configuration
> [libata] Remove ->port_disable() hook
> [libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
> [ARM] pata_icside: fix the FIXMEs
> [libata] PATA drivers: remove ATA_FLAG_SRST
> [ARM] pata_icside: fix build errors
> [ARM] ecard: add ecardm_iomap() / ecardm_iounmap()
> [ARM] ecard: add helper function for setting ecard irq ops
> [ARM] Add support for ICSIDE interface on RiscPC
>
> $ git log --no-merges --format='%s' drivers/ata/pata_icside.c | \
>   cut -f1 -d":" | sort | uniq -c | sort -rn
>      10 libata
>       5 libata-sff
>       2 [ARM] pata_icside
>       2 [ARM] ecard
>       2 [ARM] dma
>       1 treewide
>       1 scsi
>       1 [libata] Remove ->port_disable() hook
>       1 [libata] Remove ->irq_ack() hook, and ata_dummy_irq_on()
>       1 [libata] PATA drivers
>       1 [libata] convert drivers to use ata.h mode mask defines
>       1 include cleanup
>       1 Fix pata_icside build for recent libata API changes
>       1 Drivers
>       1 ata
>       1 [ARM] Add support for ICSIDE interface on RiscPC
>
>
>
