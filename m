Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC24C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348194AbiCXG35 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiCXG34 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 02:29:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A79AE62
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7hCFvPfr84BCxpZpbTNZ9JirNJkTaKlzqQ+cD6LYJPY=; b=USkCHCdWEwu1Cmvr2sx2oZ0dwe
        0wFtOkWr4WnBqtsMZ/VlW9ePEI3Jy3MneY/Z84sMNjzO8sgheLed87R0OtxOr3gr3fY8CQ3GiKqVZ
        2My81BhVH5W0wPbqdt00Zjs5qZu51+pp+9h7WO4rjXwORd1HsY1i6SVnLEXaQcA8C3AKOnU0VcoTW
        E12pK+KAPhi7d76/yYpWdVghuiesUYzYuc5ygomJCtzGiOR3ypBC/8vyYqm0t8JC38hP9rn5Yz1SO
        Cw5u0saEAsinHtOACuY/0mw1Ue9knGptKAmN20qZmyoc3ErpBgYQKRLUW7lObChy0RsYP8BN9HY7B
        pWwRbg7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXGxK-00Fpfc-CR; Thu, 24 Mar 2022 06:28:22 +0000
Date:   Wed, 23 Mar 2022 23:28:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Message-ID: <YjwPhvPyJHiDbkOL@infradead.org>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Mar 24, 2022 at 08:45:56AM +0900, Damien Le Moal wrote:
> Mario, let's check what other distros do first before deciding. Fedora for
> sure has a default of 3 and I have never seen any issue with it (and I
> have been using Fedora for a long time with many different drives).
> 
> Not sure what distro you are using, but if it is not Fedora, please check.
> We should check at least Debian, Ubuntu, SUSE, RHEL and CentOS. I can
> check some other minor ones too as I know users.

Debian:

hch@brick:~/work/linux$ grep CONFIG_SATA_MOBILE_LPM_POLICY /boot/config-5.10.0-1*
/boot/config-5.10.0-10-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
/boot/config-5.10.0-11-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
/boot/config-5.10.0-12-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
