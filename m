Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B7C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 07:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0241461053
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 07:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKHSn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhKKHSn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 02:18:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC83C061766
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 23:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rMIrTJbxiCA4/eLcOBhhTtZirP/r73DVP7PdItN1HFI=; b=Fnn89EGMB7JpobnFeAt83pao9B
        Z7fxV6qb2zzGtAalFajL18zjF3UUXOrhphdQomyy4T6sf6dtaryenXZR1Z18tYKF09QHyfl/oeahT
        X2XB7WaVo6cSAhXLz9FTdgQRzeWmiMEGx++A9uZIU82moC8B1COM8f2sCpuBJgU3qTTF2Bgdc+07w
        zmCw7d5vezPfKcr1OywEhA8StQK+itzRozFaxKRM/Mnc6SNNgbzygHi5+DyiFuPlf5qqaJuR/i8vd
        1b+0a/cMhfxIt30O8oJN+JlfRP2ljpBJijpmqVMqeqY6ph7/H6fFacEswlpSUAP1OR1NMU+/ZaMQc
        gJmeoqTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ml4JN-007M5K-Lv; Thu, 11 Nov 2021 07:15:53 +0000
Date:   Wed, 10 Nov 2021 23:15:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH V2] libata: add horkage for missing Identify Device log
Message-ID: <YYzDKYG5DVA4N5sQ@infradead.org>
References: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I'm still a little worried just sending this command could blow up on
really old devices.  But I guess we can deal with that when the problem
arises:

Reviewed-by: Christoph Hellwig <hch@lst.de>
