Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8ADC433ED
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD86D61283
	for <linux-ide@archiver.kernel.org>; Mon,  3 May 2021 20:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhECVAH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 May 2021 17:00:07 -0400
Received: from elvis.franken.de ([193.175.24.41]:33736 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhECVAH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 3 May 2021 17:00:07 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ldfep-0008CS-00; Mon, 03 May 2021 22:59:11 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E9A48C0DC3; Mon,  3 May 2021 22:58:58 +0200 (CEST)
Date:   Mon, 3 May 2021 22:58:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: ata: Add device tree binding fir
 Mikrotik RB532 PATA controller
Message-ID: <20210503205858.GA14364@alpha.franken.de>
References: <20210428163336.73125-1-tsbogend@alpha.franken.de>
 <20210428163336.73125-3-tsbogend@alpha.franken.de>
 <20210503192805.GA2232229@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503192805.GA2232229@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, May 03, 2021 at 02:28:05PM -0500, Rob Herring wrote:
> On Wed, Apr 28, 2021 at 06:33:36PM +0200, Thomas Bogendoerfer wrote:
> > Add YAML devicetree binding for Mikrotik RB532 PATA controller.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> >  .../bindings/ata/mikrotek,rb532-pata.yaml     | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> > new file mode 100644
> > index 000000000000..f74880c4fd82
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/mikrotek,rb532-pata.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/mikrotek,rb532-pata.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mikrotek RB532 PATA Controller bindings
> 
> We have a common binding for this (ata/pata-common.yaml). Really, all 
> you'd gain is how to support 2 devices is defined. Should you use that? 
> Is CompactFlash only a single device, I don't remember. If so, is that a 
> limitation for the board or could 2 devices be supported?

there is only one device possible. So what do I need to put into the
yaml file for the driver ?  

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
