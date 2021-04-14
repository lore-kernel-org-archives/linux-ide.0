Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A1C433B4
	for <linux-ide@archiver.kernel.org>; Wed, 14 Apr 2021 06:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8E6120E
	for <linux-ide@archiver.kernel.org>; Wed, 14 Apr 2021 06:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbhDNGq2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhDNGq2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2021 02:46:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CFBC061574;
        Tue, 13 Apr 2021 23:46:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8f005acf25a97a6c1ba1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:5acf:25a9:7a6c:1ba1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B791EC03A0;
        Wed, 14 Apr 2021 08:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618382762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qajLDFvAjN4vrpgqjvft79r59EaS59vt+FlFTgJ6tXA=;
        b=R0rJgdvfm7210YHOaXgB5qyf3vYsUJO6RAV/1BWLT9SA4vex+uBnL3WOC/1GOGaZYn496Z
        8eS/66RZJqfH1jSAkGgSrsIQ66sTUpUbwWQilbBEK38SkhFOWdpYRLXnjosXFjnjwEX+U/
        0NraHyFYTBsHwARQD/akWvgl8JlmwF4=
Date:   Wed, 14 Apr 2021 08:45:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove me from IDE/ATAPI section
Message-ID: <20210414064559.GA10709@zn.tnic>
References: <20210412090346.31213-1-bp@alien8.de>
 <20210414063925.GA1607069@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210414063925.GA1607069@infradead.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 14, 2021 at 07:39:25AM +0100, Christoph Hellwig wrote:
> On Mon, Apr 12, 2021 at 11:03:46AM +0200, Borislav Petkov wrote:
> >  IDE/ATAPI DRIVERS
> > -M:	Borislav Petkov <bp@alien8.de>
> >  L:	linux-ide@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/cdrom/ide-cd.rst
> 
> The Maintained should also become Orphaned then.

Ok, will correct and push through tip this week.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
