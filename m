Return-Path: <SRS0=f9YD=UZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04997C48BD3
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jun 2019 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEA7208E3
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jun 2019 12:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFZMx6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:53:58 -0400
Received: from verein.lst.de ([213.95.11.211]:42920 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfFZMx6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 26 Jun 2019 08:53:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 57FB268B05; Wed, 26 Jun 2019 14:53:25 +0200 (CEST)
Date:   Wed, 26 Jun 2019 14:53:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Roger Quadros <rogerq@ti.com>
Cc:     hch@lst.de, "hdegoede@redhat.com" <hdegoede@redhat.com>,
        axboe@kernel.dk, iommu@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-omap@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        rmk+kernel@arm.linux.org.uk, "Nori, Sekhar" <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: SATA broken with LPAE
Message-ID: <20190626125325.GA4744@lst.de>
References: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Roger,

it seems the arm dma direct mapping code isn't doing the right thing
here.  On other platforms that have > 4G memory we always use swiotlb
for bounce buffering in case a device that can't DMA to all the memory.

Arm is the odd one out and uses its own dmabounce framework instead,
but it seems like it doesn't get used in this case.  We need to make
sure dmabounce (or swiotlb for that matter) is set up if > 32-bit
addressing is supported.  I'm not really an arm platform expert,
but some of those on the Cc list are and might chime in on how to
do that.
