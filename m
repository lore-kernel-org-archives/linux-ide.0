Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21723C2D0E7
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0505D20748
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 10:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgCZKAY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:00:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44926 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgCZKAY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 26 Mar 2020 06:00:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C1DF68BFE; Thu, 26 Mar 2020 11:00:22 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:00:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 25/27] ata: start separating SATA specific code from
 libata-eh.c
Message-ID: <20200326100022.GS9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90@eucas1p2.samsung.com> <20200317144333.2904-26-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-26-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:31PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Start separating SATA specific code from libata-eh.c:
> 
> * move sata_async_notification() to libata-sata.c:

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
