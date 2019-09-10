Return-Path: <SRS0=DiMu=XF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF103C4740A
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 05:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC5621928
	for <linux-ide@archiver.kernel.org>; Tue, 10 Sep 2019 05:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrOzG826"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404454AbfIJFxe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Sep 2019 01:53:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfIJFxe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Sep 2019 01:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sx6Eh2LTvX3zFInaYy6LVGhvyHdvsnvYuUlfk4TSZ94=; b=JrOzG826Y5Z22ecIb04GO5KyB
        gAzIOuUienaaxKMAmOrluR15KfJfFWIzGi/TWgL6mCAV8w+DVdykwLWAL4TafSJjvsvUdsVanW/Z6
        4KJ5XeYcPNxzERBrX66iAfO8/Ito2An9JTr/z0kp3hqZyH35Ia0cG8dt3aNKy6J82DRevyGH5K9IL
        w3J7GMDKhWrLPlOkBgdZ0etB6Wr2YUaCXb7Yg5ZdXtmKsQn/XR+eL6mB1Oto0seFGKtc2M3WYFcAm
        ZuNeuumVhHSBSbpBre5k+mQz3FtafsIPfqiSJBfzx3NYGNVIVPaakfMswUM0na/7brX0Lo1eSxsVX
        nDu/RT8TQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7Z5p-00006C-5t; Tue, 10 Sep 2019 05:53:33 +0000
Date:   Mon, 9 Sep 2019 22:53:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA errors accessing hidden partitions
Message-ID: <20190910055333.GA32641@infradead.org>
References: <AM6PR10MB33991CE19828429C676C0296A1C40@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
 <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR10MB339928C6DF7AF88789F904EFA1B70@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Sep 09, 2019 at 06:25:45AM +0000, Jorge Fernandez Monteagudo wrote:
> Hi all,
> 
> I have a SSD disk from transcend with 6 partitions, where partitions 3, 4 and 5 are locked. This disk implements the OPAL specifications and transcend supplies some tools to hide/unhide a partition.

OPAL does not have a concept to hide a partition, it supports locking
ranges.  In doubt you want to use the kernel opal support to unlock all
ranges and should be fine, otherwise there isn't too much we can do.
