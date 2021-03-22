Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872BC433DB
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 07:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F90A6196F
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 07:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVHIe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:08:34 -0400
Received: from verein.lst.de ([213.95.11.211]:53755 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVHIZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 22 Mar 2021 03:08:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A627867373; Mon, 22 Mar 2021 08:08:22 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:08:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] pata_legacy: Properly document module parameters
Message-ID: <20210322070822.GA3440@lst.de>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk> <alpine.DEB.2.21.2103211909560.21463@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103211909560.21463@angie.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
