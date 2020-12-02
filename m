Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC1C64E7B
	for <linux-ide@archiver.kernel.org>; Wed,  2 Dec 2020 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7F221EB
	for <linux-ide@archiver.kernel.org>; Wed,  2 Dec 2020 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgLBPEN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgLBPEN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2020 10:04:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B9C0613CF
        for <linux-ide@vger.kernel.org>; Wed,  2 Dec 2020 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KUd2MGSuYreFWMP9cWnBDUzNnqjWTM/tN5m0Gr247Gg=; b=F1RkZWD6LHZTm+DkaDZDmPxNob
        kQN9+cSwMzvFUVzYm3BmO8SvHouBmdWzxQqswVOxwTC/5L7aU/vSr+VaqU9AXHaaXKvAUQmVTfns8
        8RMwtY96EOtpPIZOSiEni+Y0gP4bCuM6gVJgXE0zj0+W4uqHLARnlZ+TiSzwM/yZhgzIOzkb4BE26
        fecAnFSS+ls6kBjsObHJmXGGobC7gKtd+G4af/rVCUhtghl/zYNLaFemevx+dqB0fjD15LNGWvO10
        Hhbvtl9yDUen8igmmHpjI6Uljc3VvyENQfoKOFzWgcbMExtHxpal3rB0ZlKthGh0dwmQ9QzB8crcx
        vmaKOMhw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkTfG-0006dc-Ux; Wed, 02 Dec 2020 15:03:31 +0000
Date:   Wed, 2 Dec 2020 15:03:30 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
Subject: Re: Drive reset as an EH strategy when write cache is enabled
Message-ID: <20201202150330.GA25031@infradead.org>
References: <87r1o9phgd.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1o9phgd.fsf@vps.thesusis.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Dec 01, 2020 at 12:24:50PM -0500, Phillip Susi wrote:
> A while back I noticed lines in my syslog indicating that a FLUSH CACHE
> command timed out and the drive was hard reset to recover.  That made me
> wonder if such a thing makes any sense as a valid EH strategy.  Any
> previous writes that returned successfully but are still sitting in the
> drive's write cache will be silently invalidated by resetting the drive
> won't they?  Then the FLUSH CACHE command is retried, and of course,
> succeeds because it is now a NOOP.  Then fsync() returns and postfix
> thinks my new email has been committed to the disk, when in fact, it has
> not.
> 
> Am I mistaken somewhere or is the kernel really doing the wrong thing
> here?

If the device drops the content of the volatile write on a reset we'll
have much problems than that..
