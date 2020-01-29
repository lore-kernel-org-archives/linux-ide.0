Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CEC2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE852070E
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNy4UT56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgA2RX0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:23:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2RX0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 12:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qxdWzWOmCgoWbYz3jX66IwOH4z93WpdKcTgyPys1vnI=; b=nNy4UT56yYmek26tiBSDr79oy
        +kdv3L5++5fKBpzwML+ST6IsZxj9RqnKWWGps9+QHjH1+DELnLQC+5pMIFlGOJz1LmDn7gdLSiNCi
        +000sFv1xoavMAuyOYlOw9gA08XEq1KInBW/qZjTOyZmhH68hUykvI7jeSn3j46JSo9NsjrnsojH2
        y8tcmaKLXv5fwj1PXV8b1TwdI7N7eTGn2tjJq1v7AlvQOcnr/bADrXNm1EjN9WR4giMfnWFm95YvN
        V0tXd3mLQ+gmlfx4GDiCIsMtDBF0GWBftCIwQfWIZqRhMD13x6zHkr1ktijZmAi3u8r/mB2WinsNG
        nhr3QNX9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwr3j-0006vV-E7; Wed, 29 Jan 2020 17:23:23 +0000
Date:   Wed, 29 Jan 2020 09:23:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/28] ata: separate PATA timings code from libata-core.c
Message-ID: <20200129172323.GF12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73@eucas1p1.samsung.com>
 <20200128133343.29905-11-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-11-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  libata-pata-timings.c - helper library for PATA timings

Please remove the file name from the top of the file header.

> +static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
> +{

> +void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
> +		      struct ata_timing *m, unsigned int what)
> +{

Please fix the overly long lines while you're at it.

> +	if (what & ATA_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
> +	if (what & ATA_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
> +	if (what & ATA_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
> +	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
> +	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
> +	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
> +	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
> +	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
> +	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);

and this very strange coding style.

> +	if (!(s = ata_timing_find_mode(speed)))
> +		return -EINVAL;

This should be:

	s = ata_timing_find_mode(speed);
	if (!s)
		return -EINVAL;

> +	/* In a few cases quantisation may produce enough errors to
> +	   leave t->cycle too low for the sum of active and recovery
> +	   if so we must correct this */

.. non-standard comment style here.

> +#ifdef CONFIG_ATA_ACPI
>  extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
> +#endif

I don't think we need this ifdef - unused prototypes are completely
harmless.
