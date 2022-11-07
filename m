Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ECC4332F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 09:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiKGJWA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiKGJVz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 04:21:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC736477
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vyvvEx8Jx8otptBJMkFxh9hcfJ
        FuEJDe82u6iT3V9M64k+xWnw+Wi2JnpcL53g5yAvT+vUXq4kJ4lh21pF1VBTgJ1PMaFQt1Zcs7j1a
        xYYCxhEkpn4d+3YaRkAFRBnMbTcDiHej9VehHFP0MbxXKsgYQrgCvYoVxblzOqFHrKEffNp3IG2Jr
        4oRTpth+lroH5iPb2z7MODc2KheodxgFMFAco04AsWHcrr6OnQTXf8EdsGfwYPPrDQzM55LgXw9SM
        OWv2oLE11GeglOvMPHTtpBo5ULTxD3RDBGYCSEUffiL8T7QyB8n9V+ik6Vcoaf/3CHqbSokk2UQQz
        iDluY/bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oryKH-00DDwI-1A; Mon, 07 Nov 2022 09:21:53 +0000
Date:   Mon, 7 Nov 2022 01:21:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v2] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
Message-ID: <Y2jOMOnl2/gpetWh@infradead.org>
References: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
