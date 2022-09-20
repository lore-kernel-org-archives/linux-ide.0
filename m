Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEC3C54EE9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 06:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiITGgB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiITGfY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 02:35:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47F4BD0D;
        Mon, 19 Sep 2022 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQejfzOTLyVYbb0Ee26cQYZo4hJMC+wlpWSmhGWbBjM=; b=yLG1qn2xAB9YULJEI0M0N32sVE
        IJCZP+Xssy+PIAyXMm/Nz/if3Cg28eewsHQLgoZkn9LYJoWUCb5q/MfsD9KWDwhoC4ItP2av2qpJQ
        H9/fpXctJMhdYnmiwAutRnFZ2vAAL/uO/tkqtv92mCw4BCWEcxOSwNvJJ7R7Jv21mP3IKmH5DOKeq
        6Ih+CtWpEepZJqZfO4NNbYBd9iU6Yoj5O47r8IZH5zds97GqK5CyxHXanqSqVkmTW11+PIsC77LjK
        HMSqzx4Ndxl+F+Be5xbC6sUoldgOW3HKmPtcPUlQaNbNX1hfLlYCUifafexu60ZF8fnrbTMs0+MGQ
        nxZu5ilg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaWol-001123-VU; Tue, 20 Sep 2022 06:33:15 +0000
Date:   Mon, 19 Sep 2022 23:33:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Subject: Re: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by
 default
Message-ID: <Yyleq43/IBofsMMn@infradead.org>
References: <20220919094635.184804-1-ecurtin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919094635.184804-1-ecurtin@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Err, no.  We should not add config options for every damn default.
If you want to force it on CONFIG_CMDLINE is your friend.

