Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4CC47082
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA266100B
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 14:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhFHOkE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhFHOkC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 10:40:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB69C06178B;
        Tue,  8 Jun 2021 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sMEsStOb6mO9hXHdT3HWSmfrRuJ0Awq1YlH4iEA8L4Y=; b=KFplbzH/LlDm+AgUOf2U3e3d9H
        GLn3zqEjGHW+Ei/TTsCFYfGLui341DfsWefMKpI6fnAW+l4q3H1pyXf1V4CGFoU88MBFCZ4sUeQqf
        rr0mEh6nyOS4EVCF2ORhPFHrm6ycrBSTzuuGq5b8i8F6uStpFoB2yYVLdSo50hR7rNIgZ9X5dXmMY
        wNZAJMxQHKrGwKIGZXO4r5fKNXfT3ZeRiJ7gq+grDL/03GEWEgAvCzEjdBlsP2YAoiWDh6+XMozmh
        9QN0dZsccRRXkkii2OZ2xFYtR4jXqY4bVgq4LBqzFPQ7WXAYIo1axFCfeLy2YPZDhCXeF15pbaMUO
        /fsTBHmQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqcrA-00H1nj-W6; Tue, 08 Jun 2021 14:37:34 +0000
Date:   Tue, 8 Jun 2021 15:37:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
Message-ID: <YL+AqIEPjMgG519L@infradead.org>
References: <cover.1623131194.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623131194.git.fthain@linux-m68k.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Jun 08, 2021 at 03:46:34PM +1000, Finn Thain wrote:
> This patch series allows m68k platforms to switch from deprecated IDE
> drivers to libata drivers.

Thanks, this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, any chance you could pick this up quickly to prepare for the
legacy IDE removal series?
