Return-Path: <SRS0=Z+II=7L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B031AC433DF
	for <linux-ide@archiver.kernel.org>; Fri, 29 May 2020 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD3A20721
	for <linux-ide@archiver.kernel.org>; Fri, 29 May 2020 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aD44otZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2MsK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 29 May 2020 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2MsJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 29 May 2020 08:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C1C03E969
        for <linux-ide@vger.kernel.org>; Fri, 29 May 2020 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dE6hNmPTz4KD7BpDENqr2I/HQlC31bZvgcv61xeAmXA=; b=aD44otZjiy4TnCKAjIl1DXJiqV
        MHmqhKx+GlGhVtORlcRiVkaNLQL+Dp7FAyaGcQsDL/pNkoDAZJfUsfecj32mneZjUnIBzVmsVWjto
        y/NvuT32pB0TnMzvoS47ql7Tdf+FJAH/jrqCAABWTk4yxzZ8fK/b5REa80OIPDE8oqVZwLwytH0LX
        gSTX1CujdkX4vETQG0605NA4smGl15UYSdYXN+fNfxwCBgMWKyyi1GBlU0PPii9jv95Ydv1mwCkth
        g3miCQZ7w3I4lvKTzyzVdNqjgXvMnNixdylWya1xyEElEhtXgcB6AxDPMkcqY0fTks8WjtvSQ6t4K
        R7evQpKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeeQh-0006YQ-LU; Fri, 29 May 2020 12:48:07 +0000
Date:   Fri, 29 May 2020 05:48:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     linux-ide@vger.kernel.org, axboe@kernel.dk,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi/libata: Fix usage of page address by page_address
 in ata_scsi_mode_select_xlat function
Message-ID: <20200529124807.GA23222@infradead.org>
References: <20200529063251.14665-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529063251.14665-1-yebin10@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, May 29, 2020 at 02:32:51PM +0800, Ye Bin wrote:
> index 435781a16875..d674184ed835 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3723,7 +3723,7 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>  	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
>  		goto invalid_param_len;
>  
> -	p = page_address(sg_page(scsi_sglist(scmd)));
> +	p = page_address(sg_page(scsi_sglist(scmd))) + scsi_sglist(scmd)->offset;

This also looks completely buggy on highmem systems and really needs to
use a kmap_atomic.
