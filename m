Return-Path: <SRS0=AWLX=CU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF4C2BC11
	for <linux-ide@archiver.kernel.org>; Fri, 11 Sep 2020 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C50B22207
	for <linux-ide@archiver.kernel.org>; Fri, 11 Sep 2020 23:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgIKXHZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Sep 2020 19:07:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40108 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgIKXHW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2020 19:07:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B58472ABF7;
        Fri, 11 Sep 2020 19:07:17 -0400 (EDT)
Date:   Sat, 12 Sep 2020 09:07:22 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] ide/macide: Convert Mac IDE driver to platform driver
In-Reply-To: <CAMuHMdU9vEUasHMeS=OiHX+16dgQGPdmjEtCi+-YLcXvw4BM7g@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2009120812020.8@nippy.intranet>
References: <00ee44fe6ecdce1c783c3cc3b1b9a62b498dcdb2.1597736545.git.fthain@telegraphics.com.au> <CAMuHMdWAi6+75Mq0U8x7Ut6viHvF7XEZAcYnxq=jJmtJyAX8pw@mail.gmail.com> <alpine.LNX.2.23.453.2009100920001.8@nippy.intranet> <CAMuHMdVMvhJRHOwJapi+LAdPbPuoT73ST_Nj0qeCqQd3XWvoSQ@mail.gmail.com>
 <alpine.LNX.2.23.453.2009110847480.8@nippy.intranet> <CAMuHMdU9vEUasHMeS=OiHX+16dgQGPdmjEtCi+-YLcXvw4BM7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, 11 Sep 2020, Geert Uytterhoeven wrote:

> 
> Sorry, I completely missed that the Baboon case registers a 
> "pata_platform" device instead of a "macide" device.  Hence please 
> ignore my comments related to that.  Sorry for the noise.
> 

No problem. That misunderstanding got me thinking about implications 
stemming from my patch that I may have overlooked. Here's what I found.

1) Your presumption that the old macide driver would keep supporting all 
variants does make sense, as that would delay disruption for as long as 
possible (i.e. for as long as the IDE subsystem remains).

However, if my patch does not get merged until 2021, that disruption would 
not arrive earlier than promised by commit 7ad19a99ad431 ("ide: officially 
deprecated the legacy IDE driver").

2) My patch omitted a mac_defconfig update that would enable an 
alternative driver for the Baboon case. I will remedy this in v2.

3) It turns out that the Debian/m68k kernel config has 
CONFIG_BLK_DEV_PLATFORM=m. This will work fine with this patch. (I assume 
that Debian developers will replace CONFIG_BLK_DEV_PLATFORM with 
CONFIG_PATA_PLATFORM prior to the removal of the IDE subsystem next year.)
