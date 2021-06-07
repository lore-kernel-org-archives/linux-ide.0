Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F348EC47082
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D428D610E7
	for <linux-ide@archiver.kernel.org>; Mon,  7 Jun 2021 08:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGI2m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGI2l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jun 2021 04:28:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA6C061766;
        Mon,  7 Jun 2021 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gm/Z4ZEed7fwYvc2lrsvQUFJOpzqbnReZh3AcOm9gYM=; b=I2WarOQvkgsFqNSXPKcah6GQKq
        jeBgdpqKK12q7hvx9wBGPxm0WF2ziLRAM13cchy7N0XoaQFj60Oms2wN7vOUoZop31TAr/CpEGDE1
        WVh0S8Q0z8rnEi2nxIg1c7C8lmB82PX/0spN3ewh3XfKU0wZYrsSuM1HiEFtraeRnlHB3Nrnh9WBa
        J+PYkXN3ukUXz+LSQ1Ax/FN0G5Ia1WrwxvB0SegWTzymw8QUoZJL92sgtPiKnZmA/kKjhXLR4Hwuo
        78NIpBQ7E20T+t83m3NQHnOtw3aj55onG1ks81EiR5nz1iKutFFNsPyOw3sxOc2+TA7JmJ0V9xxuC
        QoULjKTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqAaW-00FWsl-Qa; Mon, 07 Jun 2021 08:26:26 +0000
Date:   Mon, 7 Jun 2021 09:26:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Adrian Sun <a.sun@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        "David S. Miller" <davem@davemloft.net>,
        Duncan Laurie <void@sun.com>,
        Erik Andersen <andersee@debian.org>,
        Frank Tiernan <frankt@promise.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Lord <mlord@pobox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Waychison <crlf@sun.com>, or <source@mvista.com>,
        Paul Mackerras <paulus@samba.org>,
        Robert Bringman <rob@mars.trion.com>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Tim Hockin <thockin@sun.com>
Subject: Re: [PATCH 00/21] Rid W=1 warnings from IDE
Message-ID: <YL3YMGl9kmtv55B/@infradead.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Please don't touch this code as it is about to be removed entirely.
