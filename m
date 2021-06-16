Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B9C48BE5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 14:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8DD61076
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 14:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhFPOTR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhFPOTQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 10:19:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE797C061574;
        Wed, 16 Jun 2021 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3eHDFeOd5JUwGJsCO8IHOvIdyejL0srMm9wcqB5wSRA=; b=G+lsBszZX7wMG+OHqecK1b3Ef
        /t9Ca2aRzaiTNqrk+K48cYfgJJ1Z8h5HwCFLdsMAeueQZMW0jSh9u2kl+MKgpNmxk+qgsgQdw61re
        jGud3zPlkE7tJ3VFLt6L7gHHhmCyhVEUv1/+gvySbaLuzqLXwh32sSZqgAirzH3nwOMXSS6EjdppB
        /J1OOWUZi6aQ3E9DQGCSbN/8lSAZvN3FCBqKE3gWq1Bps6PZ1oLEd91oYz4qVvYVw5KVVjpZgbUBN
        Gy3Ep68yVKWk4PkZomtI14bAY5QpV1Ash6xKgGxh+tROEhHreGLp8zliJRg0TWElf67zLk/8AVFEu
        oqChk3zSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45070)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltWLl-0007OY-0K; Wed, 16 Jun 2021 15:17:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltWLg-00066O-L0; Wed, 16 Jun 2021 15:16:56 +0100
Date:   Wed, 16 Jun 2021 15:16:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 1/6] pata_cypress: add a module option to disable BM-DMA
Message-ID: <20210616141656.GF22278@shell.armlinux.org.uk>
References: <20210616134658.1471835-1-hch@lst.de>
 <20210616134658.1471835-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616134658.1471835-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Jun 16, 2021 at 03:46:53PM +0200, Christoph Hellwig wrote:
> Multiple users report that they need to disable DMA on this driver,
> so provide an option to do so without affecting all of libata.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
