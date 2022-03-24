Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F7C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbiCXPGi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbiCXPGh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 11:06:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD3749CB3;
        Thu, 24 Mar 2022 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aqatUoG0fwiUJQrtO3aDTtVBTKou/Y4ZKK6SHn8KfZ8=; b=Z54Hz6O1T+7N9Cp0U0JFNAjyeo
        36cIyHxnkR/2nCyFZMPjXv5nOmT4ybAl/GIn7f2cwwo4WbPM4WN3RhLAemFiV5i4Ph2LxJnzaqpsR
        BGMLXbaHFlV4O3DfH/KtEgdpqVmflUKAboCkfpyADR9DtfKRTNahLAXX3S9YaIloVR51V8OPlR76J
        ngoELjhuMiZuQPp09ARQ9HaH5lU85E0+Q5tIIzNA+70vM8z5dA1okkoaI+DmLVWftfDk4Kh4Ks202
        BTLK/Sw20gOddeJ+gTaJHHt/q/MLn0iSWngc3J8vu6z8oi3dv9YZq0F18WD6r9YwnzpvlIX/VqBZW
        W7eeP8qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXP1L-00Gz7h-8m; Thu, 24 Mar 2022 15:05:03 +0000
Date:   Thu, 24 Mar 2022 08:05:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Message-ID: <YjyInz126lgomIvW@infradead.org>
References: <20220324145905.4176-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220324145905.4176-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

What about just reverting the rename of the config symbol?
It is a bit misleadinḑ, but so are many other option nams.  And they
really aren't the user interface anyway, the help text and description
are the main user interface and can be changed at will.
