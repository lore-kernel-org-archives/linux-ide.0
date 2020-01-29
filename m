Return-Path: <SRS0=TxtD=3S=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01774C2D0DB
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19432071E
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jan 2020 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="diFHmzuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgA2RSW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:18:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgA2RSW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 12:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wxjnKFK09d9KA7Kgcl22U4hEu5hS0mDvq9iKR6AN8n4=; b=diFHmzufchn4w2us3HtSRdNCs
        acOBxeualJf6R5vEQTX6HDVHqiN8GPULrplusXhZJdPr3mpk8ODcfxyQsnjtQhT6olVT6aJ2PAbfL
        S20k0gVYOoRqljdHApkT6b+i4hQAWDdWa5qvpUV/xTZMVgqV53iAVIZOKBZ2QNFa2Y5jhfFo4ufYq
        72mpwIMlQ/kDTQ5GlqStQfC4gEzdj40hht9mS8SgcreRI8/vZNanwoKwszvrW800FRfP79XyQU8d9
        W/6iewikDf7Z0DYpP9NOZKEGli3dkHHEbfCP5t4Mk8EmG8xAuQ/a77ie3mjTALMGWv4DW0IvPxcwE
        tjKzQsJhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwqyp-0004nY-JH; Wed, 29 Jan 2020 17:18:19 +0000
Date:   Wed, 29 Jan 2020 09:18:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
Message-ID: <20200129171819.GB12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8@eucas1p2.samsung.com>
 <20200128133343.29905-7-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-7-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:21PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Use COMMAND_LINE_SIZE instead PAGE_SIZE for ata_force_param_buf[]
> size as libata parameters buffer doesn't need to be bigger than
> the command line buffer.
> 
> For many architectures this results in decreased libata-core.o
> size (COMMAND_LINE_SIZE varies from 256 to 4096 while the minimum
> PAGE_SIZE is 4096).
> 
> Code size savings on m68k arch using atari_defconfig:
> 
>    text    data     bss     dec     hex filename
> before:
>   41064    4413      40   45517    b1cd drivers/ata/libata-core.o
> after:
>   41064     573      40   41677    a2cd drivers/ata/libata-core.o
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This looks like a good start, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But evne COMMAND_LINE_SIZE is quite a lot of overhead.  Can we maybe add
a new Kconfig option to optionally disable the libata.force= entirely?
