Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37125C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiCAIRm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiCAIRl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 03:17:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEC85BC9;
        Tue,  1 Mar 2022 00:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OvB2N8uwUWiqh7KU3u7tlH5CR5GU2KZPJ8qghHMswqU=; b=vxfKFQJD0/y1eEjix7v7uWnCAg
        Y8yte/g0fZr+B1EDvHPb1gAv+2Q21S0V++4YqZEUaj7AQncPD9INwReuUfXu5waYVsVFsDLDGG2Fd
        BVfZ8nSV/Jgypr+VtADqIhjgNWdC1QTzszI/zM9FpK4Gj3NPZCypxM0h5a2nRAmSLLsvIiZU9xjC6
        rTRq9bAdc9VGaNDu3QJnKcGMATXgWWlISMWhuqywF/eNKaA9aKDME9TkxnLvYD7ghHL0YXNA+rCws
        FQAx7t46dVub2mZRD8dq3Vt8wjNUStLLsE2lG6QOvjyLW51ibLXNZcYk6HHgA0OLPVAIQPJyT77IV
        IZbhkOYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOxgk-00FXz5-V6; Tue, 01 Mar 2022 08:16:54 +0000
Date:   Tue, 1 Mar 2022 00:16:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] ata: ahci: Drop low power policy board type
Message-ID: <Yh3WdvBYRTdXkyuk@infradead.org>
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228213302.2915071-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I really like this and hope it can stick.  Needing quirk lists for
sensible power policies is a bad thing.

Acked-by: Christoph Hellwig <hch@lst.de>
